import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_team/screens/homepage.dart';
import 'package:my_team/screens/signup.dart';
import 'package:my_team/services/auth-exception-handler.dart';
import 'package:my_team/services/auth-result-status.dart';
import 'package:my_team/services/firebase-auth-helper.dart';
import 'package:my_team/utils/space.dart';
import 'package:my_team/utils/utility.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  _login() async {
    final status = await FirebaseAuthHelper()
        .login(email: emailC.text, pass: passwordC.text);
    if (status == AuthResultStatus.successful) {
      _btnController.success();
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, CupertinoPageRoute(builder: (context) => HomePage()));
      });
    } else {
      _btnController.error();
      Timer(Duration(seconds: 1), () {
        _btnController.reset();
      });

      final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
      var snackbar = SnackBar(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          backgroundColor: Colors.red,
          content: Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.white,
              ),
              horizontalSpaceMedium15,
              Text(errorMsg, style: text18.copyWith(color: Colors.white),),
            ],
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        height: screenHeight(context),
        width: screenWidth(context),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: -100.h,
              // left: 0,
              // right: 0,
              child: Opacity(
                opacity: 0.1,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(200),
                      topRight: Radius.circular(200)),
                  child: Hero(
                    tag: "globe",
                    child: Image.asset(
                      "images/globe.png",
                      height: screenHeight(context) / 1.4,
                      // width: screenWidth(context),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Login",
                        style: text40.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Hero(
                      //   tag: "logo",
                      //   child: Image.asset(
                      //     "images/logo.png",
                      //     height: 40.h,
                      //   ),
                      // ),
                    ],
                  ),
                  verticalSpaceMedium20,
                  Center(
                    child: Container(
                      height: 8.h,
                      width: screenWidth(context) / 1.3,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(100)),
                    ),
                  ),
                  verticalSpaceMedium30,
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: screenWidth(context) / 1.7,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            blurRadius: 30.0,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          "images/signin.png",
                          width: screenWidth(context),
                        ),
                      ),
                    ),
                  ),
                  verticalSpaceLarge,
                  Text(
                    "Email address",
                    style: text22.copyWith(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade800),
                  ),
                  verticalSpaceSmall,
                  Container(
                    //  height: 60,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          blurRadius: 30.0,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      controller: emailC,
                      cursorColor: AppColors.getPrimaryColor(),
                      style: text22.copyWith(
                        color: AppColors.getPrimaryColor(),
                        fontSize: 22,
                      ),
                      decoration: InputDecoration(
                          hintText: "abc@example.com",
                          hintStyle: text20.copyWith(
                            color: Colors.grey,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onChanged: (value) {},
                    ),
                  ),
                  verticalSpaceMedium15,
                  Text(
                    "Password",
                    style: text22.copyWith(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade800),
                  ),
                  verticalSpaceSmall,
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          blurRadius: 30.0,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      controller: passwordC,
                      obscureText: true,
                      cursorColor: AppColors.getPrimaryColor(),
                      style: text22.copyWith(
                        color: AppColors.getPrimaryColor(),
                        fontSize: 28.sp,
                      ),
                      decoration: InputDecoration(
                          hintText: "******",
                          hintStyle: text20.copyWith(
                            color: Colors.grey,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onChanged: (value) {},
                    ),
                  ),
                  verticalSpaceLarge,
                  Center(
                    child: RoundedLoadingButton(
                      width: screenWidth(context) / 1.7,
                      borderRadius: 25,
                      successColor: Colors.green,
                      errorColor: Colors.red,
                      color: AppColors.primaryColor,
                      child: Text(
                        "Login",
                        style: text22.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      controller: _btnController,
                      onPressed: () => _login(),
                    ),
                  ),
                  verticalSpaceMedium15,
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text(
                        "Don\'t have an account? Sign Up",
                        style: text20.copyWith(color: Colors.grey[800]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// try {
//   FirebaseAuth.instance
//       .signInWithEmailAndPassword(
//           email: emailC.text, password: passwordC.text)
//       .then((user) {
//     _btnController.success();
//     Timer(Duration(seconds: 2), () {
//       Navigator.pushReplacement(
//           context,
//           CupertinoPageRoute(
//               builder: (context) => HomePage()));
//     });

//   });
// } on PlatformException catch (e) {
//   _btnController.error();
//   _btnController.reset();
//   print(e);

//   var snackbar = SnackBar(
//       content: Text(
//     e.toString(),
//     style: text18,
//   ));
//   ScaffoldMessenger.of(context).showSnackBar(snackbar);
// }
