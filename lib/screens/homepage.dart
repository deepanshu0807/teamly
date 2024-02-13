import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_team/screens/create_meet.dart';
import 'package:my_team/screens/join_meet.dart';
import 'package:my_team/screens/profile.dart';
import 'package:my_team/utils/utility.dart';
import 'package:my_team/utils/variables.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String username = '';
  bool dataAvailable = false;

  double menuH = 100.h;
  double menuW = 100.h;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final userDoc =
        await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      username = userDoc.data()!['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Container(
        height: screenHeight(context),
        width: screenWidth(context),
        //padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: -30,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: 0.4,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(200),
                      topRight: Radius.circular(200)),
                  child: Image.asset(
                    "images/meet.png",
                    width: screenWidth(context),
                  ),
                ),
              ),
            ),
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi,",
                            style: text22.copyWith(
                              fontSize: 26.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth(context) / 1.8,
                            child: Text(
                              username.isEmpty ? "..." : username,
                              overflow: TextOverflow.ellipsis,
                              style: text22.copyWith(
                                fontSize: 35.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 60.h,
                        width: 60.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              blurRadius: 30.0,
                              offset: Offset(0, 10),
                            ),
                          ],
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
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                verticalSpaceMedium20,
                Center(
                  child: Container(
                    height: 5.h,
                    width: screenWidth(context) / 1.3,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(40)),
                  ),
                ),
                verticalSpaceMedium30,
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        blurRadius: 30.0,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size(double.infinity, 0),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Colors.white,
                        surfaceTintColor: AppColors.primaryColor),
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => JoinMeet(
                                    username: username,
                                  )));
                    },
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
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            verticalSpaceMedium20,
                            SizedBox(
                              width: screenWidth(context) / 2.8,
                              child: Text(
                                "Join meeting instantly with Code",
                                style: text18.copyWith(color: Colors.grey[700]),
                              ),
                            ),
                          ],
                        ),
                        Hero(
                          tag: "connect",
                          child: Image.asset(
                            "images/connect.png",
                            width: screenWidth(context) / 3,
                          ),
                        ),
                      ],
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
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        blurRadius: 30.0,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size(double.infinity, 0),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Colors.white,
                        surfaceTintColor: AppColors.primaryColor),
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => CreateMeet(
                                    username: username,
                                  )));
                    },
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
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            verticalSpaceMedium20,
                            SizedBox(
                              width: screenWidth(context) / 2.8,
                              child: Text(
                                "Create a meeting code and invite others",
                                style: text18.copyWith(color: Colors.grey[700]),
                              ),
                            ),
                          ],
                        ),
                        Hero(
                          tag: "meetweb",
                          child: Image.asset(
                            "images/meetweb.png",
                            width: screenWidth(context) / 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpaceMedium30,
              ],
            ),
            Positioned(
              bottom: 5,
              child: Center(
                child: Text(
                  "v1.0",
                  style: text16.copyWith(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
