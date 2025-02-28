
import 'package:adminapp/distrit.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int selectedIndex = 0;

  List<String> pageName = [
    'Dashboard',
    'District',
  ];

  List<IconData> pageIcon = [
    Icons.home,
    Icons.location_city,
  ];

  List<Widget> pageContent = [
    Center(child: Text("Dashboard Content", style: TextStyle(fontSize: 20))), // Replace with actual dashboard content
    District(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Row(
        children: [
          // Sidebar
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[200],
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: pageName.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          leading: Icon(
                            pageIcon[index],
                            color: selectedIndex == index
                                ? Colors.blueAccent
                                : Colors.black,
                          ),
                          title: Text(
                            pageName[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: selectedIndex == index
                                  ? Colors.blueAccent
                                  : Colors.black,
                            ),
                          ),
                          tileColor:
                              selectedIndex == index ? Colors.blue.shade100 : null,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main Content
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.white,
              child: pageContent[selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
