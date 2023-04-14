import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/constant/widget_lib.dart';
import 'package:foundlunteer/presentation/home/home_list.dart';

import '../../constant/color.dart';

class HomeDetail extends StatefulWidget {
  const HomeDetail({super.key, required this.index});

  final int index;
  @override
  State<HomeDetail> createState() => _HomeDetailState();
}

class _HomeDetailState extends State<HomeDetail> {
  @override
  Widget build(BuildContext context) {
    print(widget.index);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: blackTitle,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomeList()));
            },
          ),
          title: Text(
            'Detail Pekerjaan',
            style: title.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700),
          ),
          backgroundColor: yellow,
        ),
        body: Container(
          padding: EdgeInsets.all(14),
          width: screenWidth(context),
          height: screenHeight(context),
          decoration: BoxDecoration(color: whiteBackground),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 362.w,
                  height: 130.h,
                  padding: EdgeInsets.only(
                      top: 11.h, right: 12.w, left: 12.w, bottom: 8.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: white,
                    boxShadow: shadowButton,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 117.w,
                        height: 107.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            image: DecorationImage(
                                image: AssetImage('assets/organisasi.png'),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: 6.h,
                            ),
                            Text(
                              'Coordinator Konser',
                              overflow: TextOverflow.ellipsis,
                              style: titleLarge,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Text(
                              'Rumah Singgah',
                              overflow: TextOverflow.ellipsis,
                              style: normalText.copyWith(color: blackTitle),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              width: 194.w,
                              height: 28.h,
                              decoration: BoxDecoration(
                                  color: whiteTanggal,
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Center(
                                child: Row(children: [
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Icon(
                                    Icons.calendar_month_sharp,
                                    color: grey,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                  Text(
                                    '20 Desember 2023',
                                    style: textLink.copyWith(
                                        color: grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ]),
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Container(
                              width: 58.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                  color: green10,
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Center(
                                child: Text(
                                  'OPEN',
                                  style: textLink.copyWith(
                                      color: green,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Tentang Pekerjaan",
                  style: titleLarge,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                    textAlign: TextAlign.start,
                    style: normalText.copyWith(height: 1.2.h),
                    '''Sebagai seorang volunteer, pekerjaan Anda adalah untuk memberikan bantuan sukarela dalam berbagai kegiatan atau acara yang diselenggarakan oleh organisasi non-profit atau masyarakat. Tugas Anda dapat bervariasi tergantung pada kebutuhan organisasi, tetapi umumnya termasuk:
        1. Menyediakan bantuan dalam penggalangan dana atau acara amal.
        2. Membantu dalam kegiatan yang terkait dengan pendidikan, seperti memberikan bimbingan belajar atau mengajar.
        3. Memberikan bantuan dalam acara olahraga atau kegiatan fisik lainnya.
        4. Menyediakan bantuan dalam acara sosial, seperti membantu di dapur makanan atau mengumpulkan donasi pakaian dan barang-barang lainnya.
        5. Mengambil bagian dalam program pengembangan komunitas, seperti kegiatan lingkungan atau revitalisasi kawasan.
        Sebagai seorang volunteer, Anda harus memiliki kemampuan untuk bekerja sama dalam tim, berkomunikasi dengan baik, dan memiliki sikap yang positif dan antusias terhadap tugas yang diberikan. Anda juga harus siap untuk belajar dan mengembangkan diri, serta menunjukkan kepedulian terhadap kebutuhan masyarakat yang Anda layani. Meskipun Anda tidak dibayar untuk pekerjaan ini, menjadi seorang volunteer dapat memberikan kepuasan pribadi dan merasa terlibat dalam membantu orang lain.'''),
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
                        'Daftar',
                        style: textButton,
                      ),
                    )),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ));
  }
}
