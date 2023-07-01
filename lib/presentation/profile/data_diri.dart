import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foundlunteer/data/usersImpl.dart';
import 'package:foundlunteer/domain/messages.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/color.dart';
import '../../constant/widget_lib.dart';
import '../../domain/resultState.dart';
import '../opening/login.dart';

class DataDiri extends StatefulWidget {
  const DataDiri({super.key});

  @override
  State<DataDiri> createState() => _DataDiriState();
}

class _DataDiriState extends State<DataDiri> {
  TextEditingController _email = TextEditingController();
  TextEditingController _nama = TextEditingController();
  TextEditingController _alamat = TextEditingController();
  TextEditingController _telepon = TextEditingController();
  TextEditingController _social = TextEditingController();
  TextEditingController _desc = TextEditingController();
  TextEditingController _age = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  GetUserProvider? data;
  Messages messages = Messages();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = context.read<GetUserProvider>();

    _email.text = data?.users.user?.email ?? "";
    _nama.text = data?.users.user?.name ?? "";
    _alamat.text = data?.users.user?.address ?? "";
    _telepon.text = data?.users.user?.phone ?? "";
    _social.text = data?.users.social ?? "";
    _desc.text = data?.users.description ?? "";

    if (data?.users.user?.role == "INDIVIDUAL") {
      var date = DateTime.parse(data!.users.birthOfDate.toString());
      _age.text = DateFormat.yMMMMd().format(date);
    } else {
      _age.text = data?.users.leader ?? "";
    }
  }

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
        title: Text(
          'Data Diri',
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
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 80.r,
                    backgroundImage: AssetImage('assets/foto_pribadi.jpeg'),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: yellow,
                        child: Icon(
                          Icons.camera_alt,
                          size: 24.0,
                          color: black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Container(
                    width: 348.w,
                    height: 38.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: white,
                      boxShadow: shadowTextFormField,
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.length < 2) {
                          return 'username/email tidak boleh kurang dari 2 huruf';
                        }
                      },
                      controller: _email,
                      onChanged: (value) {
                        if (value != _email.text) {
                          _email.text = value;
                        }
                      },
                      enabled: false,
                      decoration: inputDecorationTextInput(
                          hintText: "yourgmail@add.com",
                          suffixIcon: Icon(
                            FontAwesomeIcons.envelope,
                            size: 25,
                          )),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'nama tidak boleh kosong';
                        }
                      },
                      controller: _nama,
                      onChanged: (value) {
                        if (value != _nama.text) {
                          _nama.text = value;
                        }
                      },
                      keyboardType: TextInputType.text,
                      decoration: inputDecorationTextInput(
                          hintText: "Your Name",
                          suffixIcon: Icon(Icons.diversity_3_sharp)),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'alamat tidak boleh kosong';
                        }
                      },
                      controller: _alamat,
                      onChanged: (value) {
                        if (value != _alamat.text) {
                          _alamat.text = value;
                        }
                      },
                      maxLines: 10,
                      decoration: inputDecorationTextInput(
                          hintText: "Your Address",
                          suffixIcon: Icon(
                            Icons.pin_drop_rounded,
                            size: 27,
                          )),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'nomor telepon tidak boleh kosong';
                        }
                      },
                      controller: _telepon,
                      onChanged: (value) {
                        if (value != _telepon.text) {
                          _telepon.text = value;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: inputDecorationTextInput(
                          hintText: "Your Phone",
                          suffixIcon: Icon(
                            FontAwesomeIcons.whatsapp,
                            size: 27,
                          )),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'tanggal lahir tidak boleh kosong';
                        }
                      },
                      controller: _age,
                      onChanged: (value) {
                        if (value != _age.text) {
                          _age.text = value;
                        }
                      },
                      readOnly: (data?.users.user?.role == "INDIVIDUAL")
                          ? true
                          : false,
                      onTap: () async {
                        if (data?.users.user?.role == "INDIVIDUAL") {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(pickedDate);
                            String formattedDate =
                                DateFormat.yMMMMd().format(pickedDate);
                            print(formattedDate);
                            setState(() {
                              _age.text = formattedDate;
                            });
                          } else {
                            scaffoldBatal(context);
                          }
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: inputDecorationTextInput(
                          hintText: (data?.users.user?.role == "INDIVIDUAL")
                              ? "May 16, 2001"
                              : "Leader's name",
                          suffixIcon: Icon(
                            (data?.users.user?.role == "INDIVIDUAL")
                                ? FontAwesomeIcons.birthdayCake
                                : Icons.face_retouching_natural_sharp,
                            size: 22,
                          )),
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
                      controller: _social,
                      onChanged: (value) {
                        if (value != _social.text) {
                          _social.text = value;
                        }
                      },
                      decoration: inputDecorationTextInput(
                          hintText: "Your Instagram",
                          suffixIcon: Icon(
                            FontAwesomeIcons.instagram,
                            size: 27,
                          )),
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
                      controller: _desc,
                      onChanged: (value) {
                        if (value != _desc.text) {
                          _desc.text = value;
                        }
                      },
                      maxLines: 10,
                      decoration: inputDecorationTextInput(
                        hintText: "Describe yourself in here!",
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
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            if (data?.users.user?.role == "INDIVIDUAL") {
                              messages = await data!.putUsers(
                                  prefs.getString('token').toString(),
                                  _nama.text,
                                  _alamat.text,
                                  _telepon.text,
                                  _age.text,
                                  _desc.text,
                                  _social.text);
                            } else {
                              messages = await data!.putUsersOrganization(
                                  prefs.getString('token').toString(),
                                  _nama.text,
                                  _alamat.text,
                                  _telepon.text,
                                  _age.text,
                                  _desc.text,
                                  _social.text);
                            }
                            print(data?.state);
                            print(messages.message);
                            await afterInputAlert(
                                context, data!.statePutUsers, messages);
                            data!.getMyUsers(
                                prefs.getString('token').toString());
                            setState(() {
                              _isLoading = false;
                            });
                          }
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
        ),
      ),
    );
  }
}
