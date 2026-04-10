import 'package:firebase_analytics/firebase_analytics.dart';

class AppAnalytics {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> logScreenView(String screenName) async {
    await _analytics.logScreenView(screenName: screenName);
  }

  static Future<void> logUserLogin(String method) async {
    await _analytics.logLogin(loginMethod: method);
  }

  static Future<void> logEventView(String eventId, String title) async {
    await _analytics.logEvent(
      name: 'view_event',
      parameters: {'event_id': eventId, 'event_title': title},
    );
  }

  static Future<void> logRegistration(String eventId, String method) async {
    await _analytics.logEvent(
      name: 'event_registration',
      parameters: {'event_id': eventId, 'payment_method': method},
    );
  }

  static Future<void> logCheckIn(String eventId, String ticketId) async {
    await _analytics.logEvent(
      name: 'ticket_checkin',
      parameters: {'event_id': eventId, 'ticket_id': ticketId},
    );
  }
}
