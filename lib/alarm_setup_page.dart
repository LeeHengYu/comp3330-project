import 'dart:collection';

import 'package:comp3330_project/constants/sample_data.dart';
import 'package:comp3330_project/providers/shared_preferences.dart';
import 'package:comp3330_project/widgets/alarm_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlarmSetupPage extends StatelessWidget {
  const AlarmSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sharedPrefProvider = Provider.of<SharedPreferencesProvider>(context);
    final HashSet<String> alarmIds =
        HashSet.from(sharedPrefProvider.facilityIds);

    final alarmFacilities = facilities.where((f) {
      return alarmIds.contains(f.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Set Up Alarms",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: alarmFacilities.length,
        itemBuilder: (context, index) {
          final f = alarmFacilities[index];
          return AlarmCard(
            facilityId: f.id,
            title: f.name,
          );
        },
      ),
    );
  }
}
