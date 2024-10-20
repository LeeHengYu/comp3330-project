import 'package:flutter/material.dart';

class MapsDistanceProvider extends ChangeNotifier {
  bool _isFiltered = false;

  bool get isFiltered => _isFiltered;

  void changeState() {
    _isFiltered = !_isFiltered;
    notifyListeners();
  }
}
