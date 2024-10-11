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

  // Sample data for the ListView, categorized based on the tab filters
  final Map<String, List<String>> listItems = {
    "Dietary": ["Cafeteria", "Vegan Options", "Salad Bar"],
    "Study Spaces": ["Library", "Study Room 101", "Silent Study Area"],
    "Fitness & Sports": ["Gym", "Swimming Pool", "Tennis Court"],
  };

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
      appBar: AppBar(
        title: const Text("HKU Main Campus Capacity Tracker"),
        backgroundColor: Colors.white,
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
                      // Create a ListView for each tab with filtered items
                      return ListView.builder(
                        itemCount: listItems[label]!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(listItems[label]![index]),
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
