import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/color.dart';
import '../../constant/widget_lib.dart';
import '../../data/usersImpl.dart';
import '../../domain/messages.dart';
import '../../domain/resultState.dart';

class DataDokumen extends StatefulWidget {
  const DataDokumen({super.key});

  @override
  State<DataDokumen> createState() => _DataDokumenState();
}

class _DataDokumenState extends State<DataDokumen> {
  GetUserProvider? data;
  Messages messages = Messages();
  File? cvPath;
  File? ijazahPath;
  File? sertifPath;
  var cvName = "";
  var ijazahName = "";
  var sertifName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = context.read<GetUserProvider>();
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
          'Data Dokumen',
          style: title.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(16.h),
          height: screenHeight(context),
          width: screenWidth(context),
          decoration: BoxDecoration(color: whiteBackground),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () async {
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(
                          type: FileType.custom, allowedExtensions: ['pdf']);

                  if (result != null) {
                    if (Platform.isIOS) {
                      File file = File(result.files.single.path ?? "file.pdf");
                      final documentPath = (await getTemporaryDirectory()).path;
                      File tempcvPath = await file
                          .copy('$documentPath/${path.basename(file.path)}');
                      setState(() {
                        cvName = result.files.single.name;
                        cvPath = tempcvPath;
                      });
                    } else {
                      setState(() {
                        cvName = result.files.single.name;
                        cvPath = File(result.files.single.path ?? "file.pdf");
                      });
                    }

                    if (result.files.single.size < 5000000) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      messages = await data!.postFileCV(
                          prefs.getString('token').toString(), cvPath!);
                      await afterInputAlert(
                          context, data!.stateFilesCV, messages);
                    }
                  } else {
                    scaffoldBatal(context);
                  }
                },
                child: Container(
                  width: 362.w,
                  height: 40.h,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    color: white,
                    boxShadow: shadowButton,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/icon_pdf.png',
                        color: blackTitle,
                        scale: 1,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      RichText(
                        text: TextSpan(
                          text: (cvName == "")
                              ? 'Upload Curriculum Vitae '
                              : cvName,
                          style: title.copyWith(fontSize: 12.sp),
                          children: const <TextSpan>[
                            TextSpan(text: '*', style: TextStyle(color: red)),
                          ],
                        ),
                      ),
                      Spacer(),
                      (data?.files.cv == true)
                          ? Icon(
                              Icons.check_circle,
                              color: green,
                            )
                          : (cvName == "")
                              ? Icon(Icons.arrow_forward_ios_rounded)
                              : Icon(
                                  Icons.check_circle,
                                  color: green,
                                )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              GestureDetector(
                onTap: () async {
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(
                          type: FileType.custom, allowedExtensions: ['pdf']);

                  if (result != null) {
                    if (Platform.isIOS) {
                      File file = File(result.files.single.path ?? "file.pdf");
                      final documentPath = (await getTemporaryDirectory()).path;
                      File tempIjazahPath = await file
                          .copy('$documentPath/${path.basename(file.path)}');
                      setState(() {
                        ijazahName = result.files.single.name;
                        ijazahPath = tempIjazahPath;
                      });
                    } else {
                      setState(() {
                        ijazahName = result.files.single.name;
                        ijazahPath =
                            File(result.files.single.path ?? "file.pdf");
                      });
                    }

                    if (result.files.single.size < 5000000) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      messages = await data!.postFileIjazah(
                          prefs.getString('token').toString(), ijazahPath!);
                      await afterInputAlert(
                          context, data!.stateFilesIjazah, messages);
                    }
                  } else {
                    scaffoldBatal(context);
                  }
                },
                child: Container(
                  width: 362.w,
                  height: 40.h,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    color: white,
                    boxShadow: shadowButton,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/icon_pdf.png',
                        color: blackTitle,
                        scale: 1,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      RichText(
                        text: TextSpan(
                          text: (ijazahName == "")
                              ? 'Upload Ijazah Pendidikan '
                              : ijazahName,
                          style: title.copyWith(fontSize: 12.sp),
                          children: const <TextSpan>[
                            TextSpan(text: '*', style: TextStyle(color: red)),
                          ],
                        ),
                      ),
                      Spacer(),
                      (data?.files.cv == true)
                          ? Icon(
                              Icons.check_circle,
                              color: green,
                            )
                          : (ijazahName == "")
                              ? Icon(Icons.arrow_forward_ios_rounded)
                              : Icon(
                                  Icons.check_circle,
                                  color: green,
                                )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              GestureDetector(
                onTap: () async {
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(
                          type: FileType.custom, allowedExtensions: ['pdf']);

                  if (result != null) {
                    if (Platform.isIOS) {
                      File file = File(result.files.single.path ?? "file.pdf");
                      final documentPath = (await getTemporaryDirectory()).path;
                      File tempSertifikatPath = await file
                          .copy('$documentPath/${path.basename(file.path)}');
                      setState(() {
                        sertifName = result.files.single.name;
                        sertifPath = tempSertifikatPath;
                      });
                    } else {
                      setState(() {
                        sertifName = result.files.single.name;
                        sertifPath =
                            File(result.files.single.path ?? "file.pdf");
                      });
                    }

                    if (result.files.single.size < 5000000) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      messages = await data!.postFileSertifikat(
                          prefs.getString('token').toString(), sertifPath!);
                      await afterInputAlert(
                          context, data!.stateFilesSertif, messages);
                    }
                  } else {
                    scaffoldBatal(context);
                  }
                },
                child: Container(
                  width: 362.w,
                  height: 40.h,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    color: white,
                    boxShadow: shadowButton,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/icon_pdf.png',
                        color: blackTitle,
                        scale: 1,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        (sertifName == "")
                            ? 'Upload Sertifikat (Optional) '
                            : sertifName,
                        style: title.copyWith(fontSize: 12.sp),
                      ),
                      Spacer(),
                      (data?.files.cv == true)
                          ? Icon(
                              Icons.check_circle,
                              color: green,
                            )
                          : (sertifName == "")
                              ? Icon(Icons.arrow_forward_ios_rounded)
                              : Icon(
                                  Icons.check_circle,
                                  color: green,
                                )
                    ],
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
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        onSurface: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: Text(
                      'Simpan',
                      style: textButton,
                    ),
                  )),
              SizedBox(
                height: 14.h,
              ),
            ]),
          )),
    );
  }
}
