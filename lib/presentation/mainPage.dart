import 'package:flutter/material.dart';
import 'package:foundlunteer/data/usersImpl.dart';
import 'package:foundlunteer/presentation/apply/apply_list.dart';
import 'package:foundlunteer/presentation/home/home_list.dart';
import 'package:foundlunteer/presentation/profile/data_dokumen.dart';
import 'package:foundlunteer/presentation/profile/profile.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/color.dart';
import '../constant/widget_lib.dart';
import '../data/jobsImpl.dart';
import '../domain/users.dart';
import 'organization/organization_job_list.dart';

class MainPage extends StatefulWidget {
  final String? token;
  const MainPage({super.key, this.token});

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetUserProvider>(context, listen: false)
          .getMyUsers(widget.token);
      Provider.of<GetJobProvider>(context, listen: false).getJobs(widget.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    var users = context.read<GetUserProvider>();
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
                      label: "Dashboard"),
                  BottomNavigationBarItem(
                      activeIcon:
                          ImageIcon(AssetImage('assets/icons/send.png')),
                      icon: ImageIcon(AssetImage('assets/icons/send.png')),
                      label: "Apply Job"),
                  BottomNavigationBarItem(
                      activeIcon:
                          ImageIcon(AssetImage('assets/icons/profile.png')),
                      icon: ImageIcon(AssetImage('assets/icons/profile.png')),
                      label: "My Profile"),
                ]),
            body: LazyLoadIndexedStack(index: _selectedIndex, children: [
              HomeList(
                token: widget.token,
              ),
              (users.users.user?.role == "INDIVIDUAL")
                  ? ApplyList(
                      token: widget.token,
                    )
                  : (users.users.user?.role == "ORGANIZATION")
                      ? OrganizationList(
                          token: widget.token!,
                        )
                      : Center(child: CircularProgressIndicator()),
              Profile(token: widget.token),
            ])));
  }
}
