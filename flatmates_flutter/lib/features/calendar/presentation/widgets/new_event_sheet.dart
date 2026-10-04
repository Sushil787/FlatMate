import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/action_runner.dart';
import '../../../../core/utils/formatters.dart';
import '../../application/calendar_providers.dart';

/// Opens the sheet for adding an Event on [day].
Future<void> showNewEventSheet(BuildContext context, DateTime day) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _NewEventSheet(day: day),
    );

class _NewEventSheet extends ConsumerStatefulWidget {
  const _NewEventSheet({required this.day});

  final DateTime day;

  @override
  ConsumerState<_NewEventSheet> createState() => _NewEventSheetState();
}

class _NewEventSheetState extends ConsumerState<_NewEventSheet> {
  final _title = TextEditingController();
  final _note = TextEditingController();
  late DateTime _date = widget.day;
  TimeOfDay _time = const TimeOfDay(hour: 19, minute: 0);
  bool _busy = false;

  @override
  void dispose() {
    _title.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _busy = true);
    final startsAt = DateTime(
      _date.year,
      _date.month,
      _date.day,
      _time.hour,
      _time.minute,
    );
    final ok = await runAction(
      context,
      () => ref
          .read(eventsControllerProvider.notifier)
          .add(title: _title.text, note: _note.text, startsAt: startsAt),
      success: 'Event added',
    );
    if (!mounted) return;
    setState(() => _busy = false);
    if (ok) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Insets.xl,
            0,
            Insets.xl,
            Insets.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('New event', style: theme.textTheme.headlineSmall),
              const SizedBox(height: Insets.lg),
              TextField(
                controller: _title,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'What\'s happening?',
                  hintText: 'Plumber visit',
                  prefixIcon: Icon(Icons.celebration_rounded),
                ),
              ),
              const SizedBox(height: Insets.md),
              TextField(
                controller: _note,
                decoration: const InputDecoration(
                  labelText: 'Note (optional)',
                  prefixIcon: Icon(Icons.notes_rounded),
                ),
              ),
              const SizedBox(height: Insets.md),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.event_rounded),
                      label: Text(Fmt.day(_date)),
                      onPressed: () async {
                        final d = await showDatePicker(
                          context: context,
                          initialDate: _date,
                          firstDate: DateTime.now().subtract(
                            const Duration(days: 365),
                          ),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (d != null) setState(() => _date = d);
                      },
                    ),
                  ),
                  const SizedBox(width: Insets.md),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.schedule_rounded),
                      label: Text(_time.format(context)),
                      onPressed: () async {
                        final t = await showTimePicker(
                          context: context,
                          initialTime: _time,
                        );
                        if (t != null) setState(() => _time = t);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Insets.xl),
              FilledButton(
                onPressed: _busy ? null : _save,
                child: const Text('Add to calendar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
