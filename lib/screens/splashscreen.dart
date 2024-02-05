import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_utility/constant_utility.dart';
import 'package:my_team/auth/navigator.dart';
import 'package:my_team/screens/testHomeAnim.dart';
import 'package:my_team/utils/utility.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() {
    Timer(Duration(seconds: 2), changeScreen);
  }

  changeScreen() async {
    await Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => AppNavigator()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 150,
              left: 0,
              child: CustomPaint(
                painter: MyPainter(250),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 50,
              child: CustomPaint(
                painter: MyPainter(250),
              ),
            ),
            Column(
              mainAxisAlignment: mainC,
              children: [
                // Center(
                //   child: Hero(
                //     tag: "logo",
                //     child: Image.asset(
                //       "images/logo.png",
                //       width: screenWidth(context) / 2,
                //       //height: 600.h,
                //     ),
                //   ),
                // ),
                // verticalSpaceLarge,
                Center(
                  child: Text(
                    'Teamly',
                    style: text60Italiana.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    'Meetings on-the-Go',
                    textAlign: TextAlign.center,
                    style: text60Pacifico.copyWith(
                      color: Colors.white.withOpacity(.5),
                      fontSize: 30.sp,
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: 70.h,
            //   width: 70.h,
            //   child: CircularProgressIndicator(
            //     strokeWidth: 2,
            //     color: AppColors.primaryColor,
            //     backgroundColor: Colors.white,
            //   ),
            // ),
            // Column(
            //   children: [
            //     Text(
            //       "Powered by",
            //       textAlign: TextAlign.center,
            //       style: text20.copyWith(
            //         color: Colors.grey,
            //       ),
            //     ),
            //     Text(
            //       "Jitsi",
            //       textAlign: TextAlign.center,
            //       style: text20.copyWith(
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
