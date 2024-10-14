import 'package:background_fetch/background_fetch.dart';
import 'package:comp3330_project/providers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';

import 'alarm_scheduler.dart';

class BackgroundFetchHandler {
  final AlarmScheduler _alarmScheduler;
  final SharedPreferencesProvider _sharedPreferencesProvider;

  BackgroundFetchHandler(this._alarmScheduler, this._sharedPreferencesProvider);

  void initBackgroundFetch() {
    BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 15,
        stopOnTerminate: false,
        enableHeadless: true,
      ),
      _onBackgroundFetch,
    ).then((int status) {
      // print("[BackgroundFetch] configure success: $status");
    }).catchError((e) {
      // print("[BackgroundFetch] configure ERROR: $e");
    });
  }

  Future<void> _onBackgroundFetch(String taskId) async {
    List<String> facilityIds = _sharedPreferencesProvider.facilityIds;
    for (String facilityId in facilityIds) {
      final location = getLocation('Asia/Taipei');
      final nowInTaipei = TZDateTime.now(location);

      if (nowInTaipei.weekday == DateTime.saturday ||
          nowInTaipei.weekday == DateTime.sunday) return;

      var days = _sharedPreferencesProvider.getAlarmDays(facilityId);
      var daysInInt = days.map((d) => _weekdayToInt(d)).toList();

      if (!daysInInt.contains(nowInTaipei.weekday)) return;

      TimeOfDay? startTime =
          _sharedPreferencesProvider.getStartTime(facilityId);
      TimeOfDay? endTime = _sharedPreferencesProvider.getEndTime(facilityId);

      final startDateTime = TZDateTime(
        location,
        nowInTaipei.year,
        nowInTaipei.month,
        nowInTaipei.day,
        startTime?.hour ?? 0,
        startTime?.minute ?? 0,
      );
      final endDateTime = TZDateTime(
        location,
        nowInTaipei.year,
        nowInTaipei.month,
        nowInTaipei.day,
        endTime?.hour ?? 23,
        endTime?.minute ?? 59,
      );

      if (nowInTaipei.isAfter(startDateTime) &&
          nowInTaipei.isAfter(endDateTime)) {
        await _alarmScheduler.scheduleAlarm(facilityId);
      }
    }

    BackgroundFetch.finish(taskId);
  }

  int _weekdayToInt(String day) {
    switch (day.toLowerCase()) {
      case "mon":
        return 1;
      case "tue":
        return 2;
      case "wed":
        return 3;
      case "thr":
        return 4;
      case "fri":
        return 5;
      default:
        return -1;
    }
  }
}
