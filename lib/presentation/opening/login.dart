import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/constant/sharedPrefs.dart';
import 'package:foundlunteer/data/jobsImpl.dart';
import 'package:foundlunteer/data/usersImpl.dart';
import 'package:foundlunteer/domain/resultState.dart';
import 'package:foundlunteer/presentation/home/home_list.dart';
import 'package:foundlunteer/presentation/mainPage.dart';
import 'package:foundlunteer/presentation/opening/pre_register.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/widget_lib.dart';
import '../../constant/color.dart';
import '../../data/openingImpl.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _passwordVisible = true;
  var _formKey = GlobalKey<FormState>();
  var _email = TextEditingController();
  var _password = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<GetDataProvider>(context);
    final dataUserProvider = Provider.of<GetUserProvider>(context);
    final dataJobsProvider = Provider.of<GetJobProvider>(context);
    final prefs = SharedPrefs();

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: LoadingOverlay(
          isLoading: _loading,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.h),
              height: screenHeight(context),
              width: screenWidth(context),
              decoration: BoxDecoration(color: whiteBackground),
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
                        'Hallo!',
                        style: titleXLarge,
                        maxLines: 3,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    SizedBox(
                      width: 320.w,
                      child: Text(
                        'Selamat datang kembali, silahkan masuk dengan akun anda',
                        style: normalTextMedium,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 17.h,
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
                      height: 16.h,
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
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _loading = true;
                              });
                              await dataProvider.getMyToken(
                                  _email.text, _password.text);
                              if (dataProvider.state == ResultState.failed) {
                                dialogBuilder(
                                    context: context,
                                    textContent:
                                        "Username atau password tidak sesuai",
                                    iconContent: Icon(
                                      Icons.warning_amber_outlined,
                                      color: red,
                                      size: 30,
                                    ));
                              } else if (dataProvider.state ==
                                  ResultState.serverError) {
                                dialogBuilder(
                                    context: context,
                                    textContent:
                                        "Maaf, server sedang bermasalah",
                                    iconContent: Icon(
                                        Icons.warning_amber_outlined,
                                        color: red,
                                        size: 30));
                              } else if (dataProvider.state ==
                                  ResultState.success) {
                                await dataUserProvider.getMyUsers(
                                    dataProvider.loginAccount.token);
                                await dataJobsProvider.getJobs(
                                    dataProvider.loginAccount.token, 1);
                                if (dataJobsProvider.stateJobs !=
                                    ResultState.success) {
                                  dialogBuilder(
                                      context: context,
                                      textContent:
                                          "Maaf, server sedang bermasalah",
                                      iconContent: Icon(
                                        Icons.warning_amber_outlined,
                                        color: red,
                                        size: 30,
                                      ));
                                } else {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('token',
                                      dataProvider.loginAccount.token!);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              MainPage(
                                                token: prefs.getString('token'),
                                              )));
                                }
                              }
                              setState(() {
                                _loading = false;
                              });
                            }
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
          ),
        ),
      ),
    );
  }
}
