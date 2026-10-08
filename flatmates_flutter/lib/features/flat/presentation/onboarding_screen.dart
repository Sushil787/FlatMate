import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/action_runner.dart';
import '../../../core/widgets/app_field.dart';
import '../../../core/widgets/app_sheet.dart';
import '../../../core/widgets/mate_avatar.dart';
import '../../auth/application/auth_controller.dart';
import '../application/flat_actions.dart';

/// Create a Flat (and become its Admin) or join one with an Invite code.
/// The Mate's name comes from their Google profile.
@RoutePage()
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _flatName = TextEditingController();
  final _code = TextEditingController();
  String? _flatError, _codeError;

  /// Set once in a Flat, so nothing can be sent again while Home loads.
  bool _done = false;

  @override
  void dispose() {
    _flatName.dispose();
    _code.dispose();
    super.dispose();
  }

  String get _myName {
    final p = ref.read(myProfileProvider).value;
    final name = p?.fullName?.trim() ?? p?.userName?.trim() ?? '';
    if (name.isNotEmpty) return name;
    return p?.email?.split('@').first ?? 'Mate';
  }

  Future<void> _create() async {
    final name = _flatName.text.trim();
    setState(() => _flatError = name.isEmpty ? 'Give your Flat a name' : null);
    if (name.isEmpty) return;
    final ok = await runAction(
      context,
      () => ref
          .read(createFlatProvider.notifier)
          .run(flatName: name, myName: _myName),
    );
    if (ok && mounted) setState(() => _done = true);
  }

  Future<void> _join() async {
    final code = _code.text.trim();
    setState(() => _codeError = code.isEmpty ? 'Enter the Invite code' : null);
    if (code.isEmpty) return;
    final ok = await runAction(
      context,
      () => ref
          .read(joinFlatProvider.notifier)
          .run(inviteCode: code, myName: _myName),
    );
    if (ok && mounted) setState(() => _done = true);
  }

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    final profile = ref.watch(myProfileProvider).value;
    final creating = ref.watch(createFlatProvider).isLoading;
    final joining = ref.watch(joinFlatProvider).isLoading;
    final busy = creating || joining || _done;
    final firstName = _myName.split(' ').first;

    Widget card(String title, List<Widget> children) => Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: fm.surface,
        borderRadius: BorderRadius.circular(Radii.hero),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: context.text.titleLarge),
          for (final c in children) ...[const SizedBox(height: Space.md), c],
        ],
      ),
    );
    final hint = context.text.bodySmall;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, Space.lg, 16, Space.xxl),
              sliver: SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: Space.sm),
                      child: Row(
                        children: [
                          Avatar(name: firstName, colorIndex: 0, size: 44),
                          const SizedBox(width: Space.md),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: 'Signed in as\n',
                                children: [
                                  TextSpan(
                                    text: profile?.email ?? '',
                                    style: TextStyle(
                                      color: fm.ink,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              style: context.text.bodyMedium?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: fm.inkSoft,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => runAction(
                              context,
                              ref.read(signOutProvider.notifier).run,
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: fm.inkSoft,
                              textStyle: context.text.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            child: const Text('Sign out'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: Space.xl),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Space.sm),
                      child: Semantics(
                        header: true,
                        child: Text(
                          'Welcome, $firstName. Let\'s find your Flat.',
                          style: context.text.displaySmall?.copyWith(
                            fontSize: 36,
                            height: 1.05,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(height: Space.xl),
                    card('Create a Flat', [
                      AppField(
                        label: 'Flat name',
                        hint: 'Maple Street 12',
                        controller: _flatName,
                        errorText: _flatError,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _create(),
                      ),
                      Text(
                        'You\'ll be the Admin. You can invite Mates next.',
                        style: hint,
                      ),
                      PrimaryButton(
                        label: 'Create Flat',
                        busy: creating,
                        onPressed: busy ? null : _create,
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Space.sm,
                        vertical: Space.lg,
                      ),
                      child: Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Space.md,
                            ),
                            child: Text(
                              'or',
                              style: hint?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                    ),
                    card('Join with an Invite', [
                      Text(
                        'Invite code',
                        style: hint?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppField(
                              hint: 'MAPLE-42',
                              controller: _code,
                              errorText: _codeError,
                              textCapitalization: TextCapitalization.characters,
                              textInputAction: TextInputAction.go,
                              onSubmitted: (_) => _join(),
                            ),
                          ),
                          const SizedBox(width: Space.sm),
                          OutlinedButton(
                            onPressed: busy ? null : _join,
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(0, Sizes.buttonPrimary),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22,
                              ),
                            ),
                            child: joining
                                ? const SizedBox.square(
                                    dimension: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : const Text('Join'),
                          ),
                        ],
                      ),
                      Text(
                        'Ask your Flat\'s Admin for the Invite code.',
                        style: hint,
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
