// ignore_for_file: avoid_print
import 'package:background_fetch/background_fetch.dart';
import 'package:comp3330_project/constants/sample_data.dart';
import 'package:comp3330_project/providers/shared_preferences.dart';
import 'package:comp3330_project/service/alarm_scheduler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart';

class BackgroundFetchHandler {
  AlarmSchedulerNotifier? scheduler;
  final SharedPreferencesProvider _sharedPreferencesProvider;
  final BuildContext context;

  BackgroundFetchHandler(
    this._sharedPreferencesProvider,
    this.context,
  ) {
    _initBackgroundFetch();
    scheduler = Provider.of<AlarmSchedulerNotifier>(context, listen: false);
  }

  void _initBackgroundFetch() {
    BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 15,
        stopOnTerminate: false,
        enableHeadless: true,
      ),
      _onBackgroundFetch,
    ).then((int status) {
      print("[BackgroundFetch] configure success: $status");
    }).catchError((e) {
      print("[BackgroundFetch] configure ERROR: $e");
    });
    print("Finish background fetch init.");
  }

  Future<void> _onBackgroundFetch(String taskId) async {
    print('fetch attempt on task $taskId');
    final location = getLocation('Asia/Taipei');
    final nowInTaipei = TZDateTime.now(location);
    // if (nowInTaipei.weekday == DateTime.saturday ||
    //     nowInTaipei.weekday == DateTime.sunday) return;

    List<String> facilityIds = _sharedPreferencesProvider.facilityIds;

    for (String facilityId in facilityIds) {
      // check occupancy %
      var percentage = getOccupancy(facilityId);
      if (percentage > 0.4) continue;

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
        await scheduler?.showNotification(facilityId);
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
