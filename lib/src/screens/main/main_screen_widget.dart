import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/features/auth.dart';
import 'package:mental_health_app/src/providers/auth_provider.dart';
import 'package:mental_health_app/src/screens/profile/doctor_profile_page.dart';
import 'package:provider/provider.dart';

import '../../models/user_data.dart';
import '../../services/db_service.dart';
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

  late AuthProvider _auth;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  int _selectedTab = 0;
  static List<Widget> _userOptions = <Widget>[
    HomeScreen(),
    MeditationScreen(),
    SleepScreen(),
    AppointmentRequestScreen(),
    UserProfileScreen(),
  ];

  static List<Widget> _psychologistOptions = <Widget>[
    HomeScreen(),
    MeditationScreen(),
    SleepScreen(),
    DoctorProfileScreen(),
  ];

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  late bool? isUser;

  List<BottomNavigationBarItem> userNavBars = [
    BottomNavigationBarItem(icon: Icon(HomeIcon.home), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.play_circle_outline), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.nights_stay_outlined), label: ''),
    BottomNavigationBarItem(
        icon: Icon(Icons.medical_information_outlined), label: ''),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_outlined), label: ''),
  ];

  List<BottomNavigationBarItem> psychologistNavBars = [
    BottomNavigationBarItem(icon: Icon(HomeIcon.home), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.play_circle_outline), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.nights_stay_outlined), label: ''),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_outlined), label: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider<AuthProvider>.value(
        value: AuthProvider.instance,
        child: Builder(
          builder: (BuildContext context) {
            _auth = Provider.of<AuthProvider>(context);
            return StreamBuilder<UserData>(
                stream: DBService.instance.getUserData(_auth.user!.uid),
                builder: (context, snapshot) {
                  var userData = snapshot.data;
                  return (userData != null)
                      ? Scaffold(
                          backgroundColor: cBackgroundColor,
                          body: (userData.role == "user")
                              ? _userOptions[_selectedTab]
                              : _psychologistOptions[_selectedTab],
                          bottomNavigationBar: BottomNavigationBar(
                            backgroundColor: cItemColor,
                            showUnselectedLabels: false,
                            showSelectedLabels: false,
                            currentIndex: _selectedTab,
                            items: (userData.role == "user") ? userNavBars : psychologistNavBars,
                            onTap: onSelectTab,
                          ))
                      : Scaffold(
                          backgroundColor: cBackgroundColor,
                          body: SizedBox(
                            height: 250,
                            child: SpinKitWanderingCubes(
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                          bottomNavigationBar: BottomNavigationBar(
                            backgroundColor: cItemColor,
                            showUnselectedLabels: false,
                            showSelectedLabels: false,
                            currentIndex: _selectedTab,
                            items: psychologistNavBars,
                            onTap: onSelectTab,
                          ));
                });
          },
        ),
      ),
    );
  }
}
