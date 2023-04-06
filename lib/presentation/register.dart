import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/presentation/login.dart';

import '../constant/color.dart';
import '../constant/widget_lib.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
          child: SingleChildScrollView(
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
                  height: 8.h,
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
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: BorderSide(
                              color: white, style: BorderStyle.solid, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: BorderSide(
                              color: white, style: BorderStyle.solid, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: BorderSide(
                              color: white,
                              style: BorderStyle.solid,
                              width: 1.2),
                        ),
                        isDense: true,
                      )),
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
                    decoration: inputDecorationTextInput(
                        hintText: "Masukkan nama lengkap/organisasi"),
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),
                Container(
                  width: 348.w,
                  height: 116.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: white,
                    boxShadow: shadowTextFormField,
                  ),
                  child: TextFormField(
                    decoration:
                        inputDecorationTextInput(hintText: "Masukkan alamat"),
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
                    decoration: inputDecorationTextInput(
                        hintText: "Masukkan nomor telepon"),
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          onSurface: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: Text(
                        'Daftar',
                        style: textButton,
                      ),
                    )),
                SizedBox(
                  height: 14.h,
                ),
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
                                    builder: (BuildContext context) =>
                                        Login()));
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
      ),
    );
  }
}
