import 'package:comp3330_project/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
