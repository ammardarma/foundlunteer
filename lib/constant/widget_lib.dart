import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/constant/color.dart';

import '../domain/messages.dart';
import '../domain/resultState.dart';

//apus ganti make .h/.w
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenArea(BuildContext context) =>
    MediaQuery.of(context).size.width * MediaQuery.of(context).size.height;

var baseUrl = "https://aws.senna-annaba.my.id";

headers(String token) {
  return <String, String>{
    'Content-Type': 'application/json',
    'Authorization': 'bearer ${token}'
  };
}

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
    contentPadding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
    hintStyle: TextStyle(
      color: blackHintText,
    ),
    suffixIcon: suffixIcon,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(color: white, style: BorderStyle.solid, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(color: white, style: BorderStyle.solid, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide:
          BorderSide(color: white, style: BorderStyle.solid, width: 1.2),
    ),
    isDense: true,
  );
}

Future<void> dialogBuilder(
    {required BuildContext context,
    required String textContent,
    required Icon iconContent,
    Widget? confirmButton}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        title: Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                color: red,
              )),
        ),
        titlePadding: EdgeInsets.only(top: 5.h, right: 10.h),
        contentPadding: EdgeInsets.only(bottom: 10.h, left: 20.w, right: 20.w),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconContent,
            SizedBox(
              height: 10.h,
            ),
            Text(
              textContent,
              style: title,
              textAlign: TextAlign.center,
            )
          ],
        ),
        actions: <Widget>[confirmButton ?? SizedBox()],
      );
    },
  );
}

Future<void> viewPhoto(BuildContext context, ImageProvider imageProvider) {
  return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Container(
            width: screenWidth(context) * 0.8,
            height: 250.h,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [],
            ),
          ),
        );
      });
}

Future<void> afterInputAlert(
    BuildContext context, ResultState state, Messages messages) async {
  if (state == ResultState.failed) {
    dialogBuilder(
        context: context,
        textContent: messages.message ?? "",
        iconContent: Icon(
          Icons.warning_amber_outlined,
          color: red,
          size: 30,
        ));
  } else if (state == ResultState.serverError) {
    dialogBuilder(
        context: context,
        textContent: "Maaf, server sedang bermasalah",
        iconContent: Icon(
          Icons.warning_amber_outlined,
          color: red,
          size: 30,
        ));
  } else if (state == ResultState.success) {
    dialogBuilder(
        context: context,
        textContent: messages.message ?? "",
        iconContent: Icon(Icons.check, color: green, size: 50));
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> scaffoldBatal(
    BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Center(child: Text("Batal")),
    ),
  );
}

Widget noData() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      Image.asset(
        'assets/data_notfound.png',
        scale: 2,
      ),
      SizedBox(height: 10.h),
      Text(
        'Ups, belum ada data!',
        style: title,
      ),
    ],
  );
}

Widget serverProblem() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      Image.asset(
        'assets/server_problem.png',
        scale: 2,
      ),
      SizedBox(height: 10.h),
      Text(
        'Maaf, server sedang bermasalah. Silahkan dicoba lagi nanti!',
        style: title,
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget noInternet() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      Image.asset(
        'assets/lost_connection.png',
        scale: 2,
      ),
      SizedBox(height: 10.h),
      Text(
        'Ups, Internet anda tidak bekerja dengan baik!',
        style: title,
        textAlign: TextAlign.center,
      ),
    ],
  );
}
