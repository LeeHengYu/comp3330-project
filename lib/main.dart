import 'package:comp3330_project/home_page.dart';
import 'package:comp3330_project/providers/selected_facility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedFacilityProvider()),
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
