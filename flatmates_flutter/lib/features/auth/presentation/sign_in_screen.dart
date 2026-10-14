import 'package:auto_route/auto_route.dart';
import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../core/providers/client_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_sheet.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/mate_avatar.dart';
import '../../onboarding/application/onboarding_state.dart';
import '../../onboarding/presentation/story_page.dart';

/// Black screen, four Mates, and Continue with Google: the only way in.
/// The first time, the dishes story comes first.
@RoutePage()
class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  GoogleAuthController? _googleController;

  /// Made on first use: the story page doesn't need it.
  late final GoogleAuthController _google = _googleController =
      GoogleAuthController(
        client: ref.read(clientProvider),
        onError: (error) => ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Sign-in failed: $error'))),
      )..addListener(() => setState(() {}));

  /// Email and password, for anyone without Google (hackathon judges, say).
  void _emailSignIn() => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => const _EmailSheet(),
  );

  @override
  void dispose() {
    _googleController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Always the dark ink ground, in light and dark mode.
    const ink = Color(0xFF16181A);
    const white = Colors.white;
    final text = context.text;
    return Scaffold(
      backgroundColor: ink,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, box) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: box.maxHeight - 80),
              child: IntrinsicHeight(
                child: !ref.watch(storySeenProvider)
                    ? StoryPage(
                        onNext: ref.read(storySeenProvider.notifier).seen,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ExcludeSemantics(
                            child: SizedBox(
                              height: 72,
                              child: Stack(
                                children: [
                                  for (final (i, name) in [
                                    'Maya',
                                    'Sam',
                                    'Priya',
                                    'Jonas',
                                  ].indexed)
                                    Positioned(
                                      left: i * 52.0,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ink,
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: Avatar(
                                          name: name,
                                          colorIndex: i,
                                          size: 64,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            'Flatmates',
                            style: text.displaySmall?.copyWith(
                              fontSize: 56,
                              height: 0.98,
                              letterSpacing: -1.1,
                              color: white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // What the dishes story needed: one line each.
                          for (final (icon, line) in const [
                            (
                              HugeIcons.strokeRoundedRefresh,
                              'Chores rotate fairly. Everyone takes a Turn.',
                            ),
                            (
                              HugeIcons.strokeRoundedAirplane01,
                              'Away? Your Turns are sorted.',
                            ),
                            (
                              HugeIcons.strokeRoundedStickyNote01,
                              'Notices, Events and Groceries in one place.',
                            ),
                          ])
                            Padding(
                              padding: const EdgeInsets.only(top: Space.md),
                              child: Row(
                                children: [
                                  AppIcon(icon, size: 22, color: white),
                                  const SizedBox(width: Space.md),
                                  Expanded(
                                    child: Text(
                                      line,
                                      style: text.bodyLarge?.copyWith(
                                        fontSize: 18,
                                        height: 1.3,
                                        color: white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const Spacer(),
                          const SizedBox(height: 40),
                          PrimaryButton(
                            label: 'Continue with Google',
                            busy: _google.isLoading,
                            onPressed: _google.signIn,
                            background: FlatmatesColors.light.primary,
                            foreground: ink,
                          ),
                          // Debug builds only: the seeded email accounts (see the
                          // server's dev/seed.dart). The server only has email
                          // sign-in in development.
                          Center(
                            child: TextButton(
                              onPressed: _emailSignIn,
                              style: TextButton.styleFrom(
                                foregroundColor: white,
                              ),
                              child: const Text('Sign in with email'),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text.rich(
                            TextSpan(
                              text: 'By continuing you agree to the ',
                              children: const [
                                TextSpan(
                                  text: 'Terms',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                TextSpan(text: '.'),
                              ],
                            ),
                            textAlign: TextAlign.center,
                            style: text.bodySmall?.copyWith(color: white),
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

/// Email sign-in in a sheet. Its login screen links to signing up. Errors
/// show in the sheet, as a snackbar would sit behind it, including the
/// server's own ones the sign-in widget doesn't know (an address that signs
/// in with Google).
class _EmailSheet extends ConsumerStatefulWidget {
  const _EmailSheet();

  @override
  ConsumerState<_EmailSheet> createState() => _EmailSheetState();
}

class _EmailSheetState extends ConsumerState<_EmailSheet> {
  late final _controller = EmailAuthController(
    client: ref.read(clientProvider),
    startScreen: EmailFlowScreen.login,
    onAuthenticated: () => Navigator.of(context).pop(),
    onError: (error) => setState(() => _message = error.toString()),
  )..addListener(_changed);

  String? _message;

  void _changed() {
    final error = _controller.error;
    if (error is FlatmatesException) {
      setState(() => _message = error.message);
    } else if (_controller.state == EmailAuthState.loading &&
        _message != null) {
      setState(() => _message = null);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        24 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_message case final message?) ...[
            Semantics(
              liveRegion: true,
              child: Text(
                message,
                style: context.text.bodyMedium?.copyWith(
                  color: context.fm.dangerFg,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          EmailSignInWidget(controller: _controller),
        ],
      ),
    );
  }
}
