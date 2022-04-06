import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/location_provider.dart';
import 'package:real_estate/providers/property_provider.dart';
import 'package:real_estate/screens/add_property.dart';
import 'package:real_estate/screens/booked_paged.dart';

import 'package:real_estate/screens/home.dart';
import 'package:real_estate/screens/map/map_screen.dart';
import 'package:real_estate/screens/map_overview/map_overview_screen.dart';
import 'package:real_estate/screens/settings/settings_screen.dart';
import 'package:real_estate/screens/user_profile.dart';
import 'package:real_estate/services/user_database.dart';
import 'package:real_estate/utils/constants.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedTab = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<PropertyProvider>(context, listen: false)
          .fetchProperties();
    });
  }

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<AuthProvider>(context, listen: false)
    //     .getUser(FirebaseAuth.instance.currentUser.uid);

    return Scaffold(
      body: selectedTabs[_selectedTab],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedTab,
        onTap: _handleIndexChanged,
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: Constants.primaryColor,
            unselectedColor: Colors.grey,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: const Icon(Icons.location_on),
            title: const Text("Explore"),
            selectedColor: Constants.primaryColor,
            unselectedColor: Colors.grey,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.settings),
            title: const Text("Profile"),
            unselectedColor: Colors.grey,
            selectedColor: Constants.primaryColor,
          ),
        ],
      ),
    );
  }
}

// enum _SelectedTab { home, likes, search, profile }
List selectedTabs = [
  const Home(),
  const MapOverviewScreen(),
  // const MapScreen(),
  const SettingsScreen(),
];
