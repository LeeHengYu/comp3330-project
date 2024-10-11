import 'package:comp3330_project/constants/sample_data.dart';
import 'package:comp3330_project/widgets/info_card.dart';
import 'package:comp3330_project/widgets/main_page_app_bar.dart';
import 'package:flutter/material.dart';

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
  String selectedTab = "Dietary"; // State variable to track the current tab

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabLabels.length, vsync: this);

    // Listen to tab changes and update the state
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainPageAppBar(
        onHeartPressed: () {},
        onBellPressed: () {},
      ),
      body: Column(
        children: [
          Container(
            color: Colors.lightBlue,
            child: const SizedBox(
              height: 300,
              child: Center(child: Text("Google Maps placeholder")),
            ),
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
                      return ListView.builder(
                        itemCount: listItems[label]!.length,
                        itemBuilder: (context, index) {
                          var item = listItems[label]![index];

                          return InfoCard(
                            title: item['title'],
                            location: item['location'] ?? 'Unknown',
                            description: item['description'],
                            occupancy: item['occupancy'],
                            capacity: item['capacity'],
                            type: item['type'],
                            bookingLink: item['bookingLink'],
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
    );
  }
}
