import 'package:comp3330_project/models/facility_category.dart';
import 'package:comp3330_project/providers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoCard extends StatefulWidget {
  final String id;
  final String title;
  final String location;
  final String? description;
  final int? occupancy;
  final int capacity;
  final FacilityType type;
  final String? bookingLink;

  const InfoCard({
    super.key,
    required this.id,
    required this.title,
    required this.location,
    this.description,
    this.occupancy,
    required this.capacity,
    required this.type,
    this.bookingLink,
  });

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
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
        (widget.occupancy != null && widget.capacity > 0)
            ? (widget.occupancy! / widget.capacity)
            : 0.0;

    bool isLiked;
    final sharedPrefProvider = Provider.of<SharedPreferencesProvider>(context);
    isLiked = sharedPrefProvider.facilityIds.contains(widget.id);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.7,
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                      if (isLiked) {
                        sharedPrefProvider.addFacilityId(widget.id);
                      } else {
                        sharedPrefProvider.removeFacilityId(widget.id);
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Location: ${widget.location}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (widget.description != null)
              Text(
                widget.description!,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            const SizedBox(height: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Occupancy: ${(widget.occupancy == null) ? '--' : widget.occupancy} / ${widget.capacity}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: (widget.occupancy != null) ? occupancyPercentage : 0,
                  backgroundColor: Colors.grey[300],
                  color: Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (widget.bookingLink != null)
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    _launchBookingUrl(widget.bookingLink!);
                  },
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
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
