import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/action_runner.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_field.dart';
import '../../../../core/widgets/app_sheet.dart';
import '../../../../core/widgets/layout.dart';
import '../../application/event_actions.dart';
import 'month_grid.dart';

/// Opens the Add Event sheet, on [day] (today by default).
Future<void> showAddEventSheet(BuildContext context, {DateTime? day}) =>
    showAppSheet(context, _AddEventSheet(day: day));

class _AddEventSheet extends ConsumerStatefulWidget {
  const _AddEventSheet({this.day});

  final DateTime? day;

  @override
  ConsumerState<_AddEventSheet> createState() => _AddEventSheetState();
}

class _AddEventSheetState extends ConsumerState<_AddEventSheet> {
  final _title = TextEditingController();
  final _note = TextEditingController();
  final _today = DateUtils.dateOnly(DateTime.now());
  late DateTime _date = DateUtils.dateOnly(widget.day ?? _today);
  bool _allDay = true;
  TimeOfDay _time = const TimeOfDay(hour: 19, minute: 0);

  /// The last day of a multi-day Event; null for a single day.
  DateTime? _lastDay;
  bool _tellFlat = true;

  /// Set once added, so the button stays off while the sheet slides away.
  bool _closing = false;

  @override
  void dispose() {
    _title.dispose();
    _note.dispose();
    super.dispose();
  }

  DateTime _plus(int days) =>
      DateTime(_today.year, _today.month, _today.day + days);

  void _setDate(DateTime d) => setState(() {
    _date = d;
    if (_lastDay != null && !_lastDay!.isAfter(d)) _lastDay = null;
  });

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: _today,
      lastDate: _plus(365),
    );
    if (d != null) _setDate(d);
  }

  Future<void> _pickTime() async {
    final t = await showTimePicker(context: context, initialTime: _time);
    if (t != null) setState(() => _time = t);
  }

  Future<void> _pickEnd() async {
    final d = await showDatePicker(
      context: context,
      helpText: 'Ends',
      initialDate: _lastDay ?? _date,
      firstDate: _date,
      lastDate: _plus(365),
    );
    if (d != null) setState(() => _lastDay = d == _date ? null : d);
  }

  Future<void> _save() async {
    final note = _note.text.trim();
    final last = _lastDay;
    final ok = await runAction(
      context,
      () => ref
          .read(addEventProvider.notifier)
          .run(
            title: _title.text.trim(),
            note: note.isEmpty ? null : note,
            startsAt: _allDay
                ? _date
                : _date.copyWith(hour: _time.hour, minute: _time.minute),
            allDay: _allDay,
            // Local midnight after the last day.
            endsAt: last == null
                ? null
                : DateTime(last.year, last.month, last.day + 1),
            tellFlat: _tellFlat,
          ),
      success: 'Event added',
    );
    if (!ok || !mounted) return;
    setState(() => _closing = true);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    var saturday = _plus(2);
    while (saturday.weekday != DateTime.saturday) {
      saturday = saturday.add(const Duration(days: 1));
    }
    final presets = [
      ('Today', _today),
      ('Tomorrow', _plus(1)),
      (Fmt.day(saturday), saturday),
    ];
    final picked = !presets.any((p) => p.$2 == _date);
    final value = context.text.bodyMedium?.copyWith(color: fm.inkSoft);

    Widget toggle(String label, bool on, ValueChanged<bool> set) =>
        MergeSemantics(
          child: AppRow(
            minHeight: 52,
            onTap: () => set(!on),
            title: Text(label),
            trailing: Switch(value: on, onChanged: set),
          ),
        );

    return AppSheet(
      title: 'Add Event',
      action: PrimaryButton(
        label: 'Add Event',
        busy: ref.watch(addEventProvider).isLoading,
        onPressed: _title.text.trim().isEmpty || _closing ? null : _save,
      ),
      children: [
        AppField(
          label: 'What\'s happening?',
          hint: 'Plumber visit',
          controller: _title,
          autofocus: true,
          textInputAction: TextInputAction.next,
          onChanged: (_) => setState(() {}),
        ),
        Wrap(
          spacing: Space.sm,
          runSpacing: Space.sm,
          children: [
            for (final (label, day) in presets)
              ChoicePill(
                label: label,
                selected: day == _date,
                fill: fm.ground,
                height: Sizes.touchMin,
                onTap: () => _setDate(day),
              ),
            ChoicePill(
              label: picked ? Fmt.day(_date) : 'Pick date',
              selected: picked,
              fill: fm.ground,
              height: Sizes.touchMin,
              onTap: _pickDate,
            ),
          ],
        ),
        RowCard(
          color: fm.ground,
          children: [
            toggle('All day', _allDay, (v) => setState(() => _allDay = v)),
            if (!_allDay)
              AppRow(
                minHeight: 52,
                onTap: _pickTime,
                title: const Text('Starts'),
                trailing: Text(_time.format(context), style: value),
              ),
            AppRow(
              minHeight: 52,
              onTap: _pickEnd,
              title: const Text('Ends'),
              trailing: Text(
                _lastDay == null ? 'Same day' : dayRange(_date, _lastDay!),
                style: value,
              ),
            ),
            toggle(
              'Tell the Flat',
              _tellFlat,
              (v) => setState(() => _tellFlat = v),
            ),
          ],
        ),
        AppField(
          label: 'Note (optional)',
          controller: _note,
          maxLines: 3,
        ),
      ],
    );
  }
}
