import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/presentation/opening/login.dart';
import 'package:foundlunteer/presentation/opening/register.dart';

import '../../constant/color.dart';
import '../../constant/widget_lib.dart';

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
                  style: titleXLarge,
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
                  style: normalTextMedium,
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
                              builder: (BuildContext context) => Register(
                                    role: "individual",
                                  )));
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
                            child: ImageIcon(
                                AssetImage('assets/icons/profile.png'))),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text('Individu', style: normalTextMediumBold),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Register(
                                    role: "organization",
                                  )));
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
                            child: ImageIcon(
                              AssetImage('assets/icons/organisasi.png'),
                            )),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text('Organisasi', style: normalTextMediumBold)
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
