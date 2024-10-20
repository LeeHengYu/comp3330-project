import 'package:comp3330_project/providers/maps_filter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterToggleButton extends StatelessWidget {
  const FilterToggleButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<MapsDistanceProvider>(
      builder: (context, provider, child) {
        return InkWell(
          onTap: () {
            provider.changeState();
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15),
            color: provider.isFiltered ? Colors.blue[50] : Colors.grey[100],
            child: Center(
              child: Text(
                provider.isFiltered ? "Filter: 250m" : "No map filters",
                style: TextStyle(
                  color: provider.isFiltered ? Colors.blue : Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
