import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';

import '../../../../core/utils/action_runner.dart';
import '../../../../core/widgets/app_field.dart';
import '../../../../core/widgets/app_sheet.dart';

/// Opens a sheet to change a name (the Flat's or my own); closes once
/// [save] succeeds. [saving] is the save action's state, for its spinner.
/// [save] must read the action's notifier when called, not when the sheet
/// opens: an autoDispose action nobody watches yet is disposed in between.
Future<void> showNameSheet(
  BuildContext context, {
  required String title,
  required String label,
  required String initial,
  required ProviderListenable<AsyncValue<void>> saving,
  required Future<bool> Function(String name) save,
}) => showAppSheet(
  context,
  _NameSheet(
    title: title,
    label: label,
    initial: initial,
    saving: saving,
    save: save,
  ),
);

class _NameSheet extends ConsumerStatefulWidget {
  const _NameSheet({
    required this.title,
    required this.label,
    required this.initial,
    required this.saving,
    required this.save,
  });

  final String title;
  final String label;
  final String initial;
  final ProviderListenable<AsyncValue<void>> saving;
  final Future<bool> Function(String name) save;

  @override
  ConsumerState<_NameSheet> createState() => _NameSheetState();
}

class _NameSheetState extends ConsumerState<_NameSheet> {
  late final _name = TextEditingController(text: widget.initial);

  /// Set once saved, so the button stays off while the sheet slides away.
  bool _closing = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_name.text.trim().isEmpty || _closing) return;
    final ok = await runAction(context, () => widget.save(_name.text.trim()));
    if (!ok || !mounted) return;
    setState(() => _closing = true);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      title: widget.title,
      action: PrimaryButton(
        label: 'Save',
        busy: ref.watch(widget.saving).isLoading,
        onPressed: _closing ? null : _save,
      ),
      children: [
        AppField(
          label: widget.label,
          controller: _name,
          autofocus: true,
          maxLength: 60,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _save(),
        ),
      ],
    );
  }
}
