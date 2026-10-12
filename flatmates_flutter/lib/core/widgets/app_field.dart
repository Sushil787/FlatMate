import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// A labelled text input: 2px line border, ink border plus a 3px lime ring
/// when focused, danger border and message on error.
class AppField extends StatefulWidget {
  const AppField({
    super.key,
    this.label,
    this.controller,
    this.hint,
    this.errorText,
    this.maxLines = 1,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.sentences,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.maxLength,
    this.fillColor,
    this.radius = Radii.input,
  });

  final String? label;
  final TextEditingController? controller;
  final String? hint;
  final String? errorText;
  final int maxLines;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  /// Pass one (even a no-op) to keep the keyboard open after submitting.
  final VoidCallback? onEditingComplete;
  final int? maxLength;
  final Color? fillColor;

  /// Corner radius; a docked composer is a pill (28).
  final double radius;

  @override
  State<AppField> createState() => _AppFieldState();
}

class _AppFieldState extends State<AppField> {
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    final ring = _focus.hasFocus && widget.errorText == null;
    final borders = Theme.of(context).inputDecorationTheme;
    InputBorder? shaped(InputBorder? b) => (b as OutlineInputBorder?)?.copyWith(
      borderRadius: BorderRadius.circular(widget.radius),
    );
    final field = AnimatedContainer(
      duration: Timing.standard,
      curve: Timing.curve,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius),
        boxShadow: [
          if (ring) BoxShadow(color: fm.primary, spreadRadius: 3),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: _focus,
        autofocus: widget.autofocus,
        maxLines: widget.maxLines,
        minLines: 1,
        maxLength: widget.maxLength,
        textCapitalization: widget.textCapitalization,
        textInputAction: widget.textInputAction,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        onEditingComplete: widget.onEditingComplete,
        style: context.text.bodyLarge,
        decoration: InputDecoration(
          hintText: widget.hint,
          errorText: widget.errorText,
          counterText: '',
          fillColor: widget.fillColor,
          enabledBorder: shaped(borders.enabledBorder),
          focusedBorder: shaped(borders.focusedBorder),
          errorBorder: shaped(borders.errorBorder),
          focusedErrorBorder: shaped(borders.focusedErrorBorder),
        ),
      ),
    );
    if (widget.label == null) return field;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label!,
          style: context.text.bodySmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        field,
      ],
    );
  }
}
