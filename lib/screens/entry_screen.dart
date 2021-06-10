import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_team/auth/navigator.dart';
import 'package:my_team/screens/homepage.dart';
import 'package:my_team/screens/signin.dart';
import 'package:my_team/utils/utility.dart';

class EntryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: screenHeight(context),
        width: screenWidth(context),
        padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: "logo",
              child: Image.asset(
                "images/logo.png",
                height: 60.h,
              ),
            ),
            Column(
              children: [
                Hero(
                  tag: "globe",
                  child: Image.asset(
                    "images/globe.png",
                    width: screenWidth(context),
                  ),
                ),
                verticalSpaceMedium25,
                Text(
                  "Join or start meetings",
                  textAlign: TextAlign.center,
                  style: text30.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceSmall,
                Text(
                  "Easy to use, join or start meetings quickly without any delay",
                  textAlign: TextAlign.center,
                  style: text20.copyWith(
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            FlatButton(
              minWidth: screenWidth(context) / 1.5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              padding: EdgeInsets.all(10.h),
              color: AppColors.primaryColor,
              onPressed: () {
                // Navigator.push(context,
                //     CupertinoPageRoute(builder: (context) => AppNavigator()));
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (context) => SignIn()));
              },
              child: Text(
                "Let's Go",
                style: text22.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
