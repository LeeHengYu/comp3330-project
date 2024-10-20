import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocationProvider extends ChangeNotifier {
  Position? _curLoc;

  Position? get currentLocation => _curLoc;

  CurrentLocationProvider() {
    getLocation();
  }

  void getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      _curLoc = await Geolocator.getCurrentPosition();
    }
  }

  double computeDistanceInMeters(double refLat, double refLng) {
    if (_curLoc == null) return 1e9;
    return Geolocator.distanceBetween(
      _curLoc!.latitude,
      _curLoc!.longitude,
      refLat,
      refLng,
    );
  }
}
