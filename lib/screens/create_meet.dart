import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meet_hour/meet_hour.dart';
import 'package:meet_hour/meet_hour_platform_interface.dart';
// import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:my_team/utils/utility.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:clipboard/clipboard.dart';

class CreateMeet extends StatefulWidget {
  final String username;

  const CreateMeet({Key key, @required this.username}) : super(key: key);
  @override
  _CreateMeetState createState() => _CreateMeetState();
}

class _CreateMeetState extends State<CreateMeet> {
  String code = '';
  double opac = 0;
  bool pressed = false;
  String appLink =
      'https://play.google.com/store/apps/details?id=com.meetings.teamly';

  double hei = 75;

  joinMeet() async {
    try {
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
        FeatureFlagEnum.ADD_PEOPLE_ENABLED: false,
        FeatureFlagEnum.INVITE_ENABLED: false
      };
      if (Platform.isAndroid) {
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      var options = MeetHourMeetingOptions(room: code)
        ..userDisplayName = widget.username
        ..audioMuted = true
        ..videoMuted = true
        ..featureFlags.addAll(featureFlags);

      await MeetHour.joinMeeting(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: screenHeight(context),
        width: screenWidth(context),
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          // gradient: LinearGradient(
          //   colors: [
          //     AppColors.backgroundColor,
          //     // Colors.white12,
          //     Colors.white,
          //   ],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
        ),
        child: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        "images/back.png",
                        width: 50.w,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight(context) / 4,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        bottom: 0,
                        top: 0,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: screenHeight(context) / 6,
                          width: screenWidth(context) / 1.7,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.01),
                                blurRadius: 30.0,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Hero(
                              tag: "meetweb",
                              child: Image.asset(
                                "images/meetweb.png",
                                width: screenWidth(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Create",
                            style: text22.copyWith(
                                letterSpacing: -2,
                                fontSize: 45.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                          Text(
                            "Meeting",
                            style: text22.copyWith(
                                fontSize: 45.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                verticalSpaceMassive,
                AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  curve: Curves.ease,
                  width: double.infinity,
                  height: hei,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Code:",
                            style: text30.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            code.isEmpty ? "_ _ _ _ _ _" : code,
                            style: text40.copyWith(
                              letterSpacing: code.isEmpty ? 2 : 10,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      if (pressed) verticalSpaceMedium20,
                      if (pressed)
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 1000),
                          opacity: opac,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FlatButton(
                                  minWidth: 50.w,
                                  onPressed: () {
                                    FlutterClipboard.copy(code).then((value) {
                                      var snackbar = SnackBar(
                                          duration: Duration(seconds: 2),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.h, horizontal: 10.w),
                                          backgroundColor: Colors.black,
                                          content: Row(
                                            children: [
                                              Icon(
                                                Icons.check,
                                                color: Colors.white,
                                              ),
                                              horizontalSpaceMedium15,
                                              Text(
                                                "Copied to clipboard",
                                                style: text18.copyWith(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackbar);
                                    });
                                  },
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.copy,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      horizontalSpaceMedium15,
                                      Text(
                                        "Copy ",
                                        style: text18.copyWith(
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                FlatButton(
                                  minWidth: 50.w,
                                  onPressed: () async {
                                    await Share.share(
                                        'Hey, join me on Teamly meeting with this code - $code  \n\n Download Teamly: $appLink');
                                  },
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.share,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      horizontalSpaceMedium15,
                                      Text(
                                        "Share ",
                                        style: text18.copyWith(
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                verticalSpaceMedium30,
                Center(
                  child: FlatButton(
                    minWidth: screenWidth(context) / 1.5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    padding: EdgeInsets.all(10.h),
                    color: AppColors.primaryColor,
                    onPressed: () async {
                      if (!pressed) {
                        setState(() {
                          code = Uuid().v1().substring(0, 6);
                          pressed = true;
                          opac = 1;
                          hei = 150;
                        });
                      } else {
                        await joinMeet();
                      }
                    },
                    child: Text(
                      pressed ? "Join Now" : "Create Code",
                      style: text22.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (pressed) verticalSpaceMedium15,
                if (pressed)
                  Text(
                    "By default, your audio and video will be muted but you can turn them ON anytime.",
                    textAlign: TextAlign.center,
                    style: text14.copyWith(color: Colors.grey[600]),
                  )
              ],
            ),
            Positioned(
              bottom: 20.h,
              left: 10.w,
              right: 10.w,
              child: Container(
                padding: EdgeInsets.all(10.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      blurRadius: 30.0,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.info_rounded,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        "Create a code and share it for others to join your meeting.",
                        style: text18.copyWith(color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
