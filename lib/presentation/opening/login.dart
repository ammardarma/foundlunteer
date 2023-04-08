import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/presentation/home/home_list.dart';
import 'package:foundlunteer/presentation/opening/pre_register.dart';

import '../../constant/widget_lib.dart';
import '../../constant/color.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _passwordVisible = true;
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
                  'Hallo!',
                  style: title,
                  maxLines: 3,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                width: 320.w,
                child: Text(
                  'Selamat datang kembali, silahkan masuk dengan akun anda',
                  style: paraghraf.copyWith(fontSize: 16.sp, height: 1.2.h),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 17.h,
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
                  decoration: inputDecorationTextInput(
                      hintText: "Masukkan email/username"),
                ),
              ),
              SizedBox(
                height: 16.h,
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
                    obscureText: _passwordVisible,
                    decoration: InputDecoration(
                      hintText: "Masukkan password",
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.sp, vertical: 16.sp),
                      hintStyle: TextStyle(
                        color: blackHintText,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        icon: Icon(_passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                            color: white, style: BorderStyle.solid, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                            color: white, style: BorderStyle.solid, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                            color: white, style: BorderStyle.solid, width: 1.2),
                      ),
                      isDense: true,
                    )),
              ),
              SizedBox(
                height: 14.h,
              ),
              SizedBox(
                width: 348.w,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Recovery password',
                    textAlign: TextAlign.end,
                    style: textLink,
                  ),
                ),
              ),
              SizedBox(
                height: 36.h,
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
                              builder: (BuildContext context) => HomeList()));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        onSurface: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: Text(
                      'Masuk',
                      style: textButton,
                    ),
                  )),
              SizedBox(
                height: 45.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum punya akun?",
                    style: textLink.copyWith(color: blackText),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PreRegister()));
                      },
                      child: Text(
                        "Daftar Sekarang",
                        style: textLink,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
