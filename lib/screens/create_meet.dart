import 'package:dart_jwt_token/dart_jwt_token.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_utility/constant_utility.dart';
import 'package:my_team/screens/call_screen_get_stream.dart';
import 'package:my_team/utils/utility.dart';
import 'package:my_team/utils/variables.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:clipboard/clipboard.dart';

class CreateMeet extends StatefulWidget {
  final String username;

  const CreateMeet({required this.username});
  @override
  _CreateMeetState createState() => _CreateMeetState();
}

class _CreateMeetState extends State<CreateMeet> {
  String code = '';
  double opac = 0;
  bool pressed = false;
  double hei = 80;

  @override
  void initState() {
    setState(() {
      code = Uuid().v1().substring(0, 6);
      opac = 1;
      hei = 150;
    });
    super.initState();
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
        name: widget.username,
      ),
      userToken: createToken(
          payload: {"user_id": auth.FirebaseAuth.instance.currentUser!.uid},
          headers: {'alg': 'HS256', 'typ': 'JWT'},
          key: SecretKey(getStreamSecret)),
    );
  }

  void join() async {
    try {
      setState(() {
        pressed = true;
      });

      StreamVideo.reset();
      createStreamClientAndConfigure();

      var call = StreamVideo.instance.makeCall(
        type: 'default',
        id: code,
      );

      await call.getOrCreate();

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
      debugPrint('Error joining or creating call: $e');
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
          // color: AppColors.secondaryColor,
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
                      "Create",
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
                Container(
                  padding: padding15,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: borderR10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.info_rounded,
                          color: Colors.white54,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          "Create a code and invite your friends or colleagues to your meeting",
                          style: text14.copyWith(color: Colors.white54),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpaceLarge,
                verticalSpaceMedium30,
                AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  curve: Curves.ease,
                  width: double.infinity,
                  height: hei,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: borderR10,
                  ),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Code:",
                            style: text22.copyWith(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            code.isEmpty ? "_ _ _ _ _ _" : code,
                            style: text40.copyWith(
                              letterSpacing: code.isEmpty ? 2 : 16,
                              color: AppColors.backgroundColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceMedium20,
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 1000),
                        opacity: opac,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: padding10,
                                  backgroundColor: Colors.black,
                                  minimumSize: Size(50.w, 40),
                                  shape: shape10,
                                ),
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
                                      style:
                                          text18.copyWith(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: padding10,
                                  backgroundColor: Colors.black,
                                  minimumSize: Size(50.w, 40),
                                  shape: shape10,
                                ),
                                onPressed: () async {
                                  await Share.share(
                                      'Hey, join me on Teamly meeting with this code - $code  \n\n Download Teamly: $appLink');
                                },
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
                                      style:
                                          text18.copyWith(color: Colors.white),
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
                      join();
                    },
                    child: pressed
                        ? CircularProgressIndicator(
                            strokeWidth: 3,
                            color: AppColors.primaryColor,
                            backgroundColor: Colors.grey[300],
                          )
                        : Text(
                            "Join Now",
                            style: text22.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                verticalSpaceMedium25,
                Text(
                  "By default, your audio and video will be muted but you can turn them ON anytime.",
                  textAlign: TextAlign.center,
                  style: text14.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
