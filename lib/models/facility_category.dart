import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';

enum FacilityType { food, sports, study }

class Facility {
  final String id;
  final String name;
  final String location;
  final LatLng coordinates;
  final String description;
  int? occupancy;
  final int capacity;
  final FacilityType category;
  final String? bookingLink;

  Facility({
    required this.id,
    required this.name,
    required this.location,
    required this.coordinates,
    required this.description,
    this.occupancy,
    required this.capacity,
    required this.category,
    this.bookingLink,
  });

  void setOccupancy(int newOccupancy) {
    if (newOccupancy <= capacity) {
      occupancy = newOccupancy;
    } else {
      throw Exception('Occupancy exceeds capacity');
    }
  }

  Marker toMarker({VoidCallback? onMarkerClick}) {
    return Marker(
      markerId: MarkerId(id),
      position: coordinates,
      infoWindow: InfoWindow(
        title: name,
        snippet:
            'Category: ${category.toString().split('.').last}, Capacity: $capacity, Occupancy: $occupancy',
      ),
      onTap: onMarkerClick,
    );
  }
}
