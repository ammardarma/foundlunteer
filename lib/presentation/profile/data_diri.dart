import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foundlunteer/data/usersImpl.dart';
import 'package:foundlunteer/domain/messages.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/color.dart';
import '../../constant/widget_lib.dart';
import '../../domain/resultState.dart';
import '../opening/login.dart';

import 'package:flutter/painting.dart' as painting;

class DataDiri extends StatefulWidget {
  const DataDiri({super.key, required this.token});
  final String token;

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

  CroppedFile? croppedFile;
  XFile? result;
  File? image;
  File? file;

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
      if (data!.users.birthOfDate != null) {
        var date = DateTime.parse(data!.users.birthOfDate.toString());
        _age.text = DateFormat.yMMMMd().format(date);
      }
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
                  GestureDetector(
                    onTap: () async {
                      painting.imageCache.clear();
                      final ImagePicker picker = ImagePicker();
                      result = await picker
                          .pickImage(source: ImageSource.gallery)
                          .catchError((onError) {
                        dialogBuilder(
                            context: context,
                            textContent:
                                "Gagal mengambil gambar ini! (Corrupt)",
                            iconContent: Icon(
                              Icons.warning_amber_rounded,
                              color: red,
                              size: 30,
                            ));
                      });
                      var bytes = await result?.readAsBytes();
                      if (result != null) {
                        if (bytes!.length > 4100000) {
                          dialogBuilder(
                              context: context,
                              textContent:
                                  "Size foto terlalu besar (Maks 4MB) ",
                              iconContent: Icon(
                                Icons.warning_amber_rounded,
                                color: red,
                                size: 30,
                              ));
                        } else {
                          await _cropImage();
                          if (croppedFile != null) {
                            //check platform
                            if (Platform.isIOS) {
                              setState(() {
                                file = File(croppedFile?.path ?? "file.png");
                              });
                              final documentPath =
                                  (await getLibraryDirectory()).path;
                              File tempImage = await file!.copy(
                                  '$documentPath/${path.basename(file!.path)}');
                              setState(() {
                                image = tempImage;
                              });
                            } else {
                              setState(() {
                                image = File(croppedFile?.path ?? "file.png");
                              });
                            }
                            //check if image already select
                            if (image != null) {
                              setState(() {
                                _isLoading = true;
                              });
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              messages = await data!.postProfileImage(
                                  prefs.getString('token').toString(), image!);
                              await afterInputAlert(
                                  context, data!.stateProfileImage, messages);
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          } else {
                            scaffoldBatal(context);
                          }
                        }
                      } else {
                        scaffoldBatal(context);
                      }
                    },
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://aws.senna-annaba.my.id/user/getimage?image" +
                              Random().nextInt(10000).toString(),
                      httpHeaders: headers(widget.token),
                      placeholder: (context, url) {
                        return CircleAvatar(
                          radius: 80.r,
                          backgroundColor: yellow,
                          backgroundImage:
                              AssetImage('assets/icons/data_diri.png'),
                          child: Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator()),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return CircleAvatar(
                          radius: 80.r,
                          backgroundImage:
                              AssetImage('assets/icons/data_diri.png'),
                          backgroundColor: yellow,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              backgroundColor: yellow,
                              radius: 24,
                              child: Icon(
                                Icons.camera_alt,
                                size: 24.0,
                                color: black,
                              ),
                            ),
                          ),
                        );
                      },
                      imageBuilder: (context, imageProvider) {
                        return CircleAvatar(
                          radius: 80.r,
                          backgroundImage: imageProvider,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              backgroundColor: yellow,
                              radius: 24,
                              child: Icon(
                                Icons.camera_alt,
                                size: 24.0,
                                color: black,
                              ),
                            ),
                          ),
                        );
                      },
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
                            Icons.mail_sharp,
                            size: 25,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 348.w,
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
                          suffixIcon: Icon(
                            Icons.person,
                            size: 25,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
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
                    height: 10.h,
                  ),
                  Container(
                    width: 348.w,
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
                            size: 25,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 348.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: white,
                      boxShadow: shadowTextFormField,
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'tidak boleh kosong';
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
                      decoration: inputDecorationTextInput(
                          hintText: (data?.users.user?.role == "INDIVIDUAL")
                              ? "May 16, 2001"
                              : "Leader's name",
                          suffixIcon: Icon(
                            (data?.users.user?.role == "INDIVIDUAL")
                                ? FontAwesomeIcons.birthdayCake
                                : FontAwesomeIcons.crown,
                            size: 20,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 348.w,
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
                            size: 25,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
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

  Future<Null> _cropImage() async {
    croppedFile = await ImageCropper().cropImage(
      sourcePath: result!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
  }
}
