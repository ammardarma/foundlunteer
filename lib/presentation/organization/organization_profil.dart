import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constant/color.dart';
import '../../constant/widget_lib.dart';
import '../../domain/jobHome.dart';

class OrganizationProfil extends StatefulWidget {
  const OrganizationProfil({super.key, required this.jobs});
  final Jobs jobs;

  @override
  State<OrganizationProfil> createState() => _OrganizationProfilState();
}

class _OrganizationProfilState extends State<OrganizationProfil> {
  @override
  Widget build(BuildContext context) {
    print(widget.jobs.organization!.user!.name);
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
            'Profil Organisasi',
            style: title.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(14),
          width: screenWidth(context),
          height: screenHeight(context),
          decoration: BoxDecoration(color: whiteBackground),
          child: SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80.r,
                    backgroundColor: Colors.transparent,
                    backgroundImage: (widget.jobs.image == null)
                        ? AssetImage('assets/organisasi.png')
                        : NetworkImage(widget.jobs.image!) as ImageProvider,
                    child: Align(
                      alignment: Alignment.bottomRight,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    FontAwesomeIcons.usersRectangle,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      widget.jobs.organization!.user!.name.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: titleMedium,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    FontAwesomeIcons.phone,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    widget.jobs.organization!.user!.phone.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: normalTextBold,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    FontAwesomeIcons.solidEnvelope,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    widget.jobs.organization!.user!.email.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: normalTextBold,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    FontAwesomeIcons.squareInstagram,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: Text(
                      widget.jobs.organization?.social ?? "?",
                      overflow: TextOverflow.ellipsis,
                      style: normalTextBold,
                      textAlign: TextAlign.start,
                      maxLines: 6,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.pin_drop_rounded,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: Text(
                      widget.jobs.organization!.user!.address.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: normalTextBold,
                      textAlign: TextAlign.start,
                      maxLines: 6,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                child: Text(
                  "Pemimpin : ",
                  style: titleMedium,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  Icon(
                    Icons.face_retouching_natural_sharp,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    widget.jobs.organization?.leader ?? "Data belum dilengkapi",
                    overflow: TextOverflow.ellipsis,
                    style: normalTextBold,
                    textAlign: TextAlign.start,
                    maxLines: 6,
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                child: Text(
                  "Deskripsi : ",
                  style: titleMedium,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                  textAlign: TextAlign.justify,
                  style: normalText.copyWith(height: 1.2.h),
                  widget.jobs.organization?.description ??
                      "Data belum dilengkapi"),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 200.0,
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index) => Card(
                    child: Center(child: Text('Dummy Card Text')),
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}
