import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> tabLabels = [
    "Dietary",
    "Study Spaces",
    "Fitness & Sports",
  ];

  final Map<String, List<String>> listItems = {
    "Dietary": ["Cafeteria", "Vegan Options", "Salad Bar"],
    "Study Spaces": ["Library", "Study Room 101", "Silent Study Area"],
    "Fitness & Sports": ["Gym", "Swimming Pool", "Tennis Court"],
  };

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
            child: DefaultTabController(
              length: tabLabels.length,
              child: Column(
                children: [
                  TabBar(
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
                      children: tabLabels.map((label) {
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
          ),
        ],
      ),
    );
  }
}
