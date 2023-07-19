import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foundlunteer/domain/organizationJob.dart';
import 'package:foundlunteer/presentation/organization/organization_registrant_detail.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../constant/color.dart';
import '../../constant/errorPage.dart';
import '../../constant/widget_lib.dart';

class RegistrantList extends StatefulWidget {
  const RegistrantList(
      {super.key, required this.registrant, required this.jobId});
  final List<Registrant> registrant;
  final String jobId;

  @override
  State<RegistrantList> createState() => _RegistrantListState();
}

class _RegistrantListState extends State<RegistrantList> {
  @override
  var _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: buttonGradient),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: blackTitle,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            'Pendaftar',
            style: title.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700),
          ),
        ),
        body: (widget.registrant.isEmpty)
            ? ErrorPage(status: 0)
            : LoadingOverlay(
                isLoading: _loading,
                child: Container(
                    padding: EdgeInsets.all(14),
                    width: screenWidth(context),
                    height: screenHeight(context),
                    decoration: BoxDecoration(color: whiteBackground),
                    child: ListView.builder(
                        itemCount: widget.registrant.length,
                        itemBuilder: (context, index) {
                          var users = widget.registrant[index];
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            RegistrantDetail(
                                              registrant: users,
                                              jobId: widget.jobId,
                                            )));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 4.h,
                                ),
                                child: listData(users),
                              ));
                        }))));
  }

  Widget listData(Registrant users) {
    return Container(
      width: 362.w,
      padding:
          EdgeInsets.only(top: 15.h, right: 12.w, left: 12.w, bottom: 20.h),
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
              GestureDetector(
                onTap: () {
                  if (users.image != null) {
                    viewPhoto(context, NetworkImage(users.image!));
                  }
                },
                child: Container(
                  width: 79.w,
                  height: 68.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                          image: (users.image != null)
                              ? NetworkImage(users.image!)
                              : AssetImage('assets/icons/data_diri.png')
                                  as ImageProvider,
                          fit: BoxFit.cover)),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: 90.w,
                height: 24.h,
                decoration: BoxDecoration(
                    color: (users.registrationStatus == "ONPROCESS")
                        ? blue10
                        : (users.registrationStatus == "ACCEPTED")
                            ? green10
                            : red10,
                    borderRadius: BorderRadius.circular(5.r)),
                child: Center(
                  child: Text(
                    users.registrationStatus ?? "",
                    style: textLink.copyWith(
                        color: (users.registrationStatus == "ONPROCESS")
                            ? blue
                            : (users.registrationStatus == "ACCEPTED")
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    users.individual?.user?.name.toString() ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: titleLarge,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5.w, right: 10.w),
                  height: 24.h,
                  decoration: BoxDecoration(
                      color: salmon10,
                      borderRadius: BorderRadius.circular(5.r)),
                  child: Center(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        Icon(
                          FontAwesomeIcons.envelope,
                          color: salmon,
                          size: 12,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          users.individual?.user?.email ?? "",
                          style: textLink.copyWith(
                              color: salmon, fontWeight: FontWeight.w700),
                        ),
                      ])),
                ),
                SizedBox(
                  height: 6.h,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 5.w, right: 10.w),
                        height: 24.h,
                        decoration: BoxDecoration(
                            color: green10,
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Center(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                users.individual?.user?.phone ?? "",
                                style: textLink.copyWith(
                                    color: green, fontWeight: FontWeight.w700),
                              ),
                            ])),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      (users.individual?.social != null)
                          ? Container(
                              padding: EdgeInsets.only(left: 5.w, right: 10.w),
                              height: 24.h,
                              decoration: BoxDecoration(
                                  color: blue10,
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Center(
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                    Icon(
                                      FontAwesomeIcons.instagram,
                                      color: blue,
                                      size: 14,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      users.individual?.social ?? "",
                                      style: textLink.copyWith(
                                          color: blue,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ])),
                            )
                          : Container(),
                      SizedBox(
                        width: 4.w,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5.w, right: 10.w),
                        height: 24.h,
                        decoration: BoxDecoration(
                            color: whiteTanggal,
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Center(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                              Icon(
                                FontAwesomeIcons.birthdayCake,
                                color: blackTitle,
                                size: 14,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                DateFormat.yMMMMd().format(DateTime.parse(
                                    users.individual!.birthOfDate ?? "")),
                                style: textLink.copyWith(
                                    color: blackTitle,
                                    fontWeight: FontWeight.w700),
                              ),
                            ])),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  users.individual?.user?.address.toString() ?? "",
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
    );
  }
}
