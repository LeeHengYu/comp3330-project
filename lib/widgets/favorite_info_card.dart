import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FavInfoCard extends StatelessWidget {
  final String title;
  final String location;
  final String? description;
  final int? occupancy;
  final int capacity;
  final String? bookingLink;

  const FavInfoCard({
    super.key,
    required this.title,
    required this.location,
    this.description,
    this.occupancy,
    required this.capacity,
    this.bookingLink,
  });

  Future<void> _launchBookingUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double occupancyPercentage =
        (occupancy != null && capacity > 0) ? (occupancy! / capacity) : 0.0;

    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.7,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Location: $location',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (description != null)
              Text(
                description!,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            const SizedBox(height: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Occupancy: ${(occupancy == null) ? '--' : occupancy} / $capacity',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: (occupancy != null) ? occupancyPercentage : 0,
                  backgroundColor: Colors.grey[300],
                  color: Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (bookingLink != null)
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    _launchBookingUrl(bookingLink!);
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.link, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Booking Link',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
