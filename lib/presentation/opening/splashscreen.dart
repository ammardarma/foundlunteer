import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundlunteer/constant/color.dart';
import 'package:foundlunteer/constant/widget_lib.dart';
import 'package:foundlunteer/presentation/opening/introduction.dart';

import 'introduction.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: 800),
    vsync: this,
  );

  late final Animation<double> _animation = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(_controller);

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    Future.delayed(
        Duration(
          milliseconds: 2500,
        ), () {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(
              seconds: 1,
            ),
            pageBuilder: (context, animation, animationTime) {
              return Introduction();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ));
    });
    return Scaffold(
      body: Container(
        width: screenWidth(context),
        height: screenHeight(context),
        decoration: BoxDecoration(color: yellow),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 100,
                  width: screenWidth(context),
                  child: FadeTransition(
                      opacity: _animation,
                      child: Text(
                        'VOLUNTEER IS A WORK OF HEART',
                        style: TextStyle(
                            fontFamily: 'Fredoka One',
                            color: black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center,
                      )),
                )),
            Container(
              alignment: Alignment.center,
              child: FadeTransition(
                opacity: _animation,
                child: Image.asset(
                  'assets/logo.png',
                  height: 355.h,
                  width: 390.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
