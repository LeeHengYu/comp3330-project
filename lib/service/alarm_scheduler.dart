import 'package:comp3330_project/constants/sample_data.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart';

class AlarmScheduler {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  AlarmScheduler(this.flutterLocalNotificationsPlugin) {
    initializeTimeZones();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse response) async {},
    );

    _requestPermissions(); // Call this here to request permissions
  }

  Future<void> showNotification(String facilityId) async {
    final name = getName(facilityId);
    await flutterLocalNotificationsPlugin.show(
      facilityId.hashCode,
      'Facility $name',
      'Facility $name is now available under 40% occupancy!',
      const NotificationDetails(
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  Future<void> _requestPermissions() async {
    final bool? result = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    if (result == false) {
      print("Notification permission denied.");
    }
  }
}
