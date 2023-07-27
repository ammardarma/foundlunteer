import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foundlunteer/data/jobsImpl.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../constant/widget_lib.dart';
import '../../domain/jobHome.dart';
import '../../domain/resultState.dart';
import '../home/home_detail.dart';

class OrganizationProfil extends StatefulWidget {
  const OrganizationProfil({super.key, required this.jobs});
  final Jobs jobs;

  @override
  State<OrganizationProfil> createState() => _OrganizationProfilState();
}

class _OrganizationProfilState extends State<OrganizationProfil> {
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
            'Profil Organisasi',
            style: title.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700),
          ),
        ),
        body: Container(
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
                      if (widget.jobs.image != null) {
                        viewPhoto(context, NetworkImage(widget.jobs.image!));
                      }
                    },
                    child: CircleAvatar(
                      radius: 80.r,
                      backgroundColor: Colors.transparent,
                      backgroundImage: (widget.jobs.image == null)
                          ? AssetImage('assets/organisasi.png')
                          : NetworkImage(widget.jobs.image!) as ImageProvider,
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
                  widget.jobs.organization?.user?.name ?? "",
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
                              widget.jobs.organization?.user?.email ?? "",
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
                              widget.jobs.organization!.user!.phone ?? "",
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
                              widget.jobs.organization?.social ?? "?",
                              style: textLink.copyWith(
                                  color: blue, fontWeight: FontWeight.w700),
                            ),
                          ])),
                    )
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
                          widget.jobs.organization?.user?.address ?? "",
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
                  "Pimpinan : ",
                  style: title,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 5.w, right: 10.w, top: 10.h, bottom: 10.h),
                decoration: BoxDecoration(
                    color: gold10, borderRadius: BorderRadius.circular(5.r)),
                child: Center(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                      Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: Icon(
                          FontAwesomeIcons.crown,
                          color: gold,
                          size: 15,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Flexible(
                        child: Text(
                          widget.jobs.organization?.leader ??
                              "Belum menuliskan pimpinan",
                          style: textLink.copyWith(
                              color: gold, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ])),
              ),
              SizedBox(
                height: 8.h,
              ),
              SizedBox(
                child: Text(
                  "Deskripsi : ",
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
                          widget.jobs.organization?.description ??
                              "Belum menuliskan deskripsi",
                          style: textLink.copyWith(
                              color: blackText, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ])),
              ),
              SizedBox(
                height: 8.h,
              ),
              SizedBox(
                child: Text(
                  "Tawaran Pekerjaan : ",
                  style: title,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              SizedBox(
                height: 190.0,
                child: Consumer<GetJobProvider>(
                  builder: (context, jobs, _) {
                    if (jobs.stateJobsByFilterId == ResultState.loading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (jobs.stateJobsByFilterId == ResultState.failed) {
                      return Center(child: Text('Gagal mengambil data'));
                    } else if (jobs.stateJobsByFilterId ==
                        ResultState.serverError) {
                      return Center(child: Text('Server sedang bermasalah'));
                    } else {
                      return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: jobs.jobsByFilter.jobs?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            var job = jobs.jobsByFilter.jobs![index];
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HomeDetail(
                                                index: index,
                                                job: job,
                                              )));
                                },
                                child: Container(
                                    padding: EdgeInsets.only(
                                        left: 5.w,
                                        right: 8.w,
                                        top: 2.h,
                                        bottom: 10.h),
                                    child: listPekerjaanLainnya(index, job)));
                          });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
            ],
          )),
        ));
  }

  Widget listPekerjaanLainnya(int i, Jobs job) {
    return Container(
        padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h, bottom: 10.h),
        width: 140.w,
        decoration: BoxDecoration(
            color: whiteTanggal,
            borderRadius: BorderRadius.circular(5.r),
            boxShadow: shadowButton),
        child: Column(
          children: [
            Container(
              width: 150.w,
              height: 80.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                      image: (widget.jobs.image == null)
                          ? AssetImage('assets/organisasi.png')
                          : NetworkImage(widget.jobs.image!) as ImageProvider,
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 6.h,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                job.title ?? "",
                overflow: TextOverflow.ellipsis,
                style: titleMini,
                textAlign: TextAlign.start,
                maxLines: 1,
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                Container(
                  width: 58.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                      color: (job.jobStatus == "OPEN") ? green10 : red10,
                      borderRadius: BorderRadius.circular(5.r)),
                  child: Center(
                    child: Text(
                      job.jobStatus ?? "",
                      style: titleMini.copyWith(
                          color: (job.jobStatus == "OPEN") ? green : red,
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
                      color: blue10, borderRadius: BorderRadius.circular(5.r)),
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
                        job.location ?? "",
                        style: titleMini.copyWith(
                            color: blue, fontWeight: FontWeight.w700),
                      )
                    ]),
                  ),
                ),
              ]),
            )
          ],
        ));
  }
}
