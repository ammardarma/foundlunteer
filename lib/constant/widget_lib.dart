import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/constant/color.dart';

//apus ganti make .h/.w
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenArea(BuildContext context) =>
    MediaQuery.of(context).size.width * MediaQuery.of(context).size.height;

//textStyle

TextStyle normalText = TextStyle(
    color: blackText,
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    letterSpacing: -0.06,
    height: 1.2.h);

TextStyle normalTextBold = TextStyle(
    color: blackText,
    fontWeight: FontWeight.w600,
    fontSize: 12.sp,
    letterSpacing: -0.06);

TextStyle normalTextMedium = TextStyle(
    color: blackText,
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    letterSpacing: -0.06);

TextStyle normalTextMediumBold = TextStyle(
    color: blackText,
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
    letterSpacing: -0.06);

TextStyle normalTextLarge = TextStyle(
    color: blackText,
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    letterSpacing: -0.06);

TextStyle normalTextLargeBold = TextStyle(
    color: blackText,
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    letterSpacing: -0.06);

TextStyle normalTextXLarge = TextStyle(
    color: blackText,
    fontWeight: FontWeight.w400,
    fontSize: 18.sp,
    letterSpacing: -0.06);

TextStyle normalTextXLargeBold = TextStyle(
    color: blackText,
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
    letterSpacing: -0.06);

TextStyle normalTextXXLarge = TextStyle(
    color: blackText,
    fontWeight: FontWeight.w400,
    fontSize: 20.sp,
    letterSpacing: -0.06);

TextStyle normalTextXXLargeBold = TextStyle(
    color: blackText,
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
    letterSpacing: -0.06);

TextStyle textLink = TextStyle(
    color: blue,
    fontWeight: FontWeight.w600,
    fontSize: 12.sp,
    letterSpacing: -0.06);

TextStyle textButton = TextStyle(
    color: black,
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    letterSpacing: -0.06);

TextStyle titleMini = TextStyle(
    color: blackTitle,
    fontWeight: FontWeight.w600,
    fontSize: 10.sp,
    letterSpacing: -0.06);

TextStyle title = TextStyle(
    color: blackTitle,
    fontWeight: FontWeight.w600,
    fontSize: 12.sp,
    letterSpacing: -0.06);

TextStyle titleMedium = TextStyle(
    color: blackTitle,
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
    letterSpacing: -0.06);

TextStyle titleLarge = TextStyle(
    color: blackTitle,
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    letterSpacing: -0.06);

TextStyle titleXLarge = TextStyle(
    color: blackTitle,
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
    letterSpacing: -0.06);

List<BoxShadow>? shadowButton = [
  BoxShadow(
    color: black.withOpacity(0.25),
    spreadRadius: 0,
    blurRadius: 4,
    offset: Offset(0, 4),
  )
];

List<BoxShadow>? shadowTextFormField = [
  BoxShadow(
    color: black.withOpacity(0.20),
    spreadRadius: 0,
    blurRadius: 2,
    offset: Offset(0, 2),
  )
];

//GRADIENT
LinearGradient buttonGradient = LinearGradient(
    colors: [yellow, yellowDope],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

InputDecoration inputDecorationTextInput(
    {required String hintText, Widget? suffixIcon}) {
  return InputDecoration(
    hintText: hintText,
    contentPadding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 16.sp),
    hintStyle: TextStyle(
      color: blackHintText,
    ),
    suffixIcon: suffixIcon,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.r),
      borderSide: BorderSide(color: white, style: BorderStyle.solid, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.r),
      borderSide: BorderSide(color: white, style: BorderStyle.solid, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.r),
      borderSide:
          BorderSide(color: white, style: BorderStyle.solid, width: 1.2),
    ),
    isDense: true,
  );
}
