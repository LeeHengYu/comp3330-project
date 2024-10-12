import 'package:comp3330_project/models/facility_category.dart';
import 'package:flutter/material.dart';

class SelectedCategoryProvider extends ChangeNotifier {
  FacilityType _selectedCategory = FacilityType.food;

  FacilityType get selectedCategory => _selectedCategory;

  void setSelectedCategory(FacilityType category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
