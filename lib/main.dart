import 'package:comp3330_project/home_page.dart';
import 'package:comp3330_project/providers/selected_category.dart';
import 'package:comp3330_project/providers/selected_facility.dart';
import 'package:comp3330_project/providers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedFacilityProvider()),
        ChangeNotifierProvider(create: (_) => SelectedCategoryProvider()),
        ChangeNotifierProvider(create: (_) => SharedPreferencesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'HKU Main Campus Capacity Tracker',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
