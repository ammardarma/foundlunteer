import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/constant/color.dart';
import 'package:foundlunteer/constant/widget_lib.dart';
import 'package:foundlunteer/data/jobsImpl.dart';
import 'package:foundlunteer/data/openingImpl.dart';
import 'package:foundlunteer/data/usersImpl.dart';
import 'package:foundlunteer/domain/resultState.dart';
import 'package:foundlunteer/presentation/home/home_detail.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../domain/jobHome.dart';

class HomeList extends StatefulWidget {
  final String? token;
  const HomeList({super.key, this.token});

  @override
  State<HomeList> createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetJobProvider>(builder: (context, jobs, _) {
      var users = context.read<GetUserProvider>();
      if (jobs.stateJobs == ResultState.loading) {
        return Center(child: CircularProgressIndicator());
      } else if (jobs.stateJobs == ResultState.failed) {
        return Center(child: Text('Gagal mengambil data'));
      } else if (jobs.stateJobs == ResultState.serverError) {
        return Center(child: Text('Server sedang bermasalah'));
      } else {
        if (users.state == ResultState.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (users.state == ResultState.failed) {
          return Center(child: Text('Gagal mengambil data'));
        } else if (users.state == ResultState.serverError) {
          return Center(child: Text('Server sedang bermasalah'));
        }
        return SafeArea(
          top: false,
          bottom: false,
          child: SlidingUpPanel(
            isDraggable: false,
            maxHeight: screenHeight(context) * 0.6,
            minHeight: screenHeight(context) * 0.6,
            panelBuilder: (ScrollController sc) => _scrollingList(sc, jobs),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r)),
            body: Container(
                padding: EdgeInsets.all(14),
                width: screenWidth(context) * 0.4,
                height: screenHeight(context) * 0.4,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [yellow, yellowDope],
                        begin: Alignment.topLeft,
                        end: Alignment.centerRight)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            users.users.user?.email ?? "",
                            style: title.copyWith(
                                fontSize: 12.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 100.w,
                      height: 24.h,
                      decoration: BoxDecoration(
                          color: (users.users.user?.role == "INDIVIDUAL")
                              ? green10
                              : red10,
                          borderRadius: BorderRadius.circular(5.r)),
                      child: Center(
                        child: Text(
                          users.users.user?.role ?? "",
                          style: textLink.copyWith(
                              color: (users.users.user?.role == "INDIVIDUAL")
                                  ? green
                                  : red,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
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
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              width: 186.w,
                              child: Text(
                                users.users.user?.name.toString() ?? "",
                                style: title.copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                          ],
                        ),
                        Spacer(),
                        CircleAvatar(
                            radius: 52,
                            backgroundColor: yellow,
                            backgroundImage: AssetImage(
                              "assets/foto_pribadi.jpeg",
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
    });
  }

  Widget _scrollingList(ScrollController sc, GetJobProvider jobs) {
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
            itemCount: jobs.jobs.jobs?.length ?? 0,
            itemBuilder: (BuildContext context, int i) {
              var job = jobs.jobs.jobs?[i];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomeDetail(
                                index: i,
                                job: job,
                              )));
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 0.h),
                  child: listData(job!),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }

  Widget listData(Jobs job) {
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
                width: 97.w,
                height: 80.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                        image: (job.image == null)
                            ? AssetImage('assets/organisasi.png')
                            : NetworkImage(job.image!) as ImageProvider,
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 6.h,
              ),
              SizedBox(
                width: 75.w,
                child: Text(
                  job.organization?.user?.name ?? "",
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
                  job.title ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: titleLarge,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  job.description ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: normalText,
                  textAlign: TextAlign.start,
                  maxLines: 2,
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
                          color: (job.jobStatus == "OPEN") ? green10 : red10,
                          borderRadius: BorderRadius.circular(5.r)),
                      child: Center(
                        child: Text(
                          job.jobStatus ?? "",
                          style: textLink.copyWith(
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
                            job.location ?? "",
                            style: textLink.copyWith(
                                color: blue, fontWeight: FontWeight.w700),
                          )
                        ]),
                      ),
                    ),
                  ],
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
