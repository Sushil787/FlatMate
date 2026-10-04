import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/action_runner.dart';
import '../../../core/widgets/illustration.dart';
import '../../auth/application/auth_controller.dart';
import '../application/my_flat_controller.dart';

enum _Mode { join, create }

/// Join a Flat with an Invite code, or create one and become its Admin.
@RoutePage()
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _flatName = TextEditingController();
  final _code = TextEditingController();
  _Mode _mode = _Mode.join;
  bool _busy = false;

  @override
  void dispose() {
    _name.dispose();
    _flatName.dispose();
    _code.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _busy = true);
    final controller = ref.read(myFlatControllerProvider.notifier);
    await runAction(
      context,
      () => _mode == _Mode.join
          ? controller.join(inviteCode: _code.text, myName: _name.text)
          : controller.create(flatName: _flatName.text, myName: _name.text),
    );
    if (mounted) setState(() => _busy = false);
  }

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Required' : null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
            child: const Text('Sign out'),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(Insets.xl),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(
                      child: Illustration(icon: Icons.cottage_rounded, size: 140),
                    ),
                    const SizedBox(height: Insets.lg),
                    Text(
                      'Let\'s set up your home',
                      style: theme.textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Insets.xs),
                    Text(
                      'Join your flatmates, or start a new flat and invite them.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Insets.xl),
                    Row(
                      children: [
                        Expanded(
                          child: _ModeCard(
                            icon: Icons.key_rounded,
                            title: 'Join a flat',
                            subtitle: 'I have a code',
                            selected: _mode == _Mode.join,
                            onTap: () => setState(() => _mode = _Mode.join),
                          ),
                        ),
                        const SizedBox(width: Insets.md),
                        Expanded(
                          child: _ModeCard(
                            icon: Icons.add_home_rounded,
                            title: 'Start a flat',
                            subtitle: 'I\'ll be admin',
                            selected: _mode == _Mode.create,
                            onTap: () => setState(() => _mode = _Mode.create),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Insets.xl),
                    TextFormField(
                      controller: _name,
                      validator: _required,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'Your name',
                        prefixIcon: Icon(Icons.person_rounded),
                      ),
                    ),
                    const SizedBox(height: Insets.md),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: _mode == _Mode.join
                          ? TextFormField(
                              key: const ValueKey('code'),
                              controller: _code,
                              validator: _required,
                              textCapitalization: TextCapitalization.characters,
                              decoration: const InputDecoration(
                                labelText: 'Invite code',
                                helperText: 'Ask your flat\'s admin for it.',
                                prefixIcon: Icon(Icons.vpn_key_rounded),
                              ),
                            )
                          : TextFormField(
                              key: const ValueKey('flat'),
                              controller: _flatName,
                              validator: _required,
                              textCapitalization: TextCapitalization.words,
                              decoration: const InputDecoration(
                                labelText: 'Flat name',
                                helperText: 'e.g. Elm Street House',
                                prefixIcon: Icon(Icons.home_rounded),
                              ),
                            ),
                    ),
                    const SizedBox(height: Insets.xl),
                    FilledButton(
                      onPressed: _busy ? null : _submit,
                      child: _busy
                          ? const SizedBox.square(
                              dimension: 22,
                              child: CircularProgressIndicator(strokeWidth: 2.5),
                            )
                          : Text(_mode == _Mode.join ? 'Join flat' : 'Create flat'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  const _ModeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: selected ? scheme.primaryContainer : scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(Radii.lg),
        border: Border.all(
          color: selected ? scheme.primary : scheme.outlineVariant,
          width: selected ? 2 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(Radii.lg),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: selected ? scheme.primary : scheme.onSurfaceVariant),
              const SizedBox(height: Insets.md),
              Text(title, style: text.titleMedium),
              Text(
                subtitle,
                style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
