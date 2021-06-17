import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
        await userCollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      name = userDoc.data()['username'];
      email = userDoc.data()['email'];
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: Container(
            color: Colors.transparent,
            height: screenHeight(context),
            width: screenWidth(context),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (loading)
                  Positioned(
                    top: 40.h,
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
                    verticalSpaceMassive,
                    Hero(
                      tag: 'icon',
                      child: Icon(
                        Icons.account_circle_sharp,
                        size: 150.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    verticalSpaceLarge,
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 30.w),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            blurRadius: 30.0,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 20.w),
                      child: Column(
                        children: [
                          Text(
                            "You are signed in as",
                            style: text20.copyWith(color: Colors.white),
                          ),
                          verticalSpaceMedium15,
                          Text(
                            name.isEmpty ? "..." : name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: text20.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 28.sp),
                          ),
                        ],
                      ),
                    ),
                    verticalSpaceMedium20,
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 30.w),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            blurRadius: 30.0,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 20.w),
                      child: Column(
                        children: [
                          Text(
                            "Your email address is",
                            style: text20.copyWith(color: Colors.white),
                          ),
                          verticalSpaceMedium15,
                          Text(
                            email.isEmpty ? "..." : email,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: text20.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.sp),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  bottom: 20.h,
                  child: FlatButton(
                    height: 60.h,
                    minWidth: screenWidth(context) / 2,
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
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout_outlined, color: Colors.white),
                        horizontalSpaceMedium15,
                        Text(
                          "Logout",
                          style: text22.copyWith(color: Colors.white),
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
                      color: AppColors.primaryColor,
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
                    padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(0.6),
                          blurRadius: 30.0,
                          offset: Offset(0, 10),
                        ),
                      ],
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
                                    Icon(
                                      Icons.edit,
                                      size: 35,
                                    ),
                                    horizontalSpaceMedium15,
                                    Text(
                                      "Edit ",
                                      style: text22.copyWith(
                                          fontSize: 28.sp,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              verticalSpaceMedium20,
                              if (animplaying)
                                Text(
                                  "We will use this username in meetings if you don't provide a custom name while joining the meeting.",
                                  style: text18,
                                ),
                              verticalSpaceMedium15,
                              Divider(
                                color: Colors.grey,
                              ),
                              verticalSpaceMedium30,
                              if (animplaying)
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
                                        hintText: name,
                                        hintStyle: text22.copyWith(
                                          color: Colors.grey,
                                        ),
                                        fillColor: AppColors.backgroundColor,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        )),
                                    onChanged: (value) {},
                                  ),
                                ),
                              verticalSpaceMedium20,
                              if (animplaying)
                                Center(
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    padding: EdgeInsets.all(10.h),
                                    color: AppColors.primaryColor,
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
                              child: Icon(Icons.close),
                            ),
                          ),
                        Positioned(
                          bottom: 5,
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 200),
                            opacity: opac,
                            child: IconButton(
                              splashColor: AppColors.primaryColor,
                              icon: Icon(Icons.edit),
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
