import 'package:comp3330_project/constants/sample_data.dart';
import 'package:comp3330_project/models/facility_category.dart';
import 'package:comp3330_project/providers/selected_facility.dart';
import 'package:comp3330_project/widgets/google_maps.dart';
import 'package:comp3330_project/widgets/info_card.dart';
import 'package:comp3330_project/widgets/main_page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<String> tabLabels = [
    "Dietary",
    "Study Spaces",
    "Fitness & Sports",
  ];

  late TabController _tabController;
  String selectedTab = "Dietary";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabLabels.length, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          selectedTab = tabLabels[_tabController.index];
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Facility> _getFacilitiesForSelectedTab() {
    FacilityType selectedCategory;
    switch (selectedTab) {
      case "Dietary":
        selectedCategory = FacilityType.food;
        break;
      case "Study Spaces":
        selectedCategory = FacilityType.study;
        break;
      case "Fitness & Sports":
        selectedCategory = FacilityType.sports;
        break;
      default:
        selectedCategory = FacilityType.food;
    }

    return facilities
        .where((facility) => facility.category == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final selectedFacilityProvider =
        Provider.of<SelectedFacilityProvider>(context);

    return Scaffold(
      appBar: MainPageAppBar(
        onHeartPressed: () {}, // TODO: to be implemented
        onBellPressed: () {}, // TODO: to be implemented
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(
              height: 300,
              child: GoogleMaps(),
            ),
            Expanded(
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    tabs: tabLabels.map((label) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          label,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: tabLabels.map((label) {
                        var filteredFacilities = _getFacilitiesForSelectedTab();

                        return ListView.builder(
                          itemCount: filteredFacilities.length,
                          itemBuilder: (context, index) {
                            var item = filteredFacilities[index];

                            return GestureDetector(
                              onTap: () {
                                selectedFacilityProvider
                                    .setSelectedFacility(item.id);
                              },
                              child: InfoCard(
                                title: item.name,
                                location: item.location,
                                description: item.description,
                                occupancy: item.occupancy,
                                capacity: item.capacity,
                                type: item.category,
                                bookingLink: item.bookingLink,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
