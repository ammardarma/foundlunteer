import 'package:flutter/material.dart';
import 'package:foundlunteer/presentation/apply/apply_list.dart';
import 'package:foundlunteer/presentation/home/home_list.dart';
import 'package:foundlunteer/presentation/organization/organization_list.dart';
import 'package:foundlunteer/presentation/profile/profile.dart';

import '../constant/color.dart';
import '../constant/widget_lib.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }

  Widget showMainPage(int index) {
    late Widget tampil;
    if (index == 0) {
      tampil = HomeList();
    } else if (index == 1) {
      tampil = OrganizationList();
    } else if (index == 2) {
      tampil = ApplyList();
    } else if (index == 3) {
      tampil = Profile();
    }
    return tampil;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                selectedItemColor: blackTitle,
                iconSize: 25,
                selectedLabelStyle: textLink.copyWith(color: blackTitle),
                unselectedItemColor: blackHintText,
                unselectedLabelStyle: textLink.copyWith(color: blackHintText),
                showUnselectedLabels: true,
                items: [
                  BottomNavigationBarItem(
                      activeIcon: ImageIcon(
                          AssetImage('assets/icons/home_inactive.png')),
                      icon: ImageIcon(
                          AssetImage('assets/icons/home_inactive.png')),
                      label: "Home"),
                  BottomNavigationBarItem(
                      activeIcon:
                          ImageIcon(AssetImage('assets/icons/organisasi.png')),
                      icon:
                          ImageIcon(AssetImage('assets/icons/organisasi.png')),
                      label: "Organization"),
                  BottomNavigationBarItem(
                      activeIcon:
                          ImageIcon(AssetImage('assets/icons/send.png')),
                      icon: ImageIcon(AssetImage('assets/icons/send.png')),
                      label: "Apply"),
                  BottomNavigationBarItem(
                      activeIcon:
                          ImageIcon(AssetImage('assets/icons/profile.png')),
                      icon: ImageIcon(AssetImage('assets/icons/profile.png')),
                      label: "Profile"),
                ]),
            body: showMainPage(_selectedIndex)));
  }
}
