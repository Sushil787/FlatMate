import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/action_runner.dart';
import '../../../core/utils/day.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_field.dart';
import '../../../core/widgets/app_sheet.dart';
import '../../../core/widgets/mate_avatar.dart';
import '../../flat/application/mate_directory.dart';
import '../application/chore_actions.dart';
import '../application/chores_controller.dart';
import '../../../core/widgets/app_icon.dart';

/// Admin only: creates a Chore ([name] pre-fills it), or edits [choreId].
Future<void> showChoreEditor(
  BuildContext context, {
  int? choreId,
  String? name,
}) => showAppSheet(context, _ChoreEditor(choreId: choreId, name: name));

class _ChoreEditor extends ConsumerStatefulWidget {
  const _ChoreEditor({this.choreId, this.name});

  final int? choreId;
  final String? name;

  @override
  ConsumerState<_ChoreEditor> createState() => _ChoreEditorState();
}

class _ChoreEditorState extends ConsumerState<_ChoreEditor> {
  final _name = TextEditingController();
  int _days = 7;
  bool _custom = false;
  DateTime _start = DateUtils.dateOnly(DateTime.now());
  List<int> _rotation = [];
  Chore? _chore;
  String? _error;

  /// Set once saved or deleted, so the buttons stay off while the sheet
  /// slides away.
  bool _closing = false;

  bool get _isNew => widget.choreId == null;

  @override
  void initState() {
    super.initState();
    final chore = _isNew
        ? null
        : ref.read(choresControllerProvider).value?.choreById(widget.choreId!);
    _chore = chore;
    if (chore != null) {
      _name.text = chore.name;
      _days = chore.period.inDays;
      _custom = !_presets.containsKey(_days);
      _rotation = [...chore.rotation];
    } else {
      _name.text = widget.name ?? '';
      // Default: everyone, in the order they joined.
      _rotation = [
        for (final m in ref.read(mateDirectoryProvider).mates) m.id!,
      ];
    }
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  static const _presets = {1: 'Every day', 3: '3 days', 7: 'Weekly'};

  Future<void> _pickStart() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _start,
      firstDate: DateUtils.dateOnly(DateTime.now()),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null && mounted) setState(() => _start = date);
  }

  // Errors show in the sheet: a snackbar would sit behind it.
  Future<void> _run(Future<bool> Function() action) async {
    setState(() => _error = null);
    try {
      if (!await action() || !mounted) return;
      setState(() => _closing = true);
      Navigator.pop(context);
    } catch (e) {
      if (mounted) setState(() => _error = describeError(e));
    }
  }

  void _save() {
    final name = _name.text.trim();
    if (name.isEmpty) return setState(() => _error = 'Give the Chore a name.');
    if (_rotation.isEmpty) {
      return setState(() => _error = 'Add at least one Mate to the Rotation.');
    }
    final save = ref.read(saveChoreProvider.notifier);
    final period = Duration(days: _days);
    _run(
      () => _isNew
          ? save.create(
              name: name,
              period: period,
              startDay: Day.fromLocal(_start),
              rotation: _rotation,
            )
          : save.save(
              choreId: widget.choreId!,
              name: name,
              period: period,
              rotation: _rotation,
            ),
    );
  }

  Future<void> _delete() async {
    final yes = await confirm(
      context,
      title: 'Delete ${_chore!.name}?',
      message: 'The current Turn is cancelled and the Rotation stops.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (!yes || !mounted) return;
    _run(() => ref.read(archiveChoreProvider(_chore!.id!).notifier).run());
  }

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    final directory = ref.watch(mateDirectoryProvider);
    final saving = ref.watch(saveChoreProvider).isLoading;
    final deleting =
        _chore != null &&
        ref.watch(archiveChoreProvider(_chore!.id!)).isLoading;
    final busy = saving || deleting || _closing;
    final label = context.text.bodySmall?.copyWith(fontWeight: FontWeight.w600);
    final mates = _rotation.toSet().length;

    if (!_isNew && _chore == null) {
      return const AppSheet(
        title: 'Edit Chore',
        children: [Text('This Chore no longer exists.')],
      );
    }

    return AppSheet(
      title: _isNew ? 'New Chore' : 'Edit Chore',
      action: PrimaryButton(
        label: 'Save Chore',
        busy: saving,
        onPressed: busy ? null : _save,
      ),
      children: [
        AppField(
          label: 'Chore name',
          controller: _name,
          hint: 'Take out bins',
          autofocus: _isNew && _name.text.isEmpty,
          textInputAction: TextInputAction.done,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 6,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Rotation · drag to reorder', style: label),
                ),
                Text('$mates ${mates == 1 ? 'Mate' : 'Mates'}', style: label),
              ],
            ),
            _RotationEditor(
              rotation: _rotation,
              onChanged: (r) => setState(() => _rotation = r),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 6,
          children: [
            Text('Rotation period', style: label),
            _PeriodChips(
              options: [
                for (final MapEntry(:key, :value) in _presets.entries)
                  (
                    value,
                    !_custom && _days == key,
                    () {
                      setState(() {
                        _custom = false;
                        _days = key;
                      });
                    },
                  ),
                ('Custom', _custom, () => setState(() => _custom = true)),
              ],
            ),
            if (_custom)
              _DaysStepper(
                days: _days,
                onChanged: (d) => setState(() => _days = d),
              ),
          ],
        ),
        if (_isNew)
          Material(
            color: fm.ground,
            borderRadius: BorderRadius.circular(Radii.input),
            child: InkWell(
              onTap: _pickStart,
              borderRadius: BorderRadius.circular(Radii.input),
              child: Container(
                constraints: const BoxConstraints(minHeight: 52),
                padding: const EdgeInsets.symmetric(
                  horizontal: Space.lg,
                  vertical: Space.sm,
                ),
                child: Row(
                  children: [
                    Text('Start date', style: context.text.bodySmall),
                    const SizedBox(width: Space.md),
                    Expanded(
                      child: Text(
                        [
                          Fmt.day(_start),
                          if (_rotation.isNotEmpty)
                            '${directory.nameOf(_rotation.first)} '
                                '${directory.isMe(_rotation.first) ? 'go' : 'goes'} first',
                        ].join(' · '),
                        textAlign: TextAlign.end,
                        style: context.text.titleSmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        else ...[
          Text(
            'Changes apply from the next Turn. The current one finishes as planned.',
            style: context.text.bodySmall,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: busy ? null : _delete,
              style: TextButton.styleFrom(
                foregroundColor: fm.dangerFg,
                padding: EdgeInsets.zero,
              ),
              child: const Text('Delete Chore'),
            ),
          ),
        ],
        if (_error != null)
          Semantics(
            liveRegion: true,
            child: Text(
              _error!,
              style: context.text.bodySmall?.copyWith(
                color: fm.dangerFg,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}

/// The Rotation as tiles in a row: long-press to drag, tap to take a Mate
/// out, + to add any Mate (again).
class _RotationEditor extends ConsumerWidget {
  const _RotationEditor({required this.rotation, required this.onChanged});

  final List<int> rotation;
  final ValueChanged<List<int>> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fm = context.fm;
    final directory = ref.watch(mateDirectoryProvider);
    final scaler = MediaQuery.textScalerOf(context);
    // Avatar, gap and padding, plus one line of label.
    final height = 48 + scaler.scale(16);
    final style = context.text.labelMedium?.copyWith(
      fontWeight: FontWeight.w600,
    );

    Widget tile(Widget child) => Container(
      width: scaler.scale(80),
      height: height,
      decoration: BoxDecoration(
        color: fm.ground,
        borderRadius: BorderRadius.circular(Radii.input),
      ),
      child: child,
    );

    return SizedBox(
      height: height,
      child: ReorderableListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: rotation.length,
        onReorderItem: (from, to) {
          final next = [...rotation];
          next.insert(to, next.removeAt(from));
          onChanged(next);
        },
        footer: tile(
          PopupMenuButton<int>(
            tooltip: 'Add a Mate to the Rotation',
            onSelected: (id) => onChanged([...rotation, id]),
            itemBuilder: (_) => [
              for (final m in directory.mates)
                PopupMenuItem(value: m.id, child: Text(m.displayName)),
            ],
            child: Center(
              child: AppIcon(HugeIcons.strokeRoundedAdd01, color: fm.inkSoft),
            ),
          ),
        ),
        itemBuilder: (context, i) {
          final id = rotation[i];
          final name = directory.nameOf(id);
          return Padding(
            key: ValueKey('$i-$id'),
            padding: const EdgeInsets.only(right: Space.sm),
            child: tile(
              PopupMenuButton<bool>(
                tooltip: '${i + 1}, $name',
                onSelected: (_) => onChanged([...rotation]..removeAt(i)),
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: true,
                    child: Text('Take $name out of the Rotation'),
                  ),
                ],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 2,
                  children: [
                    MateAvatar(id, size: 28),
                    Text(
                      '${i + 1} · $name',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: style,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Equal-width choice pills; two per row when the text is large.
class _PeriodChips extends StatelessWidget {
  const _PeriodChips({required this.options});

  final List<(String, bool, VoidCallback)> options;

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    final perRow = MediaQuery.textScalerOf(context).scale(1) > 1.3 ? 2 : 4;
    return LayoutBuilder(
      builder: (context, box) {
        final width = (box.maxWidth - 6 * (perRow - 1)) / perRow;
        return Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final (label, selected, onTap) in options)
              SizedBox(
                width: width,
                child: Semantics(
                  selected: selected,
                  child: OutlinedButton(
                    onPressed: onTap,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(Sizes.touchMin),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      backgroundColor: selected ? fm.ink : fm.surface,
                      foregroundColor: selected ? fm.ground : fm.ink,
                      side: BorderSide(
                        color: selected ? fm.ink : fm.line,
                        width: 2,
                      ),
                      textStyle: context.text.bodySmall?.copyWith(
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w600,
                      ),
                    ),
                    child: Text(label, textAlign: TextAlign.center),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// A custom Rotation period: − Every 5 days +.
class _DaysStepper extends StatelessWidget {
  const _DaysStepper({required this.days, required this.onChanged});

  final int days;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final style = IconButton.styleFrom(backgroundColor: context.fm.fillQuiet);
    return Row(
      children: [
        IconButton(
          tooltip: 'One day less',
          style: style,
          onPressed: days > 1 ? () => onChanged(days - 1) : null,
          icon: const AppIcon(HugeIcons.strokeRoundedMinusSign),
        ),
        Expanded(
          child: Text(
            'Every ${Fmt.period(Duration(days: days))}',
            textAlign: TextAlign.center,
            style: context.text.titleSmall,
          ),
        ),
        IconButton(
          tooltip: 'One day more',
          style: style,
          onPressed: days < 365 ? () => onChanged(days + 1) : null,
          icon: const AppIcon(HugeIcons.strokeRoundedAdd01),
        ),
      ],
    );
  }
}
