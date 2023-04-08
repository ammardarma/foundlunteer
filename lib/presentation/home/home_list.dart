import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/constant/color.dart';
import 'package:foundlunteer/constant/widget_lib.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeList extends StatefulWidget {
  const HomeList({super.key});

  @override
  State<HomeList> createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: blackTitle,
              iconSize: 25,
              selectedLabelStyle: textLink.copyWith(color: blackTitle),
              unselectedItemColor: blackHintText,
              unselectedLabelStyle: textLink.copyWith(color: blackHintText),
              showUnselectedLabels: true,
              items: [
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.home,
                  ),
                  icon: Icon(Icons.home_outlined),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.home_work_outlined,
                  ),
                  icon: Icon(Icons.home_work_outlined),
                  label: "Organization",
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.send,
                  ),
                  icon: Icon(Icons.send),
                  label: "Apply",
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.person,
                  ),
                  icon: Icon(Icons.person),
                  label: "Profile",
                ),
              ]),
          body: SlidingUpPanel(
            isDraggable: false,
            maxHeight: screenHeight(context) * 0.63,
            minHeight: screenHeight(context) * 0.63,
            panelBuilder: (ScrollController sc) => _scrollingList(sc),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r)),
            body: Container(
                padding: EdgeInsets.all(14),
                width: screenWidth(context),
                height: screenHeight(context),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [yellow, yellowDope],
                        begin: Alignment.topLeft,
                        end: Alignment.centerRight)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 38.h,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.mail_outlined,
                          size: 20,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        SizedBox(
                          width: 180.w,
                          height: 20.h,
                          child: Text(
                            "ammarcuy2@gmail.com",
                            style: title.copyWith(
                                fontSize: 12.sp, fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60.w,
                              height: 30.h,
                              child: Text(
                                "Hallo,",
                                style: title.copyWith(
                                    fontSize: 21.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              width: 186.w,
                              child: Text(
                                "Ammar Ridwan Darma",
                                style: title.copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                        Spacer(),
                        CircleAvatar(
                          radius: 42,
                          backgroundImage: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS81t_83dXLKRcS0poW3eqEehM7hZO-57I2-bKp4XuzwfQ5Asd4Zyfq_yVJwgftfQOS2Zc&usqp=CAU"),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ));
  }

  Widget _scrollingList(ScrollController sc) {
    return Container(
      padding: EdgeInsets.only(top: 5.h, right: 14.h, left: 14.h),
      decoration: BoxDecoration(
        color: whiteBackground,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Divider(
          thickness: 3,
          indent: 175,
          endIndent: 175,
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          width: 342.w,
          height: 42.h,
          margin: EdgeInsets.only(right: 10.w, left: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                bottomLeft: Radius.circular(10.r),
                topRight: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r)),
            color: white,
            boxShadow: shadowTextFormField,
          ),
          child: TextFormField(
              decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Cari Pekerjaan",
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.sp, vertical: 16.sp),
            hintStyle: TextStyle(
              color: blackHintText,
            ),
            suffixIcon: Container(
              width: 35.h,
              height: 35.h,
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: buttonGradient),
              child: IconButton(
                icon: Icon(
                  Icons.search_rounded,
                  size: 27,
                  color: white,
                ),
                onPressed: () {},
              ),
            ),
            isDense: true,
          )),
        ),
        SizedBox(
          height: 14.h,
        ),
        SizedBox(
          width: 222.w,
          height: 30.h,
          child: Text(
            "Daftar Pekerjaan",
            style: title.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            controller: sc,
            itemCount: 50,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                padding: const EdgeInsets.all(12.0),
                child: Text("$i"),
              );
            },
          ),
        ),
      ]),
    );
  }
}
