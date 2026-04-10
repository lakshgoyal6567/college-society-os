import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/app_theme.dart';
import 'firebase_options.dart';
import 'ui/auth/auth_gate.dart';
import 'shared/services/cache_service.dart';
import 'shared/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ─── Parallel init: cache + Firebase ───────────────────────────────────────
  // Running both concurrently shaves ~100-200 ms off cold-start time.
  await Future.wait([
    CacheService.init(),
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).catchError((e) {
      debugPrint('Firebase initialization failed: $e');
      return Firebase.app(); // return existing app or rethrow gracefully
    }),
  ]);

  // ─── Notifications (requires Firebase) ─────────────────────────────────────
  try {
    await NotificationService.init();
  } catch (e) {
    debugPrint('Notification service init failed: $e');
  }

  runApp(const ProviderScope(child: CollegeSocietyApp()));
}

class CollegeSocietyApp extends StatelessWidget {
  const CollegeSocietyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TIT&S – Society & Event Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // Use hash-based routing by default (no server config needed).
      // Clean URLs are handled via Firebase Hosting rewrites.
      home: const AuthGate(),
    );
  }
}
