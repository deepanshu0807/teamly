import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:meet_hour/meet_hour.dart';
// import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:my_team/utils/utility.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class JoinMeet extends StatefulWidget {
  final String username;

  const JoinMeet({Key key, @required this.username}) : super(key: key);
  @override
  _JoinMeetState createState() => _JoinMeetState();
}

class _JoinMeetState extends State<JoinMeet> {
  final _controller1 = AdvancedSwitchController();
  final _controller2 = AdvancedSwitchController();
  TextEditingController controller = TextEditingController(text: "");
  TextEditingController nameC = TextEditingController();
  bool hasError = false;
  String errorMessage;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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

      var options = MeetHourMeetingOptions(room: controller.text)
        ..userDisplayName = nameC.text.isEmpty ? widget.username : nameC.text
        ..audioMuted = !_controller2.value
        ..videoMuted = !_controller1.value
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
        child: ListView(
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
                          tag: "connect",
                          child: Image.asset(
                            "images/connect.png",
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
                        "Join",
                        style: text22.copyWith(
                            fontSize: 50.sp,
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
            verticalSpaceMedium25,
            Text(
              "Enter code",
              style: text22.copyWith(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: PinCodeTextField(
                autofocus: false,
                controller: controller,
                hideCharacter: false,
                highlight: false,
                highlightColor: AppColors.primaryColor,
                defaultBorderColor: Colors.grey.shade200,
                hasTextBorderColor: AppColors.primaryColor,
                highlightPinBoxColor: AppColors.primaryColor,
                maxLength: 6,
                hasError: hasError,
                // maskCharacter: "😎",
                onTextChanged: (text) {
                  setState(() {
                    hasError = false;
                  });
                },
                onDone: (text) {},
                pinBoxWidth: 48.w,
                pinBoxHeight: 70.h,
                hasUnderline: false,
                wrapAlignment: WrapAlignment.spaceBetween,
                pinBoxDecoration:
                    ProvidedPinBoxDecoration.roundedPinBoxDecoration,
                pinTextStyle:
                    text22.copyWith(color: Colors.white, fontSize: 25.sp),
                pinTextAnimatedSwitcherTransition:
                    ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
                pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
                //highlightAnimation: true,
                highlightAnimationBeginColor:
                    AppColors.primaryColor.withOpacity(0.6),
                highlightAnimationEndColor: Colors.white12,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            verticalSpaceMedium15,
            Text(
              "Enter name",
              style: text22.copyWith(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            verticalSpaceSmall,
            Container(
              height: 55,
              child: TextFormField(
                controller: nameC,
                cursorColor: AppColors.getPrimaryColor(),
                style: text22.copyWith(
                  color: AppColors.getPrimaryColor(),
                  fontSize: 28.sp,
                ),
                decoration: InputDecoration(
                    hintText: "Leave if you want username",
                    hintStyle: text20.copyWith(
                      color: Colors.grey,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5),
                    )),
                onChanged: (value) {},
              ),
            ),
            verticalSpaceMedium25,
            Text(
              "Other settings",
              style: text22.copyWith(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            verticalSpaceMedium20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Camera",
                  style: text22.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
                AdvancedSwitch(
                  activeChild: Icon(
                    Icons.videocam,
                    color: Colors.white,
                  ),
                  inactiveChild: Icon(
                    Icons.videocam_off,
                    color: Colors.white,
                  ),
                  activeColor: AppColors.primaryColor,
                  inactiveColor: Colors.black,
                  width: 60,
                  controller: _controller1,
                ),
              ],
            ),
            verticalSpaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Audio",
                  style: text22.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
                AdvancedSwitch(
                  activeChild: Icon(
                    Icons.mic,
                    color: Colors.white,
                  ),
                  inactiveChild: Icon(
                    Icons.mic_off,
                    color: Colors.white,
                  ),
                  activeColor: AppColors.primaryColor,
                  inactiveColor: Colors.black,
                  width: 60,
                  controller: _controller2,
                ),
              ],
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
                  if (controller.text.length < 6) {
                    var snackbar = SnackBar(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.h, horizontal: 10.w),
                        backgroundColor: Colors.red,
                        content: Row(
                          children: [
                            Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                            horizontalSpaceMedium15,
                            Text(
                              "Code should be 6 characters long",
                              style: text18.copyWith(color: Colors.white),
                            ),
                          ],
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  } else {
                    await joinMeet();
                  }
                },
                child: Text(
                  "Join Meeting",
                  style: text22.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
