import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  List<String> _facilityIds = [];

  List<String> get facilityIds => _facilityIds;

  SharedPreferences? _prefs;

  SharedPreferencesProvider() {
    _loadFromSharedPreferences();
  }

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
}
