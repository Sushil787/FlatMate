import 'package:auto_route/auto_route.dart';
import 'package:flatmates_shared/flatmates_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../core/providers/client_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_sheet.dart';
import '../../../core/widgets/mate_avatar.dart';

/// Black screen, four Mates, and Continue with Google: the only way in.
@RoutePage()
class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  late final _google = GoogleAuthController(
    client: ref.read(clientProvider),
    onError: (error) => ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Sign-in failed: $error'))),
  )..addListener(() => setState(() {}));

  void _emailSignIn() => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (sheet) => Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        24 + MediaQuery.viewInsetsOf(sheet).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // The seeded accounts, one tap each.
          for (final a in devAccounts)
            OutlinedButton(
              onPressed: () async {
                final client = ref.read(clientProvider);
                try {
                  await client.auth.updateSignedInUser(
                    await client.emailIdp.login(
                      email: a.email,
                      password: devPassword,
                    ),
                  );
                  if (sheet.mounted) Navigator.of(sheet).pop();
                } catch (error) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Sign-in failed: $error')),
                  );
                }
              },
              child: Text('${a.name} (${a.role}) · ${a.email}'),
            ),
          const SizedBox(height: 16),
          EmailSignInWidget(
            client: ref.read(clientProvider),
            startScreen: EmailFlowScreen.login,
            onAuthenticated: () => Navigator.of(sheet).pop(),
            onError: (error) => ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Sign-in failed: $error'))),
          ),
        ],
      ),
    ),
  );

  @override
  void dispose() {
    _google.dispose();
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExcludeSemantics(
                      child: SizedBox(
                        height: 72,
                        child: Stack(
                          children: [
                            for (final (i, name) in [
                              'M',
                              'S',
                              'P',
                              'J',
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
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: Text(
                        'Whose Turn is it? Did someone buy milk? '
                        'One calm place for your Flat.',
                        style: text.bodyLarge?.copyWith(
                          fontSize: 20,
                          height: 1.35,
                          color: white,
                        ),
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
                    if (kDebugMode)
                      Center(
                        child: TextButton(
                          onPressed: _emailSignIn,
                          style: TextButton.styleFrom(foregroundColor: white),
                          child: const Text('Sign in with email (debug)'),
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
