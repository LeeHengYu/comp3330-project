import 'dart:async';

import 'package:comp3330_project/constants/sample_data.dart';
import 'package:comp3330_project/models/facility_category.dart';
import 'package:comp3330_project/providers/selected_category.dart';
import 'package:comp3330_project/providers/selected_facility.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class GoogleMaps extends StatefulWidget {
  final VoidCallback onMarkerTap; // Callback for marker tap

  const GoogleMaps({super.key, required this.onMarkerTap});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Map<String, Marker> _markersMap = {};

  static const CameraPosition _hkuInitial = CameraPosition(
    target: LatLng(22.28309974275602, 114.13654128421945),
    zoom: 18,
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedFacilityProvider =
          Provider.of<SelectedFacilityProvider>(context, listen: false);
      selectedFacilityProvider.addListener(() {
        _focusOnSelectedFacility(selectedFacilityProvider.selectedFacility);
      });
    });
  }

  Future<void> _focusOnSelectedFacility(String? facilityId) async {
    if (facilityId == null || !_markersMap.containsKey(facilityId)) return;

    final selectedFacilityMarker = _markersMap[facilityId]!;
    final GoogleMapController mapController = await _controller.future;

    mapController
        .animateCamera(CameraUpdate.newLatLng(selectedFacilityMarker.position));
    mapController.showMarkerInfoWindow(selectedFacilityMarker.markerId);
  }

  Set<Marker> _generateMarkers(BuildContext context) {
    final selectedCategoryProvider =
        Provider.of<SelectedCategoryProvider>(context);
    FacilityType selectedCategory = selectedCategoryProvider.selectedCategory;

    final filteredFacilities = facilities.where((facility) {
      return facility.category == selectedCategory;
    }).toList();

    _markersMap.clear();

    return filteredFacilities.map((facility) {
      final marker = facility.toMarker(
        onMarkerClick: () {
          widget.onMarkerTap();
          Provider.of<SelectedFacilityProvider>(context, listen: false)
              .setSelectedFacility(facility.id);
        },
      );

      _markersMap[facility.id] = marker;

      return marker;
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _hkuInitial,
      onMapCreated: (controller) => _controller.complete(controller),
      markers: _generateMarkers(context),
    );
  }
}
