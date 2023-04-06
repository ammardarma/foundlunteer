import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/presentation/login.dart';
import 'package:foundlunteer/presentation/register.dart';

import '../constant/color.dart';
import '../constant/widget_lib.dart';

class PreRegister extends StatefulWidget {
  const PreRegister({super.key});

  @override
  State<PreRegister> createState() => _PreRegisterState();
}

class _PreRegisterState extends State<PreRegister> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(21.h),
          height: screenHeight(context),
          width: screenWidth(context),
          decoration: BoxDecoration(color: whiteBackground),
          child: Column(
            children: [
              Image.asset(
                'assets/logo.png',
                height: 200.h,
                width: 220.w,
              ),
              SizedBox(
                height: 13.h,
              ),
              SizedBox(
                width: 320.w,
                child: Text(
                  'Buat Akun!',
                  style: title,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 89.h,
              ),
              SizedBox(
                width: 320.w,
                child: Text(
                  "Siapakah kamu?",
                  style: paraghraf,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 27.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Register()));
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: shadowTextFormField),
                          width: 48.w,
                          height: 40.h,
                          child: Icon(
                            Icons.person_outline_rounded,
                            size: 40,
                            color: blackText,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text('Individu',
                            style: paraghraf.copyWith(
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Register()));
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: shadowTextFormField),
                          width: 48.w,
                          height: 40.h,
                          child: Icon(
                            Icons.home_work_outlined,
                            size: 40,
                            color: blackText,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text('Organisasi',
                            style:
                                paraghraf.copyWith(fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sudah punya akun?",
                      style: textLink.copyWith(color: blackText),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Login()));
                        },
                        child: Text(
                          "Masuk",
                          style: textLink,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
