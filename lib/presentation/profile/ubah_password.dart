import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/domain/messages.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/color.dart';
import '../../constant/widget_lib.dart';
import '../../data/usersImpl.dart';

class UbahPassword extends StatefulWidget {
  const UbahPassword({super.key});

  @override
  State<UbahPassword> createState() => _UbahPasswordState();
}

class _UbahPasswordState extends State<UbahPassword> {
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  bool _isLoading = false;
  Messages messages = Messages();
  @override
  Widget build(BuildContext context) {
    var users = context.read<GetUserProvider>();
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
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: Container(
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
                  controller: _password,
                  onChanged: (value) {
                    if (value != _password.text) {
                      _password.text = value;
                    }
                  },
                  decoration:
                      inputDecorationTextInput(hintText: "New Password"),
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
                  controller: _confirmPassword,
                  onChanged: (value) {
                    if (value != _confirmPassword.text) {
                      _confirmPassword.text = value;
                    }
                  },
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
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      if (_password.text == _confirmPassword.text) {
                        await users
                            .changePassword(prefs.getString('token').toString(),
                                _confirmPassword.text)
                            .then((value) {
                          afterInputAlert(
                              context, users.stateChangePassword, value);
                          setState(() {
                            _password.text = "";
                            _confirmPassword.text = "";
                          });
                        });
                      } else {
                        dialogBuilder(
                            context: context,
                            textContent: "Kedua input tidak sama!",
                            iconContent: Icon(
                              Icons.warning_amber_rounded,
                              size: 30,
                              color: red,
                            ));
                      }
                      setState(() {
                        _isLoading = false;
                      });
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
      ),
    );
  }
}
