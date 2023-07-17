import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/constant/widget_lib.dart';

import 'color.dart';

class ErrorPage extends StatelessWidget {
  ErrorPage({super.key, required this.status});
  int status;

  @override
  Widget build(BuildContext context) {
    return (status == 0)
        ? noData()
        : Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(gradient: buttonGradient),
              ),
              title: Text(
                (status == 0) ? 'Data' : 'Error Page',
                style: title.copyWith(
                    fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
            ),
            body: (status == 2) ? noInternet() : serverProblem());
  }
}
