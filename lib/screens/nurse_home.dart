import 'package:flutter/material.dart';
import 'package:medicare/screens/settings_screen.dart';
import 'package:medicare/screens/vaccinate_screen.dart';
import 'package:medicare/styles/colors.dart';
import 'package:medicare/tabs/ScheduleTab.dart';

class NurseHome extends StatefulWidget {
  const NurseHome({Key? key}) : super(key: key);

  @override
  _NurseHomeState createState() => _NurseHomeState();
}

List<Map> navigationBarItems = [
  {'icon': Icons.date_range, 'index': 0},
  {'icon': Icons.vaccines, 'index': 1},
  {'icon': Icons.settings, 'index': 2},
];

class _NurseHomeState extends State<NurseHome> {
  int _selectedIndex = 0;

  void goToSchedule() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [ScheduleTab(), VaccinateScreen(), SettingsScreen()];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(MyColors.primary),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        selectedItemColor: Color(MyColors.primary),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          for (var navigationBarItem in navigationBarItems)
            BottomNavigationBarItem(
              icon: Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border(
                    top: _selectedIndex == navigationBarItem['index']
                        ? BorderSide(color: Color(MyColors.bg01), width: 5)
                        : BorderSide.none,
                  ),
                ),
                child: Icon(navigationBarItem['icon'],
                    color: Color(MyColors.bg01)),
              ),
              label: '',
            ),
        ],
        currentIndex: _selectedIndex,
        onTap: (value) => setState(() {
          _selectedIndex = value;
        }),
      ),
    );
  }
}
