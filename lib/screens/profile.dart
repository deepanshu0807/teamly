import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_utility/constant_utility.dart';
import 'package:my_team/auth/navigator.dart';
import 'package:my_team/utils/utility.dart';
import 'package:my_team/utils/variables.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  //Anims
  double bottomPos = 120.h;
  double hei = 60;
  double wid = 60;
  bool animplaying = false;
  double opac = 1;
  double opac2 = 0;

  TextEditingController nameC = TextEditingController();

  //userdata
  String email = '';
  String name = '';
  bool loading = true;

  @override
  void initState() {
    // _animationController =
    //     AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    getData();
    super.initState();
  }

  getData() async {
    final userDoc =
        await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      name = userDoc.data()!['username'];
      email = userDoc.data()!['email'];
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
          child: Container(
            color: Colors.transparent,
            height: screenHeight(context),
            width: screenWidth(context),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (loading)
                  Positioned(
                    top: 70.h,
                    right: 20.h,
                    child: SizedBox(
                      height: 50.h,
                      width: 50.h,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primaryColor,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    verticalSpaceLarge,
                    Hero(
                      tag: 'icon',
                      child: Icon(
                        Icons.account_circle_sharp,
                        size: 150.sp,
                        color: Colors.white70,
                      ),
                    ),
                    verticalSpaceLarge,
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: borderR10,
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 20.w),
                      child: Column(
                        children: [
                          Text(
                            "You are signed in as",
                            style: text16.copyWith(color: Colors.white),
                          ),
                          verticalSpaceMedium15,
                          Text(
                            name.isEmpty ? "..." : name,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: text20.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpaceMedium30,
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: borderR10,
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 20.w),
                      child: Column(
                        children: [
                          Text(
                            "Your email address is",
                            style: text16.copyWith(color: Colors.white),
                          ),
                          verticalSpaceMedium15,
                          Text(
                            email.isEmpty ? "..." : email,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: text20.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.sp,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  bottom: 20.h,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: Size(screenWidth(context) / 2.5, 40.h),
                      shape: RoundedRectangleBorder(borderRadius: borderR10),
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        loading = true;
                      });

                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppNavigator()));
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout_outlined, color: Colors.white),
                        horizontalSpaceMedium15,
                        Text(
                          "Logout",
                          style: text18.copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 40.h,
                  left: 20.h,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      "images/back.png",
                      width: 50.w,
                      color: AppColors.backgroundColor,
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 100),
                  bottom: bottomPos,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: hei,
                    width: wid,
                    padding: EdgeInsets.fromLTRB(8.w, 0.h, 8.w, 0),
                    decoration: BoxDecoration(
                      borderRadius: borderR10,
                      color: Colors.white,
                    ),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        AnimatedOpacity(
                          opacity: opac2,
                          duration: Duration(milliseconds: 300),
                          child: ListView(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (animplaying)
                                Row(
                                  children: [
                                    horizontalSpaceMedium15,
                                    Icon(
                                      Icons.edit,
                                      size: 30.h,
                                    ),
                                    horizontalSpaceMedium15,
                                    Text(
                                      "Edit ",
                                      style: text22.copyWith(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.secondaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              verticalSpaceMedium20,
                              if (animplaying)
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5.h,
                                    horizontal: 15.w,
                                  ),
                                  child: Text(
                                    "We will use this username in meetings if you don't provide a custom name while joining the meeting.",
                                    style: text16.copyWith(
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                ),
                              verticalSpaceMedium15,
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 5.h,
                                  horizontal: 15.w,
                                ),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              verticalSpaceMedium15,
                              if (animplaying)
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 15.w,
                                  ),
                                  height: 55.h,
                                  child: TextFormField(
                                    controller: nameC,
                                    cursorColor: AppColors.getPrimaryColor(),
                                    style: text22.copyWith(
                                      color: AppColors.getPrimaryColor(),
                                      fontSize: 25.sp,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: name,
                                      hintStyle: text20.copyWith(
                                        color: Colors.grey,
                                      ),
                                      fillColor: AppColors.backgroundColor,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    onChanged: (value) {},
                                  ),
                                ),
                              verticalSpaceMedium15,
                              if (animplaying)
                                Center(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: borderR10,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10.h,
                                        horizontal: 30.w,
                                      ),
                                      backgroundColor: AppColors.secondaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        loading = true;
                                      });
                                      userCollection
                                          .doc(FirebaseAuth
                                              .instance.currentUser?.uid)
                                          .update({
                                        'username': nameC.text
                                      }).then((value) {
                                        setState(() {
                                          loading = false;
                                          name = nameC.text;
                                          //anims
                                          animplaying = !animplaying;
                                          opac = animplaying ? 0 : 1;
                                          opac2 = animplaying ? 1 : 0;
                                          bottomPos =
                                              animplaying ? 20.h : 120.h;
                                          hei = animplaying ? 400.h : 60;
                                          wid = animplaying
                                              ? screenWidth(context) / 1.2
                                              : 60;
                                        });
                                      });
                                    },
                                    child: Text(
                                      "Save",
                                      style: text20.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                        if (animplaying)
                          Positioned(
                            top: 35.h,
                            right: 20.w,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  animplaying = !animplaying;
                                  opac = animplaying ? 0 : 1;
                                  opac2 = animplaying ? 1 : 0;
                                  bottomPos = animplaying ? 20.h : 120.h;
                                  hei = animplaying ? 400.h : 60;
                                  wid = animplaying
                                      ? screenWidth(context) / 1.2
                                      : 60;
                                });
                              },
                              child: Icon(
                                Icons.close,
                                size: 30.h,
                              ),
                            ),
                          ),
                        Positioned(
                          bottom: 5,
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 200),
                            opacity: opac,
                            child: IconButton(
                              splashColor: AppColors.primaryColor,
                              icon: Icon(
                                Icons.edit,
                                size: 30.h,
                              ),
                              onPressed: () {
                                setState(() {
                                  animplaying = !animplaying;
                                  opac = animplaying ? 0 : 1;
                                  opac2 = animplaying ? 1 : 0;
                                  bottomPos = animplaying ? 20.h : 120.h;
                                  hei = animplaying ? 400.h : 60;
                                  wid = animplaying
                                      ? screenWidth(context) / 1.2
                                      : 60;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
