import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/constant/sharedPrefs.dart';
import 'package:foundlunteer/constant/widget_lib.dart';
import 'package:foundlunteer/data/jobsImpl.dart';
import 'package:foundlunteer/domain/messages.dart';
import 'package:foundlunteer/domain/organizationJob.dart';
import 'package:foundlunteer/presentation/home/home_list.dart';
import 'package:foundlunteer/presentation/organization/organization_post_job.dart';
import 'package:foundlunteer/presentation/organization/organization_profil.dart';
import 'package:foundlunteer/presentation/organization/organization_registrant_list.dart';
import 'package:foundlunteer/presentation/organization/organization_job_list.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/color.dart';
import '../../data/usersImpl.dart';
import '../../domain/jobHome.dart';

class HomeDetail extends StatefulWidget {
  const HomeDetail(
      {super.key,
      required this.index,
      required this.job,
      this.registeredStatus = "",
      this.organizationJob});
  final String registeredStatus;
  final int index;
  final Jobs job;
  final OrganizationJob? organizationJob;
  @override
  State<HomeDetail> createState() => _HomeDetailState();
}

class _HomeDetailState extends State<HomeDetail> {
  var _loading = false;
  @override
  Widget build(BuildContext context) {
    var users = context.read<GetUserProvider>();
    Messages messages = Messages();
    var jobs = context.read<GetJobProvider>();
    print(users.users.user?.role);
    var crDate = DateTime.parse(widget.job.createdAt!);
    var exDate = DateTime.parse(widget.job.expiredAt!);
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
          title: Text(
            'Detail Pekerjaan',
            style: title.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700),
          ),
        ),
        body: LoadingOverlay(
          isLoading: _loading,
          child: Container(
            padding: EdgeInsets.all(14),
            width: screenWidth(context),
            height: screenHeight(context),
            decoration: BoxDecoration(color: whiteBackground),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 362.w,
                    padding: EdgeInsets.only(
                        top: 11.h, right: 12.w, left: 12.w, bottom: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: white,
                      boxShadow: shadowButton,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            widget.job.title ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: titleLarge.copyWith(fontSize: 17.sp),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          widget.job.organization?.user?.name ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: normalText.copyWith(color: blackTitle),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 58.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                  color: (widget.job.jobStatus == "OPEN")
                                      ? green10
                                      : red10,
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Center(
                                child: Text(
                                  widget.job.jobStatus ?? "",
                                  style: textLink.copyWith(
                                      color: (widget.job.jobStatus == "OPEN")
                                          ? green
                                          : red,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 6.w,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.w),
                              height: 24.h,
                              decoration: BoxDecoration(
                                  color: blue10,
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Center(
                                child: Row(children: [
                                  Icon(
                                    Icons.pin_drop_rounded,
                                    color: blue,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Text(
                                    widget.job.location ?? "",
                                    style: textLink.copyWith(
                                        color: blue,
                                        fontWeight: FontWeight.w700),
                                  )
                                ]),
                              ),
                            ),
                            SizedBox(
                              width: 6.w,
                            ),
                            (widget.registeredStatus != "")
                                ? Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.w),
                                    height: 24.h,
                                    decoration: BoxDecoration(
                                        color: (widget.registeredStatus ==
                                                "ONPROCESS")
                                            ? whiteTanggal
                                            : (widget.registeredStatus ==
                                                    "REJECTED")
                                                ? red10
                                                : green10,
                                        borderRadius:
                                            BorderRadius.circular(5.r)),
                                    child: Center(
                                      child: Text(
                                        widget.registeredStatus,
                                        style: textLink.copyWith(
                                            color: (widget.registeredStatus ==
                                                    "ONPROCESS")
                                                ? blackTitle
                                                : (widget.registeredStatus ==
                                                        "REJECTED")
                                                    ? red
                                                    : green,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            (widget.organizationJob?.registrant?.length != null)
                                ? Container(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    height: 24.h,
                                    decoration: BoxDecoration(
                                        color: whiteTanggal,
                                        borderRadius:
                                            BorderRadius.circular(5.r)),
                                    child: Center(
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                          Text(
                                            "${widget.organizationJob?.registrant?.length} Pendaftar",
                                            style: textLink.copyWith(
                                                color: blackTitle,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ])),
                                  )
                                : Container()
                          ],
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Container(
                          width: 360.w,
                          height: 28.h,
                          decoration: BoxDecoration(
                              color: whiteTanggal,
                              borderRadius: BorderRadius.circular(5.r)),
                          child: Center(
                            child: Row(children: [
                              SizedBox(
                                width: 4.w,
                              ),
                              Icon(
                                Icons.calendar_month_sharp,
                                color: grey,
                                size: 20,
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              Text(
                                DateFormat.yMMMMd().format(crDate) +
                                    ' - ' +
                                    DateFormat.yMMMMd().format(exDate),
                                style: title.copyWith(fontSize: 12.sp),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        (widget.organizationJob?.registrant?.length != null)
                            ? Container(
                                width: 358.w,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [yellow, yellowDope],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                  borderRadius: BorderRadius.circular(5.r),
                                  boxShadow: shadowTextFormField,
                                ),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                RegistrantList(
                                                  registrant: widget
                                                          .organizationJob
                                                          ?.registrant ??
                                                      [],
                                                  jobId: widget.organizationJob
                                                          ?.id ??
                                                      "",
                                                )));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      onSurface: Colors.transparent,
                                      shadowColor: Colors.transparent),
                                  child: Text(
                                    'Lihat Pendaftar',
                                    style: titleMedium,
                                  ),
                                ))
                            : Container(
                                width: 358.w,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [yellow, yellowDope],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                  borderRadius: BorderRadius.circular(5.r),
                                  boxShadow: shadowTextFormField,
                                ),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                OrganizationProfil(
                                                  jobs: widget.job,
                                                )));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      onSurface: Colors.transparent,
                                      shadowColor: Colors.transparent),
                                  child: Text(
                                    'Lihat Profil',
                                    style: titleMedium,
                                  ),
                                )),
                        SizedBox(
                          height: 6.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Tentang Pekerjaan",
                    style: titleLarge,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                      textAlign: TextAlign.justify,
                      style: normalText.copyWith(height: 1.2.h),
                      widget.job.description ?? ""),
                  SizedBox(
                    height: 20.h,
                  ),
                  (widget.registeredStatus == "")
                      ? (users.users.user?.role == "INDIVIDUAL")
                          ? Container(
                              width: 358.w,
                              height: 38.h,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [yellow, yellowDope],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                borderRadius: BorderRadius.circular(5.r),
                                boxShadow: shadowButton,
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    _loading = true;
                                  });
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  messages = await jobs.registJob(
                                      prefs.getString('token'), widget.job.id!);
                                  afterInputAlert(
                                      context, jobs.stateRegisterJob, messages);

                                  setState(() {
                                    _loading = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.transparent,
                                    onSurface: Colors.transparent,
                                    shadowColor: Colors.transparent),
                                child: Text(
                                  'Daftar',
                                  style: textButton,
                                ),
                              ))
                          : Container()
                      : Container(),
                  (widget.organizationJob?.registrant?.length != null)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              Container(
                                  width: 150.w,
                                  height: 34.h,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [yellow, yellowDope],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight),
                                    borderRadius: BorderRadius.circular(5.r),
                                    boxShadow: shadowButton,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  AddUpdateJob(
                                                    organizationJob:
                                                        widget.organizationJob,
                                                    status:
                                                        (widget.job.jobStatus ==
                                                                'OPEN')
                                                            ? 0
                                                            : 1,
                                                  )));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.transparent,
                                        onSurface: Colors.transparent,
                                        shadowColor: Colors.transparent),
                                    child: Text(
                                      'Edit Pekerjaan',
                                      style: titleMedium,
                                    ),
                                  )),
                              Container(
                                  width: 150.w,
                                  height: 34.h,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5.r),
                                    boxShadow: shadowButton,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      dialogBuilder(
                                          context: context,
                                          textContent:
                                              "Anda yakin ingin menghapus pekerjaan ini?",
                                          iconContent: Icon(
                                            Icons.warning,
                                            size: 30,
                                            color: red,
                                          ),
                                          confirmButton: Align(
                                            alignment: Alignment.center,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: red),
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    _loading = true;
                                                  });
                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  await jobs
                                                      .deleteJob(
                                                          prefs.getString(
                                                              'token'),
                                                          widget.organizationJob
                                                              ?.id)
                                                      .then((value) async {
                                                    setState(() {
                                                      _loading = false;
                                                    });
                                                    if (value.message ==
                                                        'success') {
                                                      dialogBuilder(
                                                          context: context,
                                                          textContent:
                                                              value.message!,
                                                          iconContent: Icon(
                                                            Icons.done,
                                                            size: 30,
                                                            color: green,
                                                          ),
                                                          confirmButton: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child:
                                                                ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor:
                                                                            green),
                                                                    onPressed:
                                                                        () async {
                                                                      Navigator.pop(
                                                                          context);
                                                                      setState(
                                                                          () {
                                                                        _loading =
                                                                            true;
                                                                      });
                                                                      await jobs
                                                                          .getJobsOrganization(prefs.getString(
                                                                              'token')!)
                                                                          .then(
                                                                              (value) {
                                                                        setState(
                                                                            () {
                                                                          _loading =
                                                                              false;
                                                                        });
                                                                        while (Navigator.canPop(
                                                                            context)) {
                                                                          Navigator.pop(
                                                                              context);
                                                                        }
                                                                      });
                                                                    },
                                                                    child: Text(
                                                                        'OK')),
                                                          ));
                                                    } else {
                                                      afterInputAlert(
                                                          context,
                                                          jobs.stateDeleteJob,
                                                          value);
                                                    }
                                                  });
                                                },
                                                child: Text('OK')),
                                          ));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.transparent,
                                        onSurface: Colors.transparent,
                                        shadowColor: Colors.transparent),
                                    child: Text(
                                      'Hapus Pekerjaan',
                                      style: titleMedium.copyWith(color: white),
                                    ),
                                  ))
                            ])
                      : Container(),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
