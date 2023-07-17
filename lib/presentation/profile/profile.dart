import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foundlunteer/constant/color.dart';
import 'package:foundlunteer/constant/widget_lib.dart';
import 'package:foundlunteer/data/usersImpl.dart';
import 'package:foundlunteer/domain/resultState.dart';
import 'package:foundlunteer/domain/users.dart';
import 'package:foundlunteer/presentation/opening/login.dart';
import 'package:foundlunteer/presentation/profile/data_diri.dart';
import 'package:foundlunteer/presentation/profile/data_dokumen.dart';
import 'package:foundlunteer/presentation/profile/ubah_password.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/painting.dart' as painting;

class Profile extends StatefulWidget {
  final String? token;
  const Profile({super.key, this.token});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SharedPreferences? prefs;
  bool _loading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetUserProvider>(
      builder: (context, users, _) {
        print(users.state);
        if (users.state == ResultState.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (users.state == ResultState.failed) {
          return Center(child: Text('Gagal mengambil data'));
        } else if (users.state == ResultState.serverError) {
          return Center(child: Text('Server sedang bermasalah'));
        } else {
          return SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              appBar: AppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(gradient: buttonGradient),
                ),
                centerTitle: true,
                title: Text(
                  'Profile',
                  style: titleLarge,
                ),
              ),
              body: LoadingOverlay(
                isLoading: _loading,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.h, vertical: 14.w),
                  width: screenWidth(context),
                  height: screenHeight(context),
                  decoration: BoxDecoration(color: whiteBackground),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (BuildContext context) =>
                            //             DataDiri()));
                          },
                          child: Container(
                            width: 362.w,
                            padding: EdgeInsets.only(
                                top: 15.h,
                                right: 12.w,
                                left: 12.w,
                                bottom: 20.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: white,
                              boxShadow: shadowButton,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl:
                                          "https://aws.senna-annaba.my.id/user/getimage?lettuce" +
                                              Random()
                                                  .nextInt(100000)
                                                  .toString(),
                                      httpHeaders: headers(widget.token!),
                                      placeholder: (context, url) {
                                        return Container(
                                          width: 79.w,
                                          height: 68.h,
                                          child: Image.asset(
                                            'assets/icons/data_diri.png',
                                            scale: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            gradient: buttonGradient,
                                          ),
                                        );
                                      },
                                      errorWidget: (context, url, error) {
                                        return Container(
                                          width: 79.w,
                                          height: 68.h,
                                          child: Image.asset(
                                            'assets/icons/data_diri.png',
                                            scale: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            gradient: buttonGradient,
                                          ),
                                        );
                                      },
                                      imageBuilder: (context, imageProvider) {
                                        return GestureDetector(
                                          onTap: () {
                                            viewPhoto(context, imageProvider);
                                          },
                                          child: Container(
                                            width: 79.w,
                                            height: 68.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover)),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Container(
                                      width: 100.w,
                                      height: 24.h,
                                      decoration: BoxDecoration(
                                          color: (users.users.user?.role ==
                                                  "INDIVIDUAL")
                                              ? green10
                                              : red10,
                                          borderRadius:
                                              BorderRadius.circular(5.r)),
                                      child: Center(
                                        child: Text(
                                          users.users.user?.role ?? "",
                                          style: textLink.copyWith(
                                              color: (users.users.user?.role ==
                                                      "INDIVIDUAL")
                                                  ? green
                                                  : red,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          users.users.user?.name.toString() ??
                                              "",
                                          overflow: TextOverflow.ellipsis,
                                          style: titleLarge,
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 5.w, right: 10.w),
                                              height: 24.h,
                                              decoration: BoxDecoration(
                                                  color: green10,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r)),
                                              child: Center(
                                                  child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                    Icon(
                                                      FontAwesomeIcons.phone,
                                                      color: green,
                                                      size: 12,
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Text(
                                                      users.users.user?.phone ??
                                                          "",
                                                      style: textLink.copyWith(
                                                          color: green,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ])),
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            (users.users.social != null)
                                                ? Container(
                                                    padding: EdgeInsets.only(
                                                        left: 5.w, right: 10.w),
                                                    height: 24.h,
                                                    decoration: BoxDecoration(
                                                        color: blue10,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.r)),
                                                    child: Center(
                                                        child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .instagram,
                                                            color: blue,
                                                            size: 14,
                                                          ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          Text(
                                                            users.users
                                                                    .social ??
                                                                "",
                                                            style: textLink.copyWith(
                                                                color: blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ])),
                                                  )
                                                : Container(),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            (users.users.leader != null)
                                                ? Container(
                                                    padding: EdgeInsets.only(
                                                        left: 5.w, right: 10.w),
                                                    height: 24.h,
                                                    decoration: BoxDecoration(
                                                        color: whiteTanggal,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.r)),
                                                    child: Center(
                                                        child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                          Icon(
                                                            Icons
                                                                .face_retouching_natural_sharp,
                                                            color: blackTitle,
                                                            size: 14,
                                                          ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          Text(
                                                            users.users
                                                                    .leader ??
                                                                "",
                                                            style: textLink.copyWith(
                                                                color:
                                                                    blackTitle,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ])),
                                                  )
                                                : Container(),
                                            (users.users.birthOfDate != null)
                                                ? Container(
                                                    padding: EdgeInsets.only(
                                                        left: 5.w, right: 10.w),
                                                    height: 24.h,
                                                    decoration: BoxDecoration(
                                                        color: whiteTanggal,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.r)),
                                                    child: Center(
                                                        child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .birthdayCake,
                                                            color: blackTitle,
                                                            size: 14,
                                                          ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          Text(
                                                            DateFormat.yMMMMd().format(DateTime.parse(users
                                                                    .users
                                                                    .birthOfDate ??
                                                                new DateFormat(
                                                                        'yyyy-MM-dd')
                                                                    .format(
                                                                        DateTime(
                                                                            1)))),
                                                            style: textLink.copyWith(
                                                                color:
                                                                    blackTitle,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ])),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                        users.users.user?.address.toString() ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        style: normalText,
                                        textAlign: TextAlign.justify,
                                        maxLines: 6,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        Text(
                          "Pengaturan",
                          style: titleLarge,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => DataDiri(
                                          token: widget.token!,
                                        )));
                          },
                          child: Container(
                            width: 362.w,
                            height: 40.h,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.r),
                              color: white,
                              boxShadow: shadowButton,
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/data_diri.png',
                                  color: blackTitle,
                                  scale: 1,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  "Ubah Data Pribadi",
                                  style: title.copyWith(fontSize: 12.sp),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        (users.users.user?.role == 'INDIVIDUAL')
                            ? GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    _loading = true;
                                  });
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await users.getMyFile(
                                      prefs.getString('token').toString());
                                  print(users.stateFiles);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              DataDokumen()));
                                  setState(() {
                                    _loading = false;
                                  });
                                },
                                child: Container(
                                  width: 362.w,
                                  height: 40.h,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.r),
                                    color: white,
                                    boxShadow: shadowButton,
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/icons/data_dokumen.png',
                                        color: blackTitle,
                                        scale: 1,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Text(
                                        "Ubah Data Dokumen",
                                        style: title.copyWith(fontSize: 12.sp),
                                      ),
                                      Spacer(),
                                      Icon(Icons.arrow_forward_ios_rounded)
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(),
                        (users.users.user?.role == 'INDIVIDUAL')
                            ? SizedBox(
                                height: 12.h,
                              )
                            : SizedBox(),
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        UbahPassword()));
                          },
                          child: Container(
                            width: 362.w,
                            height: 40.h,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.r),
                              color: white,
                              boxShadow: shadowButton,
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/password.png',
                                  color: blackTitle,
                                  scale: 1,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  "Ubah Password",
                                  style: title.copyWith(fontSize: 12.sp),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 362.w,
                            height: 40.h,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.r),
                              color: white,
                              boxShadow: shadowButton,
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/star.png',
                                  color: blackTitle,
                                  scale: 1,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  "Beri Ulasan Foundlunteer",
                                  style: title.copyWith(fontSize: 12.sp),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        GestureDetector(
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove('token');
                            await CachedNetworkImage.evictFromCache(
                                "https://aws.senna-annaba.my.id/user/getimage");
                            painting.imageCache.clear();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Login()));
                          },
                          child: Container(
                            width: 362.w,
                            height: 40.h,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.r),
                              color: white,
                              boxShadow: shadowButton,
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/direct.png',
                                  color: red,
                                  scale: 1,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  "Keluar",
                                  style: title.copyWith(
                                      fontSize: 12.sp, color: red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
