import 'package:comp3330_project/home_page.dart';
import 'package:comp3330_project/providers/maps_filter.dart';
import 'package:comp3330_project/providers/selected_category.dart';
import 'package:comp3330_project/providers/selected_facility.dart';
import 'package:comp3330_project/providers/shared_preferences.dart';
import 'package:comp3330_project/service/alarm_scheduler.dart';
import 'package:comp3330_project/service/background_fetch_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MapsDistanceProvider()),
        ChangeNotifierProvider(create: (_) => SelectedCategoryProvider()),
        ChangeNotifierProvider(create: (_) => SelectedFacilityProvider()),
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
    final sharedPrefProvider = Provider.of<SharedPreferencesProvider>(context);
    final alarmScheduler = AlarmScheduler(flutterLocalNotificationsPlugin);

    // ignore: unused_local_variable
    final bgFetcher = BackgroundFetchHandler(
      alarmScheduler,
      sharedPrefProvider,
    );

    return const MaterialApp(
      title: 'HKU Main Campus Capacity Tracker',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
