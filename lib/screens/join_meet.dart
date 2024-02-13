import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_utility/constant_utility.dart';
// import 'package:meet_hour/meet_hour.dart';
// import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:my_team/utils/utility.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class JoinMeet extends StatefulWidget {
  final String username;

  const JoinMeet({required this.username});
  @override
  _JoinMeetState createState() => _JoinMeetState();
}

class _JoinMeetState extends State<JoinMeet> {
  final _controller1 = ValueNotifier<bool>(false);
  final _controller2 = ValueNotifier<bool>(false);
  TextEditingController controller = TextEditingController(text: "");
  TextEditingController nameC = TextEditingController();
  bool hasError = false;
  // String errorMessage;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  joinMeet() async {
    // try {
    //   Map<FeatureFlagEnum, bool> featureFlags = {
    //     FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
    //     FeatureFlagEnum.ADD_PEOPLE_ENABLED: false,
    //     FeatureFlagEnum.INVITE_ENABLED: false
    //   };
    //   if (Platform.isAndroid) {
    //     featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
    //   } else if (Platform.isIOS) {
    //     featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
    //   }

    //   var options = MeetHourMeetingOptions(room: controller.text)
    //     ..userDisplayName = nameC.text.isEmpty ? widget.username : nameC.text
    //     ..audioMuted = !_controller2.value
    //     ..videoMuted = !_controller1.value
    //     ..featureFlags.addAll(featureFlags);

    //   await MeetHour.joinMeeting(options);
    // } catch (e) {
    //   print("Error: $e");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Container(
        height: screenHeight(context),
        width: screenWidth(context),
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
        decoration: BoxDecoration(
          // color: AppColors.backgroundColor,
          gradient: LinearGradient(
            colors: [
              AppColors.secondaryColor,
              // Colors.white12,
              AppColors.primaryColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
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
                    width: 30.w,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            verticalSpaceMedium20,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Join",
                  style: text30.copyWith(
                      letterSpacing: -2,
                      fontSize: 45.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Text(
                  "Meeting",
                  style: text60Italiana.copyWith(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70),
                ),
              ],
            ),
            // SizedBox(
            //   height: screenHeight(context) / 4,
            //   width: double.infinity,
            //   child: Stack(
            //     children: [
            //       Positioned(
            //         right: 0,
            //         bottom: 0,
            //         top: 0,
            //         child: Container(
            //           padding: EdgeInsets.all(10),
            //           height: screenHeight(context) / 6,
            //           width: screenWidth(context) / 1.7,
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(25),
            //             boxShadow: [
            //               BoxShadow(
            //                 color: AppColors.primaryColor.withOpacity(0.01),
            //                 blurRadius: 30.0,
            //                 offset: Offset(0, 10),
            //               ),
            //             ],
            //           ),
            //           alignment: Alignment.center,
            //           child: ClipRRect(
            //             borderRadius: BorderRadius.circular(25),
            //             child: Hero(
            //               tag: "connect",
            //               child: Image.asset(
            //                 "images/connect.png",
            //                 width: screenWidth(context),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text(
            //             "Join",
            //             style: text22.copyWith(
            //                 fontSize: 50.sp,
            //                 fontWeight: FontWeight.w600,
            //                 color: AppColors.primaryColor),
            //           ),
            //           Text(
            //             "Meeting",
            //             style: text22.copyWith(
            //                 fontSize: 45.sp,
            //                 fontWeight: FontWeight.w400,
            //                 color: Colors.grey),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            verticalSpaceLarge,
            Text(
              "Enter meeting code:",
              style: text22.copyWith(
                color: Colors.white60,
              ),
            ),
            verticalSpaceMedium15,
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: PinCodeTextField(
                autofocus: false,
                controller: controller,
                hideCharacter: false,
                highlight: false,
                highlightColor: AppColors.secondaryColor,
                defaultBorderColor: Colors.black,
                hasTextBorderColor: AppColors.secondaryColor,
                highlightPinBoxColor: AppColors.secondaryColor,
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
                pinBoxHeight: 60.h,
                hasUnderline: false,
                wrapAlignment: WrapAlignment.spaceBetween,
                pinBoxDecoration:
                    ProvidedPinBoxDecoration.defaultPinBoxDecoration,
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
            verticalSpaceLarge,
            Text(
              "Enter your name",
              style: text22.copyWith(color: Colors.white60),
            ),
            verticalSpaceSmall,

            TextField(
              keyboardType: TextInputType.name,
              style: text22.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                decorationStyle: TextDecorationStyle.wavy,
              ),
              cursorColor: Colors.white,
              cursorWidth: 2,
              decoration: InputDecoration(
                fillColor: AppColors.secondaryColor,
                enabledBorder: OutlineInputBorder(
                  borderRadius: borderR10,
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: borderR10,
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                hintText: "Leave if you want username",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                hintStyle: text16.copyWith(
                  color: Colors.white60,
                  fontWeight: FontWeight.normal,
                  decorationStyle: TextDecorationStyle.wavy,
                ),
              ),
              controller: nameC,
            ),

            // Container(
            //   height: 55,
            //   child: TextFormField(
            //     controller: nameC,
            //     cursorColor: AppColors.getPrimaryColor(),
            //     style: text22.copyWith(
            //       color: AppColors.getPrimaryColor(),
            //       fontSize: 28.sp,
            //     ),
            //     decoration: InputDecoration(
            //         hintText: "Leave if you want username",
            //         hintStyle: text20.copyWith(
            //           color: Colors.grey,
            //         ),
            //         fillColor: Colors.white,
            //         filled: true,
            //         border: OutlineInputBorder(
            //           borderSide: BorderSide.none,
            //           borderRadius: BorderRadius.circular(5),
            //         )),
            //     onChanged: (value) {},
            //   ),
            // ),
            verticalSpaceMedium30,
            Text(
              "Other settings",
              style: text22.copyWith(color: Colors.white60),
            ),
            verticalSpaceMedium15,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Camera",
                  style: text22.copyWith(color: Colors.white),
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
                  activeColor: AppColors.secondaryColor,
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
                  style: text22.copyWith(color: Colors.white),
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
            verticalSpaceLarge,
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  minimumSize: Size(screenWidth(context) / 1.8, 0),
                  shape: shape10,
                  padding: EdgeInsets.all(10.h),
                ),
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
