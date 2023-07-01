import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/constant/sharedPrefs.dart';
import 'package:foundlunteer/data/openingImpl.dart';
import 'package:foundlunteer/presentation/opening/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/color.dart';
import '../../constant/widget_lib.dart';
import '../../domain/messages.dart';
import '../../domain/opening.dart';

class Register extends StatefulWidget {
  final String role;
  const Register({super.key, required this.role});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _passwordVisible = true;
  var _email = TextEditingController();
  var _password = TextEditingController();
  var _nama = TextEditingController();
  var _alamat = TextEditingController();
  var _noHP = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  Future<Messages>? _futureAccount;
  String? result;
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
            child: Form(
              key: _formKey,
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
                    height: 8.h,
                  ),
                  Container(
                    width: 348.w,
                    height: 45.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: white,
                      boxShadow: shadowTextFormField,
                    ),
                    child: Center(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.length < 2) {
                            return 'username/email tidak boleh kurang dari 2 huruf';
                          }
                        },
                        controller: _email,
                        decoration: InputDecoration.collapsed(
                          hintText: "Masukkan email/username",
                          hintStyle: TextStyle(
                            color: blackHintText,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Container(
                    width: 348.w,
                    height: 45.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: white,
                      boxShadow: shadowTextFormField,
                    ),
                    child: Center(
                      child: TextFormField(
                          validator: (value) {
                            if (value!.length <= 7) {
                              return 'password minimal harus 8 huruf';
                            }
                          },
                          controller: _password,
                          obscureText: _passwordVisible,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(top: 12.h, bottom: 0.h),
                            errorStyle: TextStyle(height: 0.5),
                            hintText: "Masukkan password",
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
                            border: InputBorder.none,
                            isDense: true,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Container(
                    width: 348.w,
                    height: 45.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: white,
                      boxShadow: shadowTextFormField,
                    ),
                    child: Center(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'nama tidak boleh kosong';
                          }
                        },
                        controller: _nama,
                        decoration: InputDecoration.collapsed(
                          hintText: "Masukkan nama lengkap/organisasi",
                          hintStyle: TextStyle(
                            color: blackHintText,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Container(
                    width: 348.w,
                    height: 116.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: white,
                      boxShadow: shadowTextFormField,
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'alamat tidak boleh kosong';
                        }
                      },
                      controller: _alamat,
                      maxLines: 10,
                      decoration: InputDecoration.collapsed(
                        hintText: "Masukkan alamat",
                        hintStyle: TextStyle(
                          color: blackHintText,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Container(
                    width: 348.w,
                    height: 45.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: white,
                      boxShadow: shadowTextFormField,
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: _noHP,
                        decoration: InputDecoration.collapsed(
                          hintText: "Masukkan nomor telepon",
                          hintStyle: TextStyle(
                            color: blackHintText,
                          ),
                        ),
                      ),
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
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          print(prefs.getString('token'));
                          if (_formKey.currentState!.validate()) {
                            _futureAccount = createAccount(
                                _email.text,
                                _password.text,
                                _nama.text,
                                _alamat.text,
                                _noHP.text,
                                widget.role);
                            if (_futureAccount != null) {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                    title: Align(
                                      alignment: Alignment.topRight,
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                            if (result == 'success') {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          Login()));
                                            }
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: red,
                                          )),
                                    ),
                                    titlePadding:
                                        EdgeInsets.only(top: 5.h, right: 10.h),
                                    contentPadding: EdgeInsets.only(
                                        bottom: 20.h, left: 20.w, right: 20.w),
                                    content: (_futureAccount != null)
                                        ? buildFutureBuilder()
                                        : Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                                CircularProgressIndicator()
                                              ])),
                              );
                            }
                          }
                        },
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
      ),
    );
  }

  FutureBuilder<Messages> buildFutureBuilder() {
    return FutureBuilder<Messages>(
        future: _futureAccount,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            result = snapshot.data!.message!;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                (result == 'success')
                    ? Icon(
                        Icons.check,
                        color: green,
                        size: 50,
                      )
                    : Icon(
                        Icons.warning_amber_outlined,
                        color: red,
                        size: 50,
                      ),
                Text(
                  snapshot.data!.message!,
                  style: title,
                  textAlign: TextAlign.center,
                )
              ],
            );
          }

          return Column(
              mainAxisSize: MainAxisSize.min,
              children: [CircularProgressIndicator()]);
        });
  }
}
