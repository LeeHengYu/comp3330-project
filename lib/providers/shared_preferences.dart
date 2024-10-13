import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  List<String> _facilityIds = [];
  SharedPreferences? _prefs;

  SharedPreferencesProvider() {
    _loadFromSharedPreferences();
  }

  List<String> get facilityIds => _facilityIds;

  Future<void> _loadFromSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _facilityIds = _prefs?.getStringList('facilityIds') ?? [];
    notifyListeners();
  }

  Future<void> addFacilityId(String facilityId) async {
    if (!_facilityIds.contains(facilityId)) {
      _facilityIds.add(facilityId);
      await _prefs?.setStringList('facilityIds', _facilityIds);
      notifyListeners();
    }
  }

  Future<void> removeFacilityId(String facilityId) async {
    if (_facilityIds.contains(facilityId)) {
      _facilityIds.remove(facilityId);
      await _prefs?.setStringList('facilityIds', _facilityIds);
      notifyListeners();
    }
  }

  Future<void> clearFacilityIds() async {
    _facilityIds.clear();
    await _prefs?.remove('facilityIds');
    notifyListeners();
  }

  Future<void> setAlarmData(
    String facilityId,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    List<String>? days,
  ) async {
    String startTimeKey = '${facilityId}_startTime';
    String endTimeKey = '${facilityId}_endTime';
    String daysKey = '${facilityId}_days';

    if (startTime != null) {
      await _prefs?.setString(startTimeKey, _formatTimeOfDay(startTime));
    } else {
      await _prefs?.remove(startTimeKey);
    }

    if (endTime != null) {
      await _prefs?.setString(endTimeKey, _formatTimeOfDay(endTime));
    } else {
      await _prefs?.remove(endTimeKey);
    }

    if (days != null && days.isNotEmpty) {
      await _prefs?.setStringList(daysKey, days);
    } else {
      await _prefs?.remove(daysKey);
    }

    notifyListeners();
  }

  TimeOfDay? getStartTime(String facilityId) {
    String? timeString = _prefs?.getString('${facilityId}_startTime');
    if (timeString != null) {
      return _parseTimeOfDay(timeString);
    }
    return null;
  }

  TimeOfDay? getEndTime(String facilityId) {
    String? timeString = _prefs?.getString('${facilityId}_endTime');
    if (timeString != null) {
      return _parseTimeOfDay(timeString);
    }
    return null;
  }

  List<String> getAlarmDays(String facilityId) {
    return _prefs?.getStringList('${facilityId}_days') ?? [];
  }

  String _formatTimeOfDay(TimeOfDay time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }

  TimeOfDay _parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
