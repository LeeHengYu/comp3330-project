import 'package:comp3330_project/constants/facility_category.dart';

final Map<String, List<Map<String, dynamic>>> listItems = {
  "Dietary": [
    {
      "title": "Cafeteria",
      "location": "Hacking Wong 5F",
      "description": "A place to grab quick meals.",
      "occupancy": 50,
      "capacity": 100,
      "type": Facility.food,
      "bookingLink": "https://google.com/",
    },
    {
      "title": "Vegan Options",
      "description": "Healthy vegan food available.",
      "occupancy": 20,
      "capacity": 50,
      "type": Facility.food,
      "bookingLink": "https://example.com/vegan-booking",
    },
    {
      "title": "Salad Bar",
      "description": "Fresh salads and sides.",
      "occupancy": 30,
      "capacity": 60,
      "type": Facility.food,
      "bookingLink": null,
    },
  ],
  "Study Spaces": [
    {
      "title": "Library",
      "description": "Silent study space with resources.",
      "occupancy": 70,
      "capacity": 200,
      "type": Facility.study,
      "bookingLink": "https://example.com/library-booking",
    },
    {
      "title": "Study Room 101",
      "description": "Private study room for group study.",
      "occupancy": 5,
      "capacity": 10,
      "type": Facility.study,
      "bookingLink": "https://example.com/study-room-booking",
    },
    {
      "title": "Silent Study Area",
      "description": "Dedicated area for quiet study.",
      "occupancy": 40,
      "capacity": 50,
      "type": Facility.study,
    },
  ],
  "Fitness & Sports": [
    {
      "title": "Gym",
      "description": "Fully equipped gym for fitness training.",
      "occupancy": 30,
      "capacity": 100,
      "type": Facility.sports,
      "bookingLink": "https://example.com/gym-booking",
    },
    {
      "title": "Swimming Pool",
      "description": "Olympic-size pool for leisure and sport.",
      "occupancy": 10,
      "capacity": 50,
      "type": Facility.sports,
      "bookingLink": "https://example.com/pool-booking",
    },
    {
      "title": "Tennis Court",
      "description": "Outdoor tennis courts available for booking.",
      "occupancy": 2,
      "capacity": 10,
      "type": Facility.sports,
      "bookingLink": null,
    },
  ],
};
