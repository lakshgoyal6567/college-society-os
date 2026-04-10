import 'package:device_calendar/device_calendar.dart' as dc;
import 'package:flutter/foundation.dart';
import '../../models/event.dart';
import 'package:timezone/timezone.dart' as tz;

class CalendarService {
  static final dc.DeviceCalendarPlugin _calendarPlugin =
      dc.DeviceCalendarPlugin();

  /// Requests permission to access the device calendar.
  static Future<bool> requestPermissions() async {
    try {
      final permissions = await _calendarPlugin.hasPermissions();
      if (permissions.isSuccess && permissions.data == true) return true;

      final request = await _calendarPlugin.requestPermissions();
      return request.isSuccess && request.data == true;
    } catch (e) {
      debugPrint('Calendar Permission Error: $e');
      return false;
    }
  }

  /// Adds a society event to the primary/first available calendar.
  ///
  /// [eventTitle]  – human-readable name of the event
  /// [description] – about text shown in the calendar entry
  /// [dateTime]    – start time of the event
  /// [venue]       – optional location string
  static Future<bool> addEventToCalendar({
    required String eventTitle,
    required String description,
    required DateTime dateTime,
    String venue = '',
  }) async {
    try {
      final hasPermission = await requestPermissions();
      if (!hasPermission) return false;

      final calendars = await _calendarPlugin.retrieveCalendars();
      if (calendars.isSuccess &&
          calendars.data != null &&
          calendars.data!.isNotEmpty) {
        // Prefer first writable calendar
        final calendar = calendars.data!.firstWhere(
          (c) => c.isReadOnly == false,
          orElse: () => calendars.data!.first,
        );

        final startDate = tz.TZDateTime.from(dateTime, tz.local);
        final endDate = startDate.add(const Duration(hours: 2));

        final dcEvent = dc.Event(
          calendar.id,
          title: '[TIT&S] $eventTitle',
          description: description,
          location: venue,
          start: startDate,
          end: endDate,
        );

        final result = await _calendarPlugin.createOrUpdateEvent(dcEvent);
        return result?.isSuccess ?? false;
      }
      return false;
    } catch (e) {
      debugPrint('Error adding event to calendar: $e');
      return false;
    }
  }

  /// Convenience wrapper that accepts an [Event] model directly.
  /// Attempts to derive date/venue from stage data if available.
  static Future<bool> addEventModelToCalendar(Event event) async {
    // Try to parse start date from first stage, fall back to now+1d
    DateTime eventDate = DateTime.now().add(const Duration(days: 1));
    if (event.details.stages.isNotEmpty) {
      try {
        eventDate = DateTime.parse(event.details.stages.first.date);
      } catch (_) {}
    }

    return addEventToCalendar(
      eventTitle: event.title,
      description: event.details.about,
      dateTime: eventDate,
    );
  }
}
