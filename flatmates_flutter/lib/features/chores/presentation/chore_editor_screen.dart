import 'package:auto_route/auto_route.dart';
import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/day.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/action_runner.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/section_header.dart';
import '../../flat/application/mate_directory.dart';
import '../application/chores_controller.dart';
import 'widgets/period_field.dart';
import 'widgets/rotation_editor.dart';

/// Admin-only: create a Chore, or edit one (changes apply from the next
/// Turn).
@RoutePage()
class ChoreEditorScreen extends ConsumerStatefulWidget {
  const ChoreEditorScreen({super.key, this.choreId});

  /// The Chore to edit; null to create a new one.
  final int? choreId;

  @override
  ConsumerState<ChoreEditorScreen> createState() => _ChoreEditorScreenState();
}

class _ChoreEditorScreenState extends ConsumerState<ChoreEditorScreen> {
  final _name = TextEditingController();
  Duration _period = const Duration(days: 7);
  DateTime _startsAt = DateUtils.dateOnly(DateTime.now());
  List<int> _rotation = [];
  Chore? _chore;
  bool _busy = false;

  bool get _isNew => widget.choreId == null;

  @override
  void initState() {
    super.initState();
    final overview = ref.read(choresControllerProvider).value;
    final chore = widget.choreId == null
        ? null
        : overview?.choreById(widget.choreId!);
    _chore = chore;
    if (chore != null) {
      _name.text = chore.name;
      _period = chore.period;
      _rotation = [...chore.rotation];
    } else {
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

  Future<void> _pickStart() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _startsAt,
      firstDate: DateUtils.dateOnly(DateTime.now()),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    // A Turn is a whole local day, so the date is local midnight.
    if (date != null && mounted) setState(() => _startsAt = date);
  }

  Future<void> _save() async {
    setState(() => _busy = true);
    final controller = ref.read(choresControllerProvider.notifier);
    final ok = await runAction(
      context,
      () => _isNew
          ? controller.create(
              name: _name.text,
              period: _period,
              startDay: Day.fromLocal(_startsAt),
              rotation: _rotation,
            )
          : controller.save(
              choreId: widget.choreId!,
              name: _name.text,
              period: _period,
              rotation: _rotation,
            ),
      success: _isNew ? 'Chore created' : 'Changes saved',
    );
    if (!mounted) return;
    setState(() => _busy = false);
    if (ok) context.router.maybePop();
  }

  Future<void> _delete() async {
    final yes = await confirm(
      context,
      title: 'Delete ${_chore!.name}?',
      message: 'The current turn is cancelled and the rotation stops.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (!yes || !mounted) return;
    final ok = await runAction(
      context,
      () => ref.read(choresControllerProvider.notifier).archive(_chore!.id!),
      success: 'Chore deleted',
    );
    if (ok && mounted) context.router.maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (!_isNew && _chore == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('This chore no longer exists.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? 'New chore' : 'Edit chore'),
        actions: [
          if (!_isNew)
            IconButton(
              tooltip: 'Delete chore',
              onPressed: _delete,
              icon: const Icon(Icons.delete_outline_rounded),
            ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: FilledButton(
            onPressed: _busy ? null : _save,
            child: Text(_isNew ? 'Create chore' : 'Save changes'),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Insets.lg, 0, Insets.lg, Insets.xl),
        children: [
          TextField(
            controller: _name,
            textCapitalization: TextCapitalization.sentences,
            style: theme.textTheme.titleMedium,
            decoration: const InputDecoration(
              labelText: 'Chore',
              hintText: 'Take out the bins',
              prefixIcon: Icon(Icons.cleaning_services_rounded),
            ),
          ),
          const SectionHeader(
            'Repeats every',
            padding: EdgeInsets.fromLTRB(0, Insets.xl, 0, Insets.sm),
          ),
          PeriodField(
            value: _period,
            onChanged: (p) => setState(() => _period = p),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Insets.sm),
            child: Text(
              'Each turn lasts one day.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          if (_isNew) ...[
            const SectionHeader(
              'First turn on',
              padding: EdgeInsets.fromLTRB(0, Insets.xl, 0, Insets.sm),
            ),
            Material(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(Radii.md),
              child: ListTile(
                leading: const Icon(Icons.event_rounded),
                title: Text(Fmt.day(_startsAt)),
                trailing: const Icon(Icons.edit_calendar_rounded),
                onTap: _pickStart,
              ),
            ),
          ] else
            Padding(
              padding: const EdgeInsets.only(top: Insets.md),
              child: Text(
                'Changes apply from the next turn; the current one finishes as planned.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          const SectionHeader(
            'Rotation',
            padding: EdgeInsets.fromLTRB(0, Insets.xl, 0, Insets.xs),
          ),
          Text(
            'Turns go round in this order. Drag to reorder; add someone twice to give them more turns.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: Insets.md),
          RotationEditor(
            rotation: _rotation,
            onChanged: (r) => setState(() => _rotation = r),
          ),
        ],
      ),
    );
  }
}
