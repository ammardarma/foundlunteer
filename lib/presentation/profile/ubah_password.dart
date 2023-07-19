import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/color.dart';
import '../../constant/widget_lib.dart';

class UbahPassword extends StatefulWidget {
  const UbahPassword({super.key});

  @override
  State<UbahPassword> createState() => _UbahPasswordState();
}

class _UbahPasswordState extends State<UbahPassword> {
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
          'Ubah Password',
          style: title.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.h),
        height: screenHeight(context),
        width: screenWidth(context),
        decoration: BoxDecoration(color: whiteBackground),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 348.w,
              height: 45.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: white,
                boxShadow: shadowTextFormField,
              ),
              child: TextFormField(
                decoration: inputDecorationTextInput(hintText: "New Password"),
              ),
            ),
            SizedBox(
              height: 14.h,
            ),
            Container(
              width: 348.w,
              height: 45.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: white,
                boxShadow: shadowTextFormField,
              ),
              child: TextFormField(
                decoration:
                    inputDecorationTextInput(hintText: "Repeat New Password"),
              ),
            ),
            SizedBox(
              height: 20.h,
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
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      onSurface: Colors.transparent,
                      shadowColor: Colors.transparent),
                  child: Text(
                    'Ubah',
                    style: textButton,
                  ),
                )),
            SizedBox(
              height: 14.h,
            ),
          ],
        ),
      ),
    );
  }
}
