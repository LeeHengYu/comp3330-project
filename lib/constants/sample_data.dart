import 'package:comp3330_project/models/facility_category.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Facility> facilities = [
  Facility(
    id: "cafeteria",
    name: "Cafeteria",
    location: "Composite Building",
    coordinates: const LatLng(22.282579, 114.157693),
    description: "A place to grab quick meals.",
    occupancy: 50,
    capacity: 100,
    category: FacilityType.food,
    bookingLink: "https://google.com/",
  ),
  Facility(
    id: "vegan_options",
    name: "Vegan Options",
    location: "Composite Building",
    coordinates: const LatLng(22.283157, 114.158207),
    description: "Healthy vegan food available.",
    occupancy: 20,
    capacity: 50,
    category: FacilityType.food,
    bookingLink: "https://example.com/vegan-booking",
  ),
  Facility(
    id: "salad_bar",
    name: "Salad Bar",
    location: "Composite Building",
    coordinates: const LatLng(22.281402, 114.156899),
    description: "Fresh salads and sides.",
    occupancy: 30,
    capacity: 60,
    category: FacilityType.food,
    bookingLink: null,
  ),

  // Study Spaces
  Facility(
    id: "main_library",
    name: "Main Library",
    location: "Main Library",
    coordinates: const LatLng(22.28324783261001, 114.13774371648039),
    description: "Silent study space with resources and various seat options.",
    occupancy: 70,
    capacity: 300,
    category: FacilityType.study,
    bookingLink: "https://lib.hku.hk/general/e-form/book-a-space.html",
  ),
  Facility(
    id: "study_room_101",
    name: "Study Room 101",
    location: "Academic Building",
    coordinates: const LatLng(22.283661, 114.159122),
    description: "Private study room for group study.",
    occupancy: 5,
    capacity: 10,
    category: FacilityType.study,
    bookingLink: "https://example.com/study-room-booking",
  ),
  Facility(
    id: "silent_study_area",
    name: "Silent Study Area",
    location: "Academic Building",
    coordinates: const LatLng(22.283239, 114.159547),
    description: "Dedicated area for quiet study.",
    occupancy: 40,
    capacity: 50,
    category: FacilityType.study,
    bookingLink: null,
  ),

  // Fitness & Sports
  Facility(
    id: "b_active",
    name: "B Active",
    location: "Novum West 1/F",
    coordinates: const LatLng(22.285679134588225, 114.13675602406839),
    description: "Fully equipped gym for fitness training.",
    occupancy: 78,
    capacity: 80,
    category: FacilityType.sports,
    bookingLink: "https://hkuportal.hku.hk/login.html",
  ),
  Facility(
    id: "swimming_pool",
    name: "Swimming Pool",
    location: "Sports Complex",
    coordinates: const LatLng(22.285003, 114.161102),
    description: "Olympic-size pool for leisure and sport.",
    occupancy: 10,
    capacity: 50,
    category: FacilityType.sports,
    bookingLink: "https://example.com/pool-booking",
  ),
  Facility(
    id: "tennis_court",
    name: "Tennis Court",
    location: "Sports Complex",
    coordinates: const LatLng(22.285222, 114.161455),
    description: "Outdoor tennis courts available for booking.",
    occupancy: 2,
    capacity: 10,
    category: FacilityType.sports,
    bookingLink: null,
  ),
];

List<Facility> getFilteredList(FacilityType type) {
  return facilities.where((facility) {
    return facility.category == type;
  }).toList();
}
