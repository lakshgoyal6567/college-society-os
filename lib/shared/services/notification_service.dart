import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // ── WEB: FCM requires a manual Service Worker.
    // Skip ALL local-notification setup on web to avoid JS channel errors.
    if (kIsWeb) {
      if (kDebugMode) {
        print('NotificationService: Web detected – FCM setup skipped.');
      }
      return;
    }

    // ── MOBILE: request FCM permission ──────────────────────────────────────
    try {
      final fcm = FirebaseMessaging.instance;
      final settings = await fcm.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      if (kDebugMode) {
        print(
          'NotificationService: permission status = '
          '${settings.authorizationStatus}',
        );
      }
    } catch (e) {
      if (kDebugMode) print('NotificationService: FCM permission error: $e');
    }

    // ── Local Notifications init (mobile only) ───────────────────────────────
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (_) {
        // TODO: route to the relevant event screen on tap
      },
    );

    // ── Listen for foreground FCM messages ───────────────────────────────────
    FirebaseMessaging.onMessage.listen(_showLocalNotification);

    // ── Register background handler ──────────────────────────────────────────
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  }

  /// Returns the FCM token for the current device (mobile only).
  static Future<String?> getToken() async {
    if (kIsWeb) return null;
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (_) {
      return null;
    }
  }

  static Future<void> subscribeToTopic(String topic) async {
    if (kIsWeb) return;
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    if (kIsWeb) return;
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  // ─── Private helpers ────────────────────────────────────────────────────────

  static void _showLocalNotification(RemoteMessage message) {
    const androidDetails = AndroidNotificationDetails(
      'tits_high_importance',
      'TIT&S Notifications',
      channelDescription: 'Important updates from TIT&S',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'TIT&S Update',
      message.notification?.body ?? '',
      details,
    );
  }
}

/// Top-level background message handler (must be a global function).
@pragma('vm:entry-point')
Future<void> _backgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('NotificationService background: ${message.messageId}');
  }
}
