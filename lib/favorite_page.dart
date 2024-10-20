import 'dart:collection';

import 'package:comp3330_project/constants/sample_data.dart';
import 'package:comp3330_project/providers/shared_preferences.dart';
import 'package:comp3330_project/widgets/favorite_info_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sharedPrefProvider = Provider.of<SharedPreferencesProvider>(context);
    final HashSet<String> favoriteIds =
        HashSet.from(sharedPrefProvider.facilityIds);

    final favFacilities = facilities.where((f) {
      return favoriteIds.contains(f.id);
    }).toList();
    favFacilities.sort(
      (a, b) => ((a.occupancy ?? 1e9) / a.capacity)
          .compareTo((b.occupancy ?? 1e9) / b.capacity),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Favorite Page",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: favFacilities.length,
        itemBuilder: (context, index) {
          final f = favFacilities[index];
          return FavInfoCard(
            title: f.name,
            location: f.location,
            description: f.description,
            occupancy: f.occupancy,
            capacity: f.capacity,
            bookingLink: f.bookingLink,
          );
        },
      ),
    );
  }
}
