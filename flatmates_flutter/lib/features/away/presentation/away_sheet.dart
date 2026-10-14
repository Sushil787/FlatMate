import 'package:flatmates_client/flatmates_client.dart';
import 'package:flatmates_shared/flatmates_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/action_runner.dart';
import '../../../core/utils/day.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_sheet.dart';
import '../../../core/widgets/layout.dart';
import '../../../core/widgets/tag.dart';
import '../../calendar/presentation/widgets/month_grid.dart';
import '../../chores/application/chores_controller.dart';
import '../../flat/application/mate_directory.dart';
import '../application/away_actions.dart';
import '../application/aways_controller.dart';
import 'away_rule_text.dart';
import '../../../core/widgets/app_icon.dart';

/// Opens the "Mark myself Away" sheet. A Mate's own Aways can be cancelled
/// from their row on the Calendar.
Future<void> showAwaySheet(BuildContext context) =>
    showAppSheet(context, const _AwaySheet());

class _AwaySheet extends ConsumerStatefulWidget {
  const _AwaySheet();

  @override
  ConsumerState<_AwaySheet> createState() => _AwaySheetState();
}

class _AwaySheetState extends ConsumerState<_AwaySheet> {
  final _today = DateUtils.dateOnly(DateTime.now());
  late DateTime _from = _today;

  /// The day the user is back: the day after the last Away day.
  late DateTime _backOn = _next(_today);
  bool _editingBackOn = false;
  late DateTime _month = DateTime(_today.year, _today.month);

  /// Set once saved, so the button stays off while the sheet slides away.
  bool _closing = false;

  static DateTime _next(DateTime d) => DateTime(d.year, d.month, d.day + 1);
  DateTime get _lastDay =>
      DateTime(_backOn.year, _backOn.month, _backOn.day - 1);

  void _tap(DateTime d) => setState(() {
    if (_editingBackOn && d.isAfter(_from)) {
      _backOn = d;
      return;
    }
    _from = d;
    if (!_backOn.isAfter(d)) _backOn = _next(d);
    _editingBackOn = true;
  });

  Future<void> _save() async {
    final ok = await runAction(
      context,
      () => ref
          .read(markAwayProvider.notifier)
          .run(Day.fromLocal(_from), Day.fromLocal(_lastDay)),
      success: 'You\'re marked Away. Have a good trip!',
    );
    if (!ok || !mounted) return;
    setState(() => _closing = true);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    final days = daysBetween(_from, _backOn);
    final firstMonth = DateTime(_today.year, _today.month);

    return AppSheet(
      title: 'Mark myself Away',
      action: PrimaryButton(
        label: 'Mark me Away',
        busy: ref.watch(markAwayProvider).isLoading,
        onPressed: _closing ? null : _save,
      ),
      children: [
        Row(
          spacing: Space.sm,
          children: [
            Expanded(
              child: _DateBox(
                label: 'From',
                day: _from,
                active: !_editingBackOn,
                onTap: () => setState(() {
                  _editingBackOn = false;
                  _month = DateTime(_from.year, _from.month);
                }),
              ),
            ),
            Expanded(
              child: _DateBox(
                label: 'Back on',
                day: _backOn,
                active: _editingBackOn,
                onTap: () => setState(() {
                  _editingBackOn = true;
                  _month = DateTime(_backOn.year, _backOn.month);
                }),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(6, 0, 6, 10),
          decoration: BoxDecoration(
            color: fm.ground,
            borderRadius: BorderRadius.circular(Radii.input),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    tooltip: 'Previous month',
                    icon: const AppIcon(HugeIcons.strokeRoundedArrowLeft01),
                    onPressed: _month.isAfter(firstMonth)
                        ? () => setState(
                            () => _month = DateTime(
                              _month.year,
                              _month.month - 1,
                            ),
                          )
                        : null,
                  ),
                  Expanded(
                    child: Text(
                      DateFormat('MMMM y').format(_month),
                      textAlign: TextAlign.center,
                      style: context.text.titleSmall,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Next month',
                    icon: const AppIcon(HugeIcons.strokeRoundedArrowRight01),
                    onPressed: () => setState(
                      () => _month = DateTime(_month.year, _month.month + 1),
                    ),
                  ),
                ],
              ),
              MonthGrid(month: _month, cell: _cell),
            ],
          ),
        ),
        Text(
          '${days == 1 ? 'Away for 1 day' : 'Away for $days days'}'
          ' · ${dayRange(_from, _lastDay)}',
          style: context.text.bodyMedium?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: fm.awayFg,
          ),
        ),
        _Preview(from: _from, lastDay: _lastDay),
      ],
    );
  }

  Widget _cell(DateTime d) {
    final fm = context.fm;
    final inRange = !d.isBefore(_from) && !d.isAfter(_lastDay);
    final isStart = DateUtils.isSameDay(d, _from);
    final isEnd = DateUtils.isSameDay(d, _lastDay);
    // Days already in one of my Aways can't be picked again either.
    final me = ref.watch(mateDirectoryProvider).me.id;
    final day = Day.fromLocal(d);
    final taken = (ref.watch(awaysControllerProvider).value ?? const []).any(
      (a) =>
          a.mateId == me &&
          !day.isBefore(a.startDay) &&
          !day.isAfter(a.lastDay),
    );
    final past = d.isBefore(_today) || taken;
    const round = Radius.circular(20);
    return Semantics(
      button: !past,
      selected: inRange,
      excludeSemantics: true,
      label: DateFormat('EEEE d MMMM').format(d),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: past ? null : () => _tap(d),
        child: Container(
          constraints: const BoxConstraints(minHeight: Sizes.touchMin),
          margin: const EdgeInsets.symmetric(vertical: 2),
          alignment: Alignment.center,
          decoration: inRange
              ? BoxDecoration(
                  color: isStart || isEnd ? fm.awayFg : fm.awayBg,
                  borderRadius: BorderRadius.horizontal(
                    left: isStart ? round : Radius.zero,
                    right: isEnd ? round : Radius.zero,
                  ),
                )
              : null,
          child: Text(
            '${d.day}',
            style: context.text.titleSmall?.copyWith(
              color: isStart || isEnd
                  ? fm.surface
                  : inRange
                  ? fm.awayFg
                  : past
                  ? fm.inkSoft
                  : fm.ink,
            ),
          ),
        ),
      ),
    );
  }
}

class _DateBox extends StatelessWidget {
  const _DateBox({
    required this.label,
    required this.day,
    required this.active,
    required this.onTap,
  });

  final String label;
  final DateTime day;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    return Semantics(
      selected: active,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, Sizes.buttonHero),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          side: BorderSide(color: active ? fm.ink : fm.line, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radii.input),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: context.text.labelMedium?.copyWith(
                color: fm.inkSoft,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              Fmt.day(day),
              style: context.text.labelLarge?.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

/// "What happens to your Turns": each Turn the Away touches, under the
/// Flat's Away rule.
class _Preview extends ConsumerWidget {
  const _Preview({required this.from, required this.lastDay});

  final DateTime from;
  final DateTime lastDay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fm = context.fm;
    final directory = ref.watch(mateDirectoryProvider);
    final chores = ref.watch(choresControllerProvider).value;
    final preview = ref.watch(
      awayPreviewProvider((
        startDay: Day.fromLocal(from),
        lastDay: Day.fromLocal(lastDay),
      )),
    );
    String day(DateTime d) => DateFormat('EEE d').format(Day.local(d));

    String outcome(AwayEffect e) {
      if (e.coverMateId case final cover?) {
        final name = directory.realNameOf(cover);
        return e.awayRule == AwayRule.swap
            ? '$name covers ${day(e.day)}. You owe $name one back.'
            : 'Your Turn passes to $name.';
      }
      final newDay = e.newDay ?? e.day;
      return newDay == e.day
          ? 'Your Turn runs until ${day(e.newLastDay ?? e.day)}.'
          : 'Waits for you until ${day(newDay)}.';
    }

    final Widget body = switch (preview) {
      AsyncData(:final value) when value.isEmpty => const _Message(
        'None of your Turns fall on these days.',
      ),
      AsyncData(:final value) => RowCard(
        color: fm.ground,
        children: [
          for (final e in value)
            AppRow(
              minHeight: 52,
              title: Text(chores?.choreById(e.choreId)?.name ?? 'Chore'),
              meta: Text(outcome(e)),
              trailing: Tag(e.awayRule.label, tone: TagTone.plain),
            ),
        ],
      ),
      AsyncError(:final error) => _Message(describeError(error)),
      _ => const Padding(
        padding: EdgeInsets.all(Space.lg),
        child: Center(
          child: SizedBox.square(
            dimension: 22,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          ),
        ),
      ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 6,
      children: [
        Text(
          'What happens to your Turns',
          style: context.text.bodySmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        body,
      ],
    );
  }
}

/// A one-line message in the preview's place.
class _Message extends StatelessWidget {
  const _Message(this.message);

  final String message;

  @override
  Widget build(BuildContext context) => RowCard(
    color: context.fm.ground,
    children: [AppRow(minHeight: 52, title: Text(message))],
  );
}
