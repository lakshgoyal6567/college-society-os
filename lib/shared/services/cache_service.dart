import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> save(String key, dynamic value) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else {
      await _prefs.setString(key, jsonEncode(value));
    }
  }

  static dynamic get(String key) {
    final value = _prefs.getString(key);
    if (value == null) return null;
    try {
      return jsonDecode(value);
    } catch (_) {
      return value;
    }
  }

  static Future<void> clear(String key) async {
    await _prefs.remove(key);
  }

  // Specific Keys
  static const String keyEvents = 'cached_events';
  static const String keyRegistrations = 'cached_registrations';
  static const String keyUser = 'cached_user_profile';
  static const String keySocietyRequests = 'cached_society_requests';
}
