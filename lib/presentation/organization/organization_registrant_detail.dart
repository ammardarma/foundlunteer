import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foundlunteer/data/usersImpl.dart';
import 'package:foundlunteer/domain/organizationJob.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../constant/color.dart';
import '../../constant/pdfScreen.dart';
import '../../constant/widget_lib.dart';
import '../../data/jobsImpl.dart';

class RegistrantDetail extends StatefulWidget {
  const RegistrantDetail({super.key, this.registrant, required this.jobId});
  final Registrant? registrant;
  final String jobId;

  @override
  State<RegistrantDetail> createState() => _RegistrantDetailState();
}

class _RegistrantDetailState extends State<RegistrantDetail> {
  int _index = 1;
  String statusRegistrant = "";
  bool _loading = false;
  bool goBack = false;
  String cvPathPdf = "";
  String ijazahPathPdf = "";
  String sertifikatPathPdf = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if (widget.registrant != null) {
        if (widget.registrant?.registrationStatus == 'ONPROCESS') {
          _index = 1;
        } else if (widget.registrant?.registrationStatus == 'ACCEPTED') {
          _index = 0;
        } else {
          _index = 2;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var jobs = context.read<GetJobProvider>();
    var users = context.read<GetUserProvider>();
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
              if (goBack == true) {
                while (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                ;
              } else {
                Navigator.pop(context);
              }
            },
          ),
          title: Text(
            'Registrant Detail',
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.registrant?.image != null) {
                          viewPhoto(
                              context, NetworkImage(widget.registrant!.image!));
                        }
                      },
                      child: CircleAvatar(
                        radius: 80.r,
                        backgroundColor: Colors.transparent,
                        backgroundImage: (widget.registrant?.image == null)
                            ? AssetImage('assets/organisasi.png')
                            : NetworkImage(widget.registrant!.image!)
                                as ImageProvider,
                        child: Align(
                          alignment: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.registrant?.individual?.user?.name ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: titleMedium,
                    textAlign: TextAlign.center,
                    maxLines: 10,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      Container(
                        padding: EdgeInsets.only(left: 5.w, right: 10.w),
                        height: 24.h,
                        decoration: BoxDecoration(
                            color: salmon10,
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Center(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                              Icon(
                                Icons.mail_sharp,
                                color: salmon,
                                size: 14,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                widget.registrant?.individual?.user?.email ??
                                    "",
                                style: textLink.copyWith(
                                    color: salmon, fontWeight: FontWeight.w700),
                              ),
                            ])),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
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
                                widget.registrant?.individual?.user?.phone ??
                                    "",
                                style: textLink.copyWith(
                                    color: green, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                            ])),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5.w, right: 10.w),
                        height: 24.h,
                        decoration: BoxDecoration(
                            color: blue10,
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Center(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                                widget.registrant?.individual?.social ?? "?",
                                style: textLink.copyWith(
                                    color: blue, fontWeight: FontWeight.w700),
                              ),
                            ])),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 5.w,
                          right: 10.w,
                        ),
                        height: 24.h,
                        decoration: BoxDecoration(
                            color: gold10,
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Center(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                              Padding(
                                padding: EdgeInsets.only(top: 1.h),
                                child: Icon(
                                  FontAwesomeIcons.cakeCandles,
                                  color: gold,
                                  size: 15,
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                DateFormat.yMMMMd().format(DateTime.parse(widget
                                        .registrant?.individual?.birthOfDate ??
                                    "")),
                                style: textLink.copyWith(
                                    color: gold, fontWeight: FontWeight.w700),
                              ),
                            ])),
                      ),
                    ])),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 5.w, right: 10.w, top: 10.h, bottom: 10.h),
                  decoration: BoxDecoration(
                      color: blackTitle10,
                      borderRadius: BorderRadius.circular(5.r)),
                  child: Center(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                        Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: Icon(
                            Icons.pin_drop_rounded,
                            color: blackTitle,
                            size: 14,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Flexible(
                          child: Text(
                            widget.registrant?.individual?.user?.address ?? "",
                            style: textLink.copyWith(
                                color: blackTitle, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ])),
                ),
                SizedBox(
                  height: 8.h,
                ),
                SizedBox(
                  child: Text(
                    "Tentang Saya : ",
                    style: title,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 2.w, right: 2.w, top: 2.h, bottom: 10.h),
                  decoration: BoxDecoration(
                      color: whiteTanggal,
                      borderRadius: BorderRadius.circular(5.r)),
                  child: Center(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                        Flexible(
                          child: Text(
                            widget.registrant?.individual?.description ??
                                "Belum menuliskan deskripsi",
                            style: textLink.copyWith(
                                color: blackText, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ])),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  child: Text(
                    "Opsi : ",
                    style: title,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          _loading = true;
                        });
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await users
                            .getPDF(prefs.getString('token')!,
                                widget.registrant!.individual!.id!, "cv")
                            .then((value) => cvPathPdf = value!.path);

                        print(cvPathPdf);
                        setState(() {
                          _loading = false;
                        });
                        if (cvPathPdf != "") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PDFScreen(path: cvPathPdf)));
                        } else {
                          dialogBuilder(
                              context: context,
                              textContent: "Maaf, data tidak ditemukan!",
                              iconContent: Icon(
                                Icons.warning_amber_outlined,
                                size: 30,
                                color: red,
                              ));
                        }
                      },
                      child: Container(
                        width: 100.w,
                        padding: EdgeInsets.only(
                            left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
                        decoration: BoxDecoration(
                          color: salmon10,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Center(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                              Icon(
                                Icons.description_rounded,
                                color: salmon,
                                size: 60,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                'Lihat CV',
                                style: textLink.copyWith(
                                    color: salmon, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.justify,
                              ),
                            ])),
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          _loading = true;
                        });
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await users
                            .getPDF(prefs.getString('token')!,
                                widget.registrant!.individual!.id!, "ijazah")
                            .then((value) => ijazahPathPdf = value!.path);

                        print(ijazahPathPdf);
                        setState(() {
                          _loading = false;
                        });
                        if (ijazahPathPdf != "") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PDFScreen(path: ijazahPathPdf)));
                        } else {
                          dialogBuilder(
                              context: context,
                              textContent: "Maaf, data tidak ditemukan!",
                              iconContent: Icon(
                                Icons.warning_amber_outlined,
                                size: 30,
                                color: red,
                              ));
                        }
                      },
                      child: Container(
                        width: 100.w,
                        padding: EdgeInsets.only(
                            left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
                        decoration: BoxDecoration(
                          color: green10,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Center(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                              Icon(
                                Icons.description_rounded,
                                color: green,
                                size: 60,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                'Lihat Ijazah',
                                style: textLink.copyWith(
                                    color: green, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.justify,
                              ),
                            ])),
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          _loading = true;
                        });
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await users
                            .getPDF(
                                prefs.getString('token')!,
                                widget.registrant!.individual!.id!,
                                "sertifikat")
                            .then((value) => sertifikatPathPdf = value!.path);

                        print(cvPathPdf);
                        setState(() {
                          _loading = false;
                        });
                        if (sertifikatPathPdf != "") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PDFScreen(path: sertifikatPathPdf)));
                        } else {
                          dialogBuilder(
                              context: context,
                              textContent: "Maaf, data tidak ditemukan!",
                              iconContent: Icon(
                                Icons.warning_amber_outlined,
                                size: 30,
                                color: red,
                              ));
                        }
                      },
                      child: Container(
                        width: 100.w,
                        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                        decoration: BoxDecoration(
                          color: blue10,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Center(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                              Icon(
                                Icons.description_rounded,
                                color: blue,
                                size: 60,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                'Lihat Sertifikat',
                                style: textLink.copyWith(
                                    color: blue, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.justify,
                              ),
                            ])),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                (_index == 1)
                    ? Align(
                        alignment: Alignment.center,
                        child: ToggleSwitch(
                          minWidth: 90.0,
                          minHeight: 60.0,
                          initialLabelIndex: _index,
                          cornerRadius: 10.0,
                          animate: true,
                          curve: Curves.easeInOutCirc,
                          animationDuration: 400,
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.white,
                          totalSwitches: 3,
                          labels: ["ACCEPTED", "ONPROCESS", "REJECTED"],
                          fontSize: 10.0,
                          borderWidth: 1.0,
                          borderColor: [whiteTanggal],
                          activeBgColors: [
                            [green],
                            [blue],
                            [red]
                          ],
                          onToggle: (index) async {
                            dialogBuilder(
                                context: context,
                                textContent:
                                    "Anda hanya bisa mengubah ini satu kali, Anda yakin?",
                                iconContent: Icon(
                                  Icons.warning_amber_rounded,
                                  color: red,
                                  size: 30,
                                ),
                                confirmButton: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: red),
                                        onPressed: () async {
                                          setState(() {
                                            _loading = true;
                                            if (index == 0) {
                                              statusRegistrant = 'ACCEPTED';
                                            } else if (index == 1) {
                                              statusRegistrant = 'ONPROCESS';
                                            } else {
                                              statusRegistrant = 'REJECTED';
                                            }
                                            _index = index!;
                                            goBack = true;
                                          });
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          await jobs
                                              .putStatusRegistrant(
                                                  prefs.getString('token'),
                                                  widget.registrant!.individual!
                                                      .id,
                                                  widget.jobId,
                                                  statusRegistrant)
                                              .then((value) => afterInputAlert(
                                                  context,
                                                  jobs.stateUpdateStatusRegistrantJob,
                                                  value));
                                          await jobs.getJobsOrganization(
                                              prefs.getString('token'));
                                          setState(() {
                                            _loading = false;
                                          });
                                        },
                                        child: Text(
                                          'Setuju',
                                        ))));
                          },
                        ),
                      )
                    : Align(
                        alignment: Alignment.center,
                        child: ToggleSwitch(
                            minWidth: 90.0,
                            minHeight: 60.0,
                            initialLabelIndex: _index,
                            cornerRadius: 15.0,
                            animate: true,
                            curve: Curves.easeInOutCirc,
                            animationDuration: 400,
                            activeFgColor: Colors.white,
                            inactiveBgColor: (_index == 0) ? green : red,
                            inactiveFgColor: Colors.white,
                            totalSwitches: 1,
                            labels: (_index == 0) ? ["ACCEPTED"] : ["REJECTED"],
                            fontSize: 10.0,
                            borderWidth: 1.0,
                            borderColor: [whiteTanggal],
                            activeBgColors: [
                              (_index == 0) ? [green] : [red]
                            ],
                            onToggle: (index) async {}),
                      ),
                SizedBox(
                  height: 50.h,
                ),
              ],
            )),
          ),
        ));
  }
}
