import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/domain/organizationJob.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../constant/color.dart';
import '../../constant/widget_lib.dart';
import '../../data/jobsImpl.dart';
import '../../domain/messages.dart';
import 'organization_job_list.dart';

class AddUpdateJob extends StatefulWidget {
  const AddUpdateJob({super.key, this.organizationJob, this.status});
  final OrganizationJob? organizationJob;
  final int? status;

  @override
  State<AddUpdateJob> createState() => _AddUpdateJobState();
}

class _AddUpdateJobState extends State<AddUpdateJob> {
  TextEditingController _title = TextEditingController();
  TextEditingController _desc = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _expiredAt = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  Messages messages = Messages();
  bool _loading = false;
  var _status = 0;
  var statusJob = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.organizationJob != null) {
      _status = widget.status!;
      _title.text = widget.organizationJob!.title!;
      _desc.text = widget.organizationJob!.description!;
      _location.text = widget.organizationJob!.location!;
      _expiredAt.text = DateFormat.yMMMMd()
          .format(DateTime.parse(widget.organizationJob!.expiredAt!));
    }
  }

  @override
  Widget build(BuildContext context) {
    var jobs = context.read<GetJobProvider>();
    return Scaffold(
        backgroundColor: whiteBackground,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: buttonGradient),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: blackTitle,
            ),
            onPressed: () async {
              while (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
          ),
          centerTitle: true,
          title: Text(
            (widget.organizationJob == null)
                ? 'Tambah Pekerjaan'
                : 'Edit Pekerjaan',
            style: title.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700),
          ),
        ),
        body: LoadingOverlay(
          isLoading: _loading,
          child: Container(
            padding: EdgeInsets.all(14),
            width: screenWidth(context),
            height: screenHeight(context),
            decoration: BoxDecoration(color: whiteBackground),
            child: SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Column(
                children: [
                  (widget.organizationJob != null)
                      ? ToggleSwitch(
                          minWidth: 90.0,
                          cornerRadius: 20.0,
                          activeBgColors: [
                            [Colors.green[800]!],
                            [Colors.red[800]!]
                          ],
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.white,
                          initialLabelIndex: _status,
                          totalSwitches: 2,
                          labels: ['OPEN', 'CLOSE'],
                          radiusStyle: true,
                          onToggle: (index) async {
                            setState(() {
                              _loading = true;
                              if (index == 0) {
                                _status = 0;
                                statusJob = "OPEN";
                              } else {
                                _status = 1;
                                statusJob = "CLOSE";
                              }
                            });
                            dialogBuilder(
                                context: context,
                                textContent:
                                    "Status pekerjaan diubah menjadi ${statusJob}",
                                iconContent: Icon(
                                  Icons.warning_amber_rounded,
                                  color: red,
                                  size: 30,
                                ));
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await jobs
                                .putStatusJob(prefs.getString('token'),
                                    widget.organizationJob!.id, statusJob)
                                .then((value) => afterInputAlert(
                                    context, jobs.stateUpdateStatusJob, value));
                            await jobs
                                .getJobsOrganization(prefs.getString('token'));
                            setState(() {
                              _loading = false;
                            });
                          },
                        )
                      : Container(),
                  SizedBox(
                    height: 7.h,
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
                      controller: _title,
                      onChanged: (value) {
                        if (value != _title.text) {
                          _title.text = value;
                        }
                      },
                      keyboardType: TextInputType.text,
                      decoration: inputDecorationTextInput(
                          hintText: "Nama Pekerjaan",
                          suffixIcon: Icon(Icons.work)),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'nama tidak boleh kosong';
                        }
                      },
                      controller: _location,
                      onChanged: (value) {
                        if (value != _location.text) {
                          _location.text = value;
                        }
                      },
                      keyboardType: TextInputType.text,
                      decoration: inputDecorationTextInput(
                          hintText: "Lokasi Pekerjaan",
                          suffixIcon: Icon(Icons.pin_drop_rounded)),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'nama tidak boleh kosong';
                        }
                      },
                      controller: _expiredAt,
                      readOnly: true,
                      onChanged: (value) {
                        if (value != _expiredAt.text) {
                          _expiredAt.text = value;
                        }
                      },
                      onTap: () async {
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

                          _expiredAt.text = formattedDate;
                        } else {
                          scaffoldBatal(context);
                        }
                      },
                      keyboardType: TextInputType.text,
                      decoration: inputDecorationTextInput(
                          hintText: "Tanggal Tutup Penerimaan",
                          suffixIcon: Icon(Icons.calendar_month_sharp)),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    width: 348.w,
                    height: 400.h,
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
                      controller: _desc,
                      onChanged: (value) {
                        if (value != _desc.text) {
                          _desc.text = value;
                        }
                      },
                      maxLines: 100,
                      keyboardType: TextInputType.text,
                      decoration: inputDecorationTextInput(
                          hintText: "Deskripsi Pekerjaan",
                          suffixIcon: Icon(Icons.description)),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
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
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await jobs
                                .postPutJob(
                                    prefs.getString('token'),
                                    widget.organizationJob?.id ?? "",
                                    _title.text,
                                    _location.text,
                                    _expiredAt.text,
                                    _desc.text)
                                .then((value) async {
                              if (value.message == 'success') {
                                setState(() {
                                  _loading = false;
                                });
                                dialogBuilder(
                                    context: context,
                                    textContent: value.message!,
                                    iconContent: Icon(
                                      Icons.done,
                                      size: 30,
                                      color: green,
                                    ),
                                    confirmButton: Align(
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: green),
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            setState(() {
                                              _loading = true;
                                            });
                                            await jobs
                                                .getJobsOrganization(
                                                    prefs.getString('token')!)
                                                .then((value) {
                                              setState(() {
                                                _loading = false;
                                              });
                                              while (
                                                  Navigator.canPop(context)) {
                                                Navigator.pop(context);
                                              }
                                            });
                                          },
                                          child: Text('OK')),
                                    ));
                              } else {
                                afterInputAlert(
                                    context, jobs.stateUpdateJob, value);
                              }
                            });
                          }
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
                    height: 20.h,
                  ),
                ],
              ),
            )),
          ),
        ));
  }
}
