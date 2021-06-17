import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_team/auth/navigator.dart';
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
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Center(
                  child: Hero(
                    tag: "logo",
                    child: Image.asset(
                      "images/logo.png",
                      width: screenWidth(context) / 2,
                      //height: 600.h,
                    ),
                  ),
                ),
                verticalSpaceLarge,
                Center(
                  child: Text(
                    "Teamly",
                    style: text45.copyWith(
                      color: AppColors.getPrimaryColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                verticalSpaceMedium20,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Center(
                    child: Text(
                      "Safe and Secure meetings\non the go",
                      textAlign: TextAlign.center,
                      style: text30.copyWith(fontSize: 25.sp
                          //color: AppColors.getPrimaryColor(),
                          ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 70.h,
              width: 70.h,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primaryColor,
                backgroundColor: Colors.white,
              ),
            ),
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
