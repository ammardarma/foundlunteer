import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/data/jobsImpl.dart';
import 'package:foundlunteer/data/openingImpl.dart';
import 'package:foundlunteer/data/usersImpl.dart';
import 'package:foundlunteer/presentation/opening/splashscreen.dart';
import 'package:provider/provider.dart';

import 'constant/color.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => GetDataProvider()),
        ChangeNotifierProvider(create: (ctx) => GetUserProvider()),
        ChangeNotifierProvider(create: (ctx) => GetJobProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: white,
          primarySwatch: Colors.blue,
          fontFamily: 'Plus Jakarta Sans',
        ),
        builder: (context, widget) {
          ScreenUtil.init(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: widget!,
          );
        },
        home: const SplashScreen(),
      ),
    );
  }
}
