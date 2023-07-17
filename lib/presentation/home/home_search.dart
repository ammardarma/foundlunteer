import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../constant/errorPage.dart';
import '../../constant/widget_lib.dart';
import '../../data/jobsImpl.dart';
import '../../domain/jobHome.dart';
import '../../domain/registeredJobs.dart';
import '../../domain/resultState.dart';
import 'home_detail.dart';

class HomeSearch extends StatefulWidget {
  const HomeSearch({super.key, this.token});
  final String? token;

  @override
  State<HomeSearch> createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  TextEditingController _title = TextEditingController();
  TextEditingController _location = TextEditingController();

  Future<void> _pullRefresh() async {}

  @override
  Widget build(BuildContext context) {
    var jobs = context.read<GetJobProvider>();
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: buttonGradient),
        ),
        title: Text(
          'Search Page',
          style: title.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(children: [
        SizedBox(
          height: 10.h,
        ),
        Container(
          width: 348.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: white,
            boxShadow: shadowTextFormField,
          ),
          child: TextFormField(
            controller: _title,
            onChanged: (value) async {
              if (value != _title.text) {
                _title.text = value;
              }
              await jobs.getJobsByFilter(
                token: widget.token,
                title: value,
                location: _location.text,
              );
            },
            decoration: inputDecorationTextInput(
                hintText: "Cari berdasarkan nama pekerjaan",
                suffixIcon: Icon(
                  Icons.work,
                  size: 27,
                )),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          width: 348.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: white,
            boxShadow: shadowTextFormField,
          ),
          child: TextFormField(
            controller: _location,
            onChanged: (value) async {
              if (value != _location.text) {
                _location.text = value;
              }
              await jobs.getJobsByFilter(
                  token: widget.token,
                  title: _title.text,
                  location: value,
                  id: "");
            },
            decoration: inputDecorationTextInput(
                hintText: "Cari berdasarkan lokasi pekerjaan",
                suffixIcon: Icon(
                  Icons.pin_drop_rounded,
                  size: 27,
                )),
          ),
        ),
        SizedBox(
          height: 14.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Daftar Pekerjaan",
              style: titleLarge,
              textAlign: TextAlign.start,
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Expanded(
          child: Consumer<GetJobProvider>(builder: (context, jobs, _) {
            if (jobs.stateJobsByFilter == ResultState.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (jobs.stateJobsByFilter == ResultState.failed) {
              return ErrorPage(status: 1);
            } else if (jobs.stateJobsByFilter == ResultState.serverError) {
              return ErrorPage(status: 1);
            } else {
              // print(jobs.jobsByFilter.jobs!.length);
              return jobs.jobsByFilter.jobs?.isNotEmpty ?? false
                  ? ListView.builder(
                      padding: EdgeInsets.all(0.0),
                      shrinkWrap: true,
                      itemCount: jobs.jobsByFilter.jobs?.length ?? 0,
                      itemBuilder: (BuildContext context, int i) {
                        var temp = jobs.jobsByFilter.jobs![i];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomeDetail(
                                          index: i,
                                          job: temp,
                                        )));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 8.h),
                            child: listData(temp),
                          ),
                        );
                      },
                    )
                  : SingleChildScrollView(child: noData());
            }
          }),
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
