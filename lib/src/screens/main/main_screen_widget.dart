import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/features/auth.dart';

import '../appointment_request/appointment_request_screen.dart';
import '../home/home_screen.dart';
import '../meditation/meditation_screen.dart';
import '../profile/user_profile_screen.dart';
import '../sleep/sleep_screen.dart';
import 'home_icon_icons.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  int _selectedTab = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MeditationScreen(),
    SleepScreen(),
    AppointmentRequestScreen(),
    UserProfileScreen(),
  ];

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: cBackgroundColor,
        body: _widgetOptions[_selectedTab],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: cItemColor,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: _selectedTab,
          items: const [
            BottomNavigationBarItem(icon: Icon(HomeIcon.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.play_circle_outline), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.nights_stay_outlined), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.medical_information_outlined), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: ''),
          ],
          onTap: onSelectTab,
        )
      ),
    );
  }
}
