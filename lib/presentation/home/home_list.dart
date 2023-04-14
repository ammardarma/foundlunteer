import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/constant/color.dart';
import 'package:foundlunteer/constant/widget_lib.dart';
import 'package:foundlunteer/presentation/home/home_detail.dart';
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
      child: SlidingUpPanel(
        isDraggable: false,
        maxHeight: screenHeight(context) * 0.63,
        minHeight: screenHeight(context) * 0.63,
        panelBuilder: (ScrollController sc) => _scrollingList(sc),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
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
                            fontSize: 12.sp, fontWeight: FontWeight.w600),
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
                                fontSize: 21.sp, fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          width: 186.w,
                          child: Text(
                            "Ammar Ridwan Darma",
                            style: title.copyWith(
                                fontSize: 18.sp, fontWeight: FontWeight.w500),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    CircleAvatar(
                        radius: 42,
                        backgroundColor: yellow,
                        backgroundImage: AssetImage(
                          "assets/icons/profile_active.png",
                        )),
                    SizedBox(
                      height: 25.h,
                    ),
                  ],
                )
              ],
            )),
      ),
    );
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
            style: titleLarge,
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Flexible(
          child: ListView.builder(
            padding: EdgeInsets.all(0.0),
            shrinkWrap: true,
            controller: sc,
            itemCount: 10,
            itemBuilder: (BuildContext context, int i) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              HomeDetail(index: i)));
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 0.h),
                  child: listData(),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }

  Widget listData() {
    return Container(
      width: 362.w,
      height: 138.h,
      padding: EdgeInsets.only(top: 15.h, right: 12.w, left: 12.w, bottom: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: white,
        boxShadow: shadowButton,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 79.w,
                height: 68.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                        image: AssetImage('assets/organisasi.png'),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: 75.w,
                child: Text(
                  'Rumah Singgah',
                  overflow: TextOverflow.ellipsis,
                  style: titleMini,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 14.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Coordinator Konser',
                  overflow: TextOverflow.ellipsis,
                  style: titleLarge,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  'Membantu berjalannya konser akbar yang akan dimeriahkan oleh berbagai macam cara agar menjadi sebuah hal yang menarik',
                  overflow: TextOverflow.ellipsis,
                  style: normalText,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: 58.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                      color: green10, borderRadius: BorderRadius.circular(5.r)),
                  child: Center(
                    child: Text(
                      'OPEN',
                      style: textLink.copyWith(
                          color: green, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  "Lihat & Daftar > ",
                  style: title.copyWith(fontSize: 12.sp),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
