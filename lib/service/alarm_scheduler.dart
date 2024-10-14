import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';

class AlarmScheduler {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  AlarmScheduler(this.flutterLocalNotificationsPlugin) {
    initializeTimeZones();
  }

  Future<void> scheduleAlarm(
    String facilityId,
  ) async {
    await _cancelAlarm(facilityId);
    _scheduleDailyNotification(facilityId);
  }

  Future<void> _scheduleDailyNotification(
    String facilityId,
  ) async {
    final taipeiLocation = getLocation('Asia/Taipei');
    final now = TZDateTime.now(taipeiLocation);

    TZDateTime scheduledTime = TZDateTime(
      taipeiLocation,
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      facilityId.hashCode + now.weekday,
      'Facility $facilityId',
      'Facility $facilityId is now available under 40% occupancy!',
      scheduledTime,
      const NotificationDetails(
        iOS: DarwinNotificationDetails(),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  // clear all alarms before setting a new one
  Future<void> _cancelAlarm(String facilityId) async {
    for (int i = 1; i <= 5; i++) {
      await flutterLocalNotificationsPlugin.cancel(facilityId.hashCode + i);
    }
  }
}
