import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/data/jobsImpl.dart';
import 'package:foundlunteer/data/usersImpl.dart';
import 'package:foundlunteer/domain/registeredJobs.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../constant/errorPage.dart';
import '../../constant/widget_lib.dart';
import '../../domain/resultState.dart';
import '../home/home_detail.dart';

class ApplyList extends StatefulWidget {
  final String? token;
  const ApplyList({super.key, this.token});

  @override
  State<ApplyList> createState() => _ApplyListState();
}

class _ApplyListState extends State<ApplyList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetJobProvider>(context, listen: false)
          .getRegisteredJobs(widget.token);
    });
  }

  Future<void> _pullRefresh() async {
    Provider.of<GetJobProvider>(context, listen: false)
        .getRegisteredJobs(widget.token);
    // why use freshNumbers var? https://stackoverflow.com/a/52992836/2301224
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetJobProvider>(
      builder: (context, registJob, _) {
        if (registJob.stateRegisteredJobs == ResultState.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (registJob.stateRegisteredJobs == ResultState.failed) {
          return ErrorPage(status: 1);
        } else if (registJob.stateRegisteredJobs == ResultState.serverError) {
          return ErrorPage(status: 1);
        } else {
          return Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(gradient: buttonGradient),
              ),
              title: Text(
                'Apply',
                style: title.copyWith(
                    fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
            ),
            body: (registJob.registeredJobs.registered?.isEmpty ?? true)
                ? ErrorPage(status: 0)
                : RefreshIndicator(
                    onRefresh: _pullRefresh,
                    child: ListView.builder(
                      padding: EdgeInsets.all(0.0),
                      shrinkWrap: true,
                      itemCount:
                          registJob.registeredJobs.registered?.length ?? 0,
                      itemBuilder: (BuildContext context, int i) {
                        var temp = registJob.registeredJobs.registered?[i];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomeDetail(
                                          index: i,
                                          job: temp.job!,
                                          registeredStatus: temp
                                              .registrationStatus
                                              .toString(),
                                        )));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 8.h),
                            child: listData(temp!),
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

  Widget listData(Registered job) {
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
                        image: (job.job?.image == null)
                            ? AssetImage('assets/organisasi.png')
                            : NetworkImage(job.job!.image.toString())
                                as ImageProvider,
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 8.h,
              ),
              SizedBox(
                width: 75.w,
                child: Text(
                  job.job?.organization?.user?.name ?? "",
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
                  job.job?.title ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: titleLarge,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  job.job?.description ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: normalText,
                  textAlign: TextAlign.start,
                  maxLines: 3,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Container(
                  width: 120.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                      color: (job.registrationStatus == "ONPROCESS")
                          ? blue10
                          : (job.registrationStatus == "REJECTED")
                              ? red10
                              : green10,
                      borderRadius: BorderRadius.circular(5.r)),
                  child: Center(
                    child: Text(
                      job.registrationStatus ?? "",
                      style: title.copyWith(
                          color: (job.registrationStatus == "ONPROCESS")
                              ? blue
                              : (job.registrationStatus == "REJECTED")
                                  ? red
                                  : green,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
