import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../shared/services/notification_service.dart';
import '../models/app_user.dart';

import '../shared/services/cache_service.dart';
import '../shared/analytics/app_analytics.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthUser extends _$AuthUser {
  StreamSubscription<User?>? _subscription;

  /// True while we are waiting for the Firebase Auth stream to emit its
  /// first event AND resolve the Firestore profile.  Set to false once
  /// we have made a routing decision (user → profile, or no user → login).
  bool isLoading = true;

  @override
  AppUser? build() {
    // ── 1. Warm-start from local cache ───────────────────────────────────────
    // Try to populate state immediately from SharedPreferences so the UI
    // never shows a blank screen on repeat visits.
    final cachedData = CacheService.get(CacheService.keyUser);
    if (cachedData != null && cachedData is Map<String, dynamic>) {
      try {
        final cached = AppUser.fromJson(cachedData);
        // Only trust the cache if Firebase Auth also has a current user
        // (avoids showing a stale profile after sign-out on another device).
        if (FirebaseAuth.instance.currentUser != null) {
          isLoading = false;
          // Schedule a hot-reload of Firestore in the background.
          Future.microtask(() => state = cached);
        }
      } catch (_) {
        // Corrupt cache — ignore and wait for the listener.
      }
    }

    // ── 2. Subscribe to Firebase Auth ────────────────────────────────────────
    if (kIsWeb) {
      // Consume any pending redirect result from a previous
      // signInWithRedirect call BEFORE the authStateChanges listener fires.
      FirebaseAuth.instance.getRedirectResult().then((result) {
        if (result.user != null) {
          AppAnalytics.logUserLogin('google');
        }
      }).catchError((e) {
        debugPrint('getRedirectResult error (expected on first load): $e');
      });
    }

    _subscription?.cancel();
    _subscription = FirebaseAuth.instance.authStateChanges().listen(
      (user) async {
        if (user == null) {
          // ── Signed out ────────────────────────────────────────────────────
          isLoading = false;
          state = null;
          CacheService.clear(CacheService.keyUser);
          return;
        }

        // ── Signed in — resolve profile ───────────────────────────────────
        final email = user.email ?? '';
        final isLaksh = email == 'developer.laksh22@gmail.com';

        // Build a fallback user immediately from Firebase Auth so we can
        // unblock routing even if Firestore is unavailable.
        AppUser updatedUser = AppUser(
          uid: user.uid,
          email: email,
          name: user.displayName ?? '',
          isGlobalAdmin: isLaksh,
          // Mark profile as complete if we have a cached version — the full
          // Firestore fetch below will overwrite this if it succeeds.
          isProfileComplete: (cachedData != null),
        );

        // Unblock the gate immediately using the fallback/cached user.
        // This prevents the infinite-loading race condition.
        if (state == null) {
          isLoading = false;
          state = updatedUser;
        }

        // ── Now fetch the real Firestore profile (non-blocking) ────────────
        try {
          final docRef = FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid);

          final doc = await docRef.get();

          if (doc.exists && doc.data() != null) {
            AppUser firestoreUser = AppUser.fromJson(doc.data()!);
            if (isLaksh && !firestoreUser.isGlobalAdmin) {
              firestoreUser = firestoreUser.copyWith(isGlobalAdmin: true);
              docRef.update({'is_global_admin': true}); // fire-and-forget
            }
            updatedUser = firestoreUser;
          } else if (!doc.exists) {
            // New user — write initial profile.
            await docRef.set(updatedUser.toJson()).catchError((_) {});
          }
        } catch (e) {
          debugPrint('Auth Firestore Error (likely offline): $e');
          // Keep the fallback user — do NOT leave state as null.
        }

        // Always update state with the best available data.
        isLoading = false;
        state = updatedUser;
        CacheService.save(CacheService.keyUser, updatedUser.toJson());

        // ── FCM token sync (non-blocking, mobile only) ──────────────────────
        NotificationService.getToken().then((token) {
          if (token != null && updatedUser.fcmToken != token) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .update({'fcm_token': token}); // fire-and-forget
            state = updatedUser.copyWith(fcmToken: token);
          }
        }).catchError((_) {});
      },
      onError: (e) {
        // authStateChanges itself failed — unblock auth gate.
        debugPrint('authStateChanges error: $e');
        isLoading = false;
        state = null;
      },
    );

    ref.onDispose(() => _subscription?.cancel());

    // Return the initial synchronous value.
    // isLoading will be set to false once the listener fires.
    return null;
  }

  /// Signs in the user with Google.
  ///
  /// **Web:** calls [signInWithRedirect] — the method returns immediately and
  /// the browser navigates to Google's auth page. Firebase Auth resolves the
  /// credential on the return page via [getRedirectResult] (called in [build]).
  ///
  /// **Mobile:** uses the GoogleSignIn package and [signInWithCredential].
  Future<void> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        await FirebaseAuth.instance.signInWithRedirect(GoogleAuthProvider());
      } else {
        final GoogleSignIn googleSignIn = GoogleSignIn();
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        if (googleUser == null) return;
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        await AppAnalytics.logUserLogin('google');
      }
    } catch (e) {
      debugPrint('Google Sign In Error: $e');
      rethrow;
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await AppAnalytics.logUserLogin('email');
    } catch (e) {
      debugPrint('Email Sign In Error: $e');
      rethrow;
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await AppAnalytics.logUserLogin('email_signup');
    } catch (e) {
      debugPrint('Email Sign Up Error: $e');
      rethrow;
    }
  }

  Future<void> sendPasswordReset(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      debugPrint('Password Reset Error: $e');
      rethrow;
    }
  }

  /// Updates the user's editable profile fields (name, phone, college).
  /// Writes to Firestore and immediately updates local state so the UI
  /// reflects the change without waiting for the auth stream to re-emit.
  Future<void> updateProfile({
    required String name,
    String? phone,
    String? college,
  }) async {
    final current = state;
    if (current == null) return;

    final updates = <String, dynamic>{'name': name};
    if (phone != null) updates['phone'] = phone;
    if (college != null) updates['college'] = college;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(current.uid)
        .update(updates);

    // Update local state immediately for snappy UI
    state = current.copyWith(
      name: name,
      phone: phone ?? current.phone,
      college: college ?? current.college,
    );
    CacheService.save(CacheService.keyUser, state!.toJson());
  }

  Future<void> signOut() async {
    if (!kIsWeb) {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
    }
    await FirebaseAuth.instance.signOut();
  }
}
