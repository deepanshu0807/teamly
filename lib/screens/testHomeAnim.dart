import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_utility/constant_utility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_team/screens/profile.dart';
import 'package:my_team/utils/utility.dart';

import '../utils/variables.dart';
import 'create_meet.dart';
import 'join_meet.dart';

class TestHomeAnimated extends StatefulWidget {
  const TestHomeAnimated({Key? key}) : super(key: key);

  @override
  State<TestHomeAnimated> createState() => _TestHomeAnimatedState();
}

class _TestHomeAnimatedState extends State<TestHomeAnimated>
    with TickerProviderStateMixin {
  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;

  String username = '';
  bool dataAvailable = false;

  double menuH = 100.h;
  double menuW = 100.h;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    getData();

    controller1 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });
    animation2 = Tween<double>(begin: .02, end: .04).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    controller2 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    animation3 = Tween<double>(begin: .41, end: .38).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });
    animation4 = Tween<double>(begin: 170, end: 190).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    Timer(Duration(milliseconds: 2500), () {
      controller1.forward();
    });

    controller2.forward();
  }

  getData() async {
    final userDoc =
        await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      username = userDoc.data()!['username'];
    });
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Container(
        height: screenHeight(context),
        width: screenWidth(context),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: screenHeight(context) * (animation2.value + .58),
              left: screenWidth(context) * .21,
              child: CustomPaint(
                painter: MyPainter(50),
              ),
            ),
            Positioned(
              top: screenHeight(context) * .98,
              left: screenWidth(context) * .1,
              child: CustomPaint(
                painter: MyPainter(animation4.value - 30),
              ),
            ),
            Positioned(
              top: screenHeight(context) * .5,
              left: screenWidth(context) * (animation2.value + .8),
              child: CustomPaint(
                painter: MyPainter(30),
              ),
            ),
            Positioned(
              top: screenHeight(context) * animation3.value,
              left: screenWidth(context) * (animation1.value + .1),
              child: CustomPaint(
                painter: MyPainter(60),
              ),
            ),
            Positioned(
              top: screenHeight(context) * .1,
              left: screenWidth(context) * .8,
              child: CustomPaint(
                painter: MyPainter(animation4.value),
              ),
            ),
            // Positioned(
            //   bottom: -30,
            //   left: 0,
            //   right: 0,
            //   child: Opacity(
            //     opacity: 0.4,
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(200),
            //           topRight: Radius.circular(200)),
            //       child: Image.asset(
            //         "images/meet.png",
            //         width: screenWidth(context),
            //       ),
            //     ),
            //   ),
            // ),
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hey,",
                            style: text60Pacifico.copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white60,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth(context) / 1.8,
                            child: Text(
                              username.isEmpty ? "..." : username,
                              overflow: TextOverflow.ellipsis,
                              style: text60Italiana.copyWith(
                                fontSize: 35.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 60.h,
                        width: 60.h,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (_, __, ___) => ProfileScreen()),
                            );
                          },
                          child: Hero(
                            tag: 'icon',
                            child: Icon(
                              Icons.account_circle_sharp,
                              size: 50.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                verticalSpaceMedium20,
                // Center(
                //   child: Container(
                //     height: 5.h,
                //     width: screenWidth(context) / 1.3,
                //     decoration: BoxDecoration(
                //         color: Colors.grey,
                //         borderRadius: BorderRadius.circular(40)),
                //   ),
                // ),
                verticalSpaceMedium30,
                Padding(
                  padding: padding15,
                  child: ClipRRect(
                    borderRadius: borderR10,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.white24,
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => JoinMeet(
                                        username: username,
                                      )));
                        },
                        child: Container(
                          padding: padding20,
                          width: screenWidth(context) / 2,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: borderR10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Join",
                                    style: text30.copyWith(
                                      color: Colors.white,
                                      fontSize: 30.sp,
                                    ),
                                  ),
                                  verticalSpaceMedium20,
                                  SizedBox(
                                    width: screenWidth(context) / 2.8,
                                    child: Text(
                                      "Join meeting instantly with Code",
                                      style: text18.copyWith(
                                          color: Colors.white70),
                                    ),
                                  ),
                                ],
                              ),
                              // Hero(
                              //   tag: "connect",
                              //   child: Image.asset(
                              //     "images/connect.png",
                              //     width: screenWidth(context) / 3,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // verticalSpaceMedium30,
                // Center(
                //   child: Text(
                //     "OR",
                //     style: text30.copyWith(color: Colors.grey),
                //   ),
                // ),
                // verticalSpaceMedium30,
                Padding(
                  padding: padding15,
                  child: ClipRRect(
                    borderRadius: borderR10,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.white24,
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => CreateMeet(
                                        username: username,
                                      )));
                        },
                        child: Container(
                          padding: padding20,
                          width: screenWidth(context) / 2,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: borderR10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Create",
                                    style: text30.copyWith(
                                      color: Colors.white,
                                      fontSize: 30.sp,
                                    ),
                                  ),
                                  verticalSpaceMedium20,
                                  SizedBox(
                                    width: screenWidth(context) / 2.4,
                                    child: Text(
                                      "Create a meeting code and invite others",
                                      style: text18.copyWith(
                                          color: Colors.white70),
                                    ),
                                  ),
                                ],
                              ),
                              //       Hero(
                              //   tag: "meetweb",
                              //   child: Image.asset(
                              //     "images/meetweb.png",
                              //     width: screenWidth(context) / 3,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.all(20),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20),
                //     boxShadow: [
                //       BoxShadow(
                //         color: AppColors.primaryColor.withOpacity(0.1),
                //         blurRadius: 30.0,
                //         offset: Offset(0, 10),
                //       ),
                //     ],
                //   ),
                //   child: TextButton(
                //     style: TextButton.styleFrom(
                //         minimumSize: Size(double.infinity, 0),
                //         padding:
                //             EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(20)),
                //         backgroundColor: Colors.white,
                //         surfaceTintColor: AppColors.primaryColor),
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           CupertinoPageRoute(
                //               builder: (context) => CreateMeet(
                //                     username: username,
                //                   )));
                //     },
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Text(
                //               "Create",
                //               style: text30.copyWith(
                //                   color: AppColors.primaryColor,
                //                   fontWeight: FontWeight.bold),
                //             ),
                //             verticalSpaceMedium20,
                //             SizedBox(
                //               width: screenWidth(context) / 2.8,
                //               child: Text(
                //                 "Create a meeting code and invite others",
                //                 style: text18.copyWith(color: Colors.grey[700]),
                //               ),
                //             ),
                //           ],
                //         ),
                //         Hero(
                //           tag: "meetweb",
                //           child: Image.asset(
                //             "images/meetweb.png",
                //             width: screenWidth(context) / 3,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                verticalSpaceMedium30,
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget blurredInputField(
    IconData icon,
    String hintText,
    bool isPassword,
    bool isEmail,
  ) {
    return Padding(
      padding: padding15.copyWith(bottom: 5.sp),
      child: ClipRRect(
        borderRadius: borderR10,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaY: 20,
            sigmaX: 20,
          ),
          child: Container(
            width: screenWidth(context) / 1.2,
            height: 55.sp,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: borderR10,
            ),
            child: TextField(
              style: text16.copyWith(
                color: Colors.white,
              ),
              cursorColor: Colors.white,
              obscureText: isPassword,
              keyboardType:
                  isEmail ? TextInputType.emailAddress : TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: Colors.white,
                ),
                border: InputBorder.none,
                hintMaxLines: 1,
                hintText: hintText,
                hintStyle: text14.copyWith(
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget blurredButton(
    String string,
    double width,
    VoidCallback voidCallback,
  ) {
    return ClipRRect(
      borderRadius: borderR10,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.white10,
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => JoinMeet(
                          username: username,
                        )));
          },
          child: Container(
            height: 60.sp,
            width: screenWidth(context) / 2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: borderR10,
            ),
            child: Text(
              string,
              style: text60Italiana.copyWith(
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double radius;

  MyPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(colors: [
        AppColors.primaryColor,
        Color.fromARGB(255, 160, 109, 170)
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)
          .createShader(Rect.fromCircle(
        center: Offset(0, 0),
        radius: radius,
      ));

    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}



// Positioned(
//               top: 20.sp,
//               child: Container(
//                 padding: padding15,
//                 margin: padding30,
//                 height: screenHeight(context),
//                 child: Column(
//                   children: [
//                     Text(
//                       'Teamly',
//                       style: text60Italiana.copyWith(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 45.sp,
//                       ),
//                     ),
//                     verticalSpaceMedium15,
//                     Text(
//                       'Create a new account',
//                       style: text60Italiana.copyWith(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20.sp),
//                     ),
//                     verticalSpaceMassive,
//                     blurredInputField(
//                       Icons.account_circle_outlined,
//                       'User name...',
//                       false,
//                       false,
//                     ),
//                     blurredInputField(
//                       Icons.email_outlined,
//                       'Email...',
//                       false,
//                       true,
//                     ),
//                     blurredInputField(
//                       Icons.lock_outline,
//                       'Password...',
//                       true,
//                       false,
//                     ),
//                     verticalSpaceMassive,
//                     verticalSpaceLarge,
//                     // SizedBox(
//                     //   height: 70.h,
//                     //   width: 70.h,
//                     //   child: CircularProgressIndicator(
//                     //     strokeWidth: 2,
//                     //     color: Colors.white,
//                     //     backgroundColor: Colors.black,
//                     //   ),
//                     // ),
//                     blurredButton(
//                       'Signup',
//                       2,
//                       () {
//                         setState(() {
//                           isLoading = true;
//                         });
//                         HapticFeedback.lightImpact();
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),