import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import 'package:flutter/painting.dart' as painting;

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
      Provider.of<GetJobProvider>(context, listen: false)
          .getJobs(widget.token, 1);
      painting.imageCache.clear();
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
                      activeIcon: Icon(
                        FontAwesomeIcons.house,
                        size: 25,
                      ),
                      icon: Icon(
                        FontAwesomeIcons.houseUser,
                        size: 25,
                      ),
                      label: "Dashboard"),
                  BottomNavigationBarItem(
                      activeIcon: Icon(
                        Icons.work,
                        size: 28,
                      ),
                      icon: Icon(
                        Icons.work_outline_outlined,
                        size: 28,
                      ),
                      label: "Apply Job"),
                  BottomNavigationBarItem(
                      activeIcon: Icon(
                        FontAwesomeIcons.userAlt,
                        size: 25,
                      ),
                      icon: Icon(FontAwesomeIcons.user),
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
