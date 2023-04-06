import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/constant/color.dart';
import 'package:foundlunteer/constant/widget_lib.dart';

import 'login.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(16.h),
          height: screenHeight(context),
          width: screenWidth(context),
          decoration: BoxDecoration(color: whiteBackground),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Image.asset(
                'assets/logo.png',
                height: 355.h,
                width: 390.w,
              ),
              SizedBox(
                width: 320.w,
                height: 69.h,
                child: Text(
                  'Foundlunteer mempertemukan antara organisasi yang membutuhkan sumber daya manusia dan manusia-manusia baik',
                  style: paraghraf.copyWith(height: 1.2.h),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              Container(
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
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Login()));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        onSurface: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: Text(
                      'Mulai',
                      style: textButton,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
