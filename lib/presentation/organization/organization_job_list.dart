import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/data/jobsImpl.dart';
import 'package:foundlunteer/domain/messages.dart';
import 'package:foundlunteer/domain/organizationJob.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../constant/color.dart';
import '../../constant/widget_lib.dart';
import '../../domain/jobHome.dart';
import '../../domain/resultState.dart';
import '../home/home_detail.dart';
import 'organization_post_job.dart';

class OrganizationList extends StatefulWidget {
  const OrganizationList({super.key, required this.token});
  final String token;

  @override
  State<OrganizationList> createState() => _OrganizationListState();
}

class _OrganizationListState extends State<OrganizationList> {
  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetJobProvider>(context, listen: false)
          .getJobsOrganization(widget.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetJobProvider>(
      builder: (context, jobs, _) {
        if (jobs.stateJobsByOrganization == ResultState.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (jobs.stateJobsByOrganization == ResultState.failed) {
          return Center(child: Text('Gagal mengambil data'));
        } else if (jobs.stateJobsByOrganization == ResultState.serverError) {
          return Center(child: Text('Server sedang bermasalah'));
        } else {
          print(jobs.jobsByOrganization.jobs?.length);
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AddUpdateJob()));
              },
              backgroundColor: yellow,
              child: Icon(
                Icons.add,
                color: black,
                size: 35,
              ),
            ),
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(gradient: buttonGradient),
              ),
              title: Text(
                'Pekerjaan Saya',
                style: title.copyWith(
                    fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
            ),
            body: LoadingOverlay(
              isLoading: _loading,
              child: ListView.builder(
                padding: EdgeInsets.all(0.0),
                shrinkWrap: true,
                itemCount: jobs.jobsByOrganization.jobs?.length ?? 0,
                itemBuilder: (BuildContext context, int i) {
                  var job = jobs.jobsByOrganization.jobs?[i];
                  return GestureDetector(
                    onTap: () async {
                      print(job.id);
                      setState(() {
                        _loading = true;
                      });
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await jobs.getJobOrganizationById(
                          prefs.getString('token'), job.id!);

                      if (jobs.stateJobsById == ResultState.failed) {
                        Messages failMessage = Messages(
                            message:
                                "Gagal mengambil data, silahkan coba lagi!");
                        afterInputAlert(
                            context, jobs.stateJobsById, failMessage);
                      } else if (jobs.stateJobsById ==
                          ResultState.serverError) {
                        Messages failServerMessage = Messages(
                            message:
                                "Server sedang bermasalah, silahkan coba lagi!");
                        afterInputAlert(
                            context, jobs.stateJobsById, failServerMessage);
                      } else if (jobs.stateJobsById == ResultState.success) {
                        setState(() {
                          _loading = false;
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => HomeDetail(
                                  index: i,
                                  job: job,
                                  organizationJob: jobs.organizationJobById,
                                )));
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.h),
                      child: listData(job!),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  Widget listData(Jobs job) {
    return Container(
      width: 362.w,
      padding:
          EdgeInsets.only(top: 15.h, right: 12.w, left: 12.w, bottom: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: white,
        boxShadow: shadowButton,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
                  job.description ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: normalText,
                  textAlign: TextAlign.start,
                  maxLines: 3,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "Edit & Lihat Pendaftar  > ",
                      style: title.copyWith(fontSize: 12.sp),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
