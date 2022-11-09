import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_demo/view/mainScreen/buddies_screen.dart';
import 'package:project_demo/view/mainScreen/discover_screen.dart';
import 'package:project_demo/view/mainScreen/profile.dart';

class MainControlScreen extends StatefulWidget {
  const MainControlScreen({Key? key}) : super(key: key);

  @override
  State<MainControlScreen> createState() => _MainControlScreenState();
}

class _MainControlScreenState extends State<MainControlScreen> {
  int _selectedIndex = 0;
  List getScreen = [
    const DiscoverScreen(),
    const BuddiesScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getScreen[_selectedIndex],
        bottomNavigationBar: BottomNavyBar(
          iconSize: 18,
          selectedIndex: _selectedIndex,
          showElevation: false,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            bottomCompo(FontAwesomeIcons.searchengin, 'Discover'),
            bottomCompo(FontAwesomeIcons.userGroup, 'Buddies'),
            bottomCompo(FontAwesomeIcons.user, 'Profile'),
          ],
        ));
  }
}

BottomNavyBarItem bottomCompo(IconData icon, String title) {
  return BottomNavyBarItem(
      icon: Icon(
        icon,
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      activeColor: Colors.teal,
      inactiveColor: Colors.teal.withOpacity(0.5));
}
