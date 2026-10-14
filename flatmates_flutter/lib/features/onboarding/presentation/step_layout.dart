import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// A step's layout: [art], a big [title], [body] and [content] in a scroll,
/// then the [action] and an optional quieter [secondary] at the bottom.
class StepLayout extends StatelessWidget {
  const StepLayout({
    super.key,
    this.art,
    this.title,
    this.body,
    this.content,
    required this.action,
    this.secondary,
  });

  final Widget? art;
  final String? title;
  final String? body;
  final Widget? content;
  final Widget action;
  final Widget? secondary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: Space.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: Space.lg,
              children: [
                ?art,
                if (title != null)
                  Semantics(
                    header: true,
                    child: Text(
                      title!,
                      style: context.text.displaySmall?.copyWith(
                        fontSize: 34,
                        height: 1.05,
                      ),
                    ),
                  ),
                if (body != null)
                  Text(
                    body!,
                    style: context.text.bodyLarge?.copyWith(
                      color: context.fm.inkSoft,
                    ),
                  ),
                ?content,
              ],
            ),
          ),
        ),
        action,
        if (secondary != null) ...[
          const SizedBox(height: Space.sm),
          Center(child: secondary),
        ],
      ],
    );
  }
}
