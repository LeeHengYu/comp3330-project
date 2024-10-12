import 'package:flutter/material.dart';

class SelectedFacilityProvider extends ChangeNotifier {
  String? _selectedFacility;

  String? get selectedFacility => _selectedFacility;

  void setSelectedFacility(String facilityId) {
    _selectedFacility = facilityId;
    notifyListeners();
  }
}
