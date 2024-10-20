import 'package:comp3330_project/alarm_setup_page.dart';
import 'package:comp3330_project/constants/sample_data.dart';
import 'package:comp3330_project/favorite_page.dart';
import 'package:comp3330_project/models/facility_category.dart';
import 'package:comp3330_project/providers/selected_category.dart';
import 'package:comp3330_project/providers/selected_facility.dart';
import 'package:comp3330_project/widgets/filter_toggle_button.dart';
import 'package:comp3330_project/widgets/google_maps.dart';
import 'package:comp3330_project/widgets/info_card.dart';
import 'package:comp3330_project/widgets/main_page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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
  final ItemScrollController _itemScrollController = ItemScrollController();

  bool isProgrammaticScroll = false;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: tabLabels.length, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        final selectedCategoryProvider =
            Provider.of<SelectedCategoryProvider>(context, listen: false);

        switch (_tabController.index) {
          case 0:
            selectedCategoryProvider.setSelectedCategory(FacilityType.food);
            break;
          case 1:
            selectedCategoryProvider.setSelectedCategory(FacilityType.study);
            break;
          case 2:
            selectedCategoryProvider.setSelectedCategory(FacilityType.sports);
            break;
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedFacilityProvider =
          Provider.of<SelectedFacilityProvider>(context, listen: false);

      selectedFacilityProvider.addListener(() {
        if (isProgrammaticScroll) {
          final facilityId = selectedFacilityProvider.selectedFacility;
          if (facilityId != null) {
            final selectedCategoryProvider =
                Provider.of<SelectedCategoryProvider>(context, listen: false);
            FacilityType selectedCategory =
                selectedCategoryProvider.selectedCategory;

            var filteredFacilities = facilities.where((facility) {
              return facility.category == selectedCategory;
            }).toList();

            _scrollToSelectedFacility(facilityId, filteredFacilities);
          }
          isProgrammaticScroll = false; // Reset flag after scrolling
        }
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _scrollToSelectedFacility(
    String facilityId,
    List<Facility> filteredFacilities,
  ) {
    final selectedFacilityIndex =
        filteredFacilities.indexWhere((facility) => facility.id == facilityId);

    if (selectedFacilityIndex != -1) {
      if (_itemScrollController.isAttached) {
        _itemScrollController.scrollTo(
          index: selectedFacilityIndex,
          duration: const Duration(milliseconds: 200),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedFacilityProvider =
        Provider.of<SelectedFacilityProvider>(context);

    final selectedCategoryProvider =
        Provider.of<SelectedCategoryProvider>(context);
    FacilityType selectedCategory = selectedCategoryProvider.selectedCategory;
    var filteredFacilities = facilities.where((facility) {
      return facility.category == selectedCategory;
    }).toList();

    return Scaffold(
      appBar: MainPageAppBar(
        title: "Main Campus Capacity Tracker",
        onHeartPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FavoritePage()),
          );
        },
        onBellPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AlarmSetupPage()),
          );
        },
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: GoogleMaps(
                onMarkerTap: () {
                  setState(() {
                    isProgrammaticScroll = true;
                  });
                },
              ),
            ),
            const SizedBox(
              width: double.infinity,
              child: FilterToggleButton(),
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
                    child: ScrollablePositionedList.builder(
                      itemCount: filteredFacilities.length,
                      itemScrollController: _itemScrollController,
                      itemBuilder: (context, index) {
                        var item = filteredFacilities[index];

                        return GestureDetector(
                          onTap: () {
                            isProgrammaticScroll = false;
                            selectedFacilityProvider
                                .setSelectedFacility(item.id);
                          },
                          child: InfoCard(
                            id: item.id,
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
