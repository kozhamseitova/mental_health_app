import 'package:flutter/material.dart';
import 'package:mental_health_app/src/features/authentication/screens/home/home_screen.dart';
import 'package:mental_health_app/src/features/authentication/screens/main/home_icon_icons.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Text("Hello!"),
  ];

  void onSelectTab(int index) {
    print(index);
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(HomeIcon.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_box_rounded), label: ''),
        ],
        onTap: onSelectTab,
      ),
    );
  }
}
