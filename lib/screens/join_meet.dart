import 'package:dart_jwt_token/dart_jwt_token.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_utility/constant_utility.dart';
import 'package:my_team/screens/call_screen_get_stream.dart';
import 'package:my_team/utils/utility.dart';
import 'package:my_team/utils/variables.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

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
  bool pressed = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  createStreamClientAndConfigure() {
    String createToken(
        {required Map payload,
        required Map<String, dynamic> headers,
        required SecretKey key}) {
      String token = "";
      final jwt = JWT(payload, header: headers);
      token = jwt.sign(key);
      return token;
    }

    final client = StreamVideo(
      getStreamKey,
      user: User.regular(
        userId: auth.FirebaseAuth.instance.currentUser!.uid,
        role: 'admin',
        name: nameC.text.isEmpty ? widget.username : nameC.text,
      ),
      userToken: createToken(
          payload: {"user_id": auth.FirebaseAuth.instance.currentUser!.uid},
          headers: {'alg': 'HS256', 'typ': 'JWT'},
          key: SecretKey(getStreamSecret)),
    );
  }

  joinMeet() async {
    try {
      setState(() {
        pressed = true;
      });

      StreamVideo.reset();

      createStreamClientAndConfigure();

      var call = StreamVideo.instance.makeCall(
        type: 'default',
        id: controller.text,
      );

      await call.getOrCreate().then((value) async {
        await call.setMicrophoneEnabled(enabled: _controller2.value);
        await call.setCameraEnabled(enabled: _controller1.value);
      });
      setState(() {
        pressed = false;
      });
      await Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: CallScreenGetStream(
              call: call,
            ),
          );
        },
      ));
    } catch (e) {
      setState(() {
        pressed = false;
      });
      debugPrint('Error joining call: $e');
      debugPrint(e.toString());
    }
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
                    color: Colors.red,
                  ),
                  activeColor: Colors.green,
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
                    color: Colors.red,
                  ),
                  activeColor: Colors.green,
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
                  backgroundColor:
                      pressed ? Colors.white : AppColors.secondaryColor,
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
                child: pressed
                    ? CircularProgressIndicator(
                        strokeWidth: 3,
                        color: AppColors.primaryColor,
                        backgroundColor: Colors.grey[300],
                      )
                    : Text(
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
