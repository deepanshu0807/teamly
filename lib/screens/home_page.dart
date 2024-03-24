import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_utility/constant_utility.dart';
import 'package:my_team/screens/profile.dart';
import 'package:my_team/utils/utility.dart';

import '../utils/variables.dart';
import 'create_meet.dart';
import 'join_meet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
                          var snackbar = SnackBar(
                              duration: Duration(seconds: 2),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 10.w),
                              backgroundColor: Colors.black,
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.emoji_emotions_sharp,
                                    color: Colors.white,
                                  ),
                                  horizontalSpaceMedium15,
                                  Text(
                                    "Ruka nahi jaata ??",
                                    style: text18.copyWith(color: Colors.white),
                                  ),
                                ],
                              ));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        },
                        child: Container(
                          padding: padding15,
                          width: screenWidth(context) / 2,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white12,
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
                                  Row(
                                    children: [
                                      Text(
                                        "Ask anything",
                                        style: text30.copyWith(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                      horizontalSpaceMedium15,
                                      Container(
                                        padding: padding5.copyWith(
                                            left: 6, right: 6),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColors.secondaryColor,
                                          borderRadius: borderR5,
                                        ),
                                        child: Text(
                                          "Upcoming",
                                          style: text30.copyWith(
                                            color: Colors.white54,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  verticalSpaceSmall,
                                  SizedBox(
                                    width: screenWidth(context) / 1.4,
                                    child: Text(
                                      "AI powered quick answers",
                                      style: text16.copyWith(
                                          color: Colors.white70),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
