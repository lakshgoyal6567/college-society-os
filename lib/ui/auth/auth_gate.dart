import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../main_scaffold.dart';
import '../auth/login_screen.dart';
import '../auth/registration_details_screen.dart';
import '../../shared/widgets/skeleton_loader.dart';
import '../../theme/app_theme.dart';

/// AuthGate decision tree:
///
///   authUserProvider == null && Firebase has NO user  →  LoginScreen
///   authUserProvider == null && Firebase HAS a user   →  Splash (loading profile)
///   authUserProvider != null && !isProfileComplete    →  RegistrationDetailsScreen
///   authUserProvider != null && isProfileComplete     →  MainScaffold
///
/// We deliberately do NOT use a StreamBuilder on authStateChanges here.
/// Instead we read `authUserProvider` which internally subscribes to the same
/// stream and exposes the resolved AppUser (or null while loading).
class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // authUserProvider is keepAlive: true and listens to FirebaseAuth.
    // It returns null both when:
    //   (a) there is no signed-in user, OR
    //   (b) there IS a signed-in user but the profile is still loading.
    //
    // We distinguish these two cases by checking Firebase Auth's synchronous
    // currentUser, which is populated as soon as the SDK initialises.
    final appUser = ref.watch(authUserProvider);

    if (appUser != null) {
      // Profile loaded — decide which screen to show.
      if (!appUser.isProfileComplete) {
        return const RegistrationDetailsScreen();
      }
      return const MainScaffold();
    }

    // appUser is null — check if Firebase Auth knows about a signed-in user.
    // authUserProvider.notifier.isAuthLoading is set to false once the listener
    // fires for the first time (either null user or resolved AppUser).
    final isLoading = ref.watch(
      authUserProvider.notifier.select((n) => n.isLoading),
    );

    if (isLoading) {
      return const _LoadingSplash();
    }

    // Not loading, appUser is still null → no signed-in user.
    return const LoginScreen();
  }
}

class _LoadingSplash extends StatelessWidget {
  const _LoadingSplash();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SkeletonBox(height: 60, width: 60, borderRadius: 12),
            const SizedBox(height: 24),
            const SkeletonBox(height: 20, width: 140),
          ],
        ),
      ),
    );
  }
}
