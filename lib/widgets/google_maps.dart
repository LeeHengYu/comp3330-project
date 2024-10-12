import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _hkuInitial = CameraPosition(
    target: LatLng(22.28309974275602, 114.13654128421945),
    zoom: 18,
  );

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('hku_initial'),
      position: LatLng(22.28309974275602, 114.13654128421945),
    ),
    const Marker(
      markerId: MarkerId('starbucks'),
      position: LatLng(22.283000365809162, 114.13590296927603),
      infoWindow:
          InfoWindow(title: "Starbucks", snippet: "30% off still robbery"),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _hkuInitial,
      onMapCreated: (controller) => {_controller.complete(controller)},
      markers: _markers,
    );
  }
}
