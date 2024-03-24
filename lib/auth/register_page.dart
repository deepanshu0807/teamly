import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_team/screens/home_page.dart';
import 'package:my_team/services/auth-exception-handler.dart';
import 'package:my_team/services/auth-result-status.dart';
import 'package:my_team/services/firebase-auth-helper.dart';
import 'package:my_team/utils/utility.dart';
import 'package:my_team/widgets/inverted_top_border.dart';
import 'package:my_team/widgets/snackbar.dart';
import 'package:my_team/widgets/text_input_find_out.dart';

import '../widgets/snake_button.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController nameC = TextEditingController();

  bool isLoading = false;

  final resizeNotifier = ValueNotifier(false);

  _registerUser() async {
    setState(() {
      isLoading = true;
    });
    final status = await FirebaseAuthHelper().createAccount(
        email: emailC.text, pass: passwordC.text, name: nameC.text);
    if (status == AuthResultStatus.successful) {
      resizeNotifier.value = false;
      setState(() {
        isLoading = false;
      });
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, CupertinoPageRoute(builder: (context) => HomePage()));
      });
    } else {
      setState(() {
        isLoading = false;
      });
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
      ScaffoldMessenger.of(context)
          .showSnackBar(generateErrorMessage(errorMsg));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!resizeNotifier.value) resizeNotifier.value = true;
    });
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! > 10) {
            resizeNotifier.value = false;
            Navigator.pop(context);
          }
        },
        child: Stack(
          children: <Widget>[
            ValueListenableBuilder(
              valueListenable: resizeNotifier,
              builder: (context, value, child) {
                value as bool;
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.fastOutSlowIn,
                  bottom: value ? 0 : -size.height * .5,
                  left: 0,
                  right: 0,
                  child: child!,
                );
              },
              child: SizedBox(
                height: size.height,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: size.height * .1),
                    const Spacer(),
                    Stack(
                      children: [
                        Center(
                            child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black87,
                                      Colors.black.withOpacity(0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                child: _DragDownIndication())),
                        Padding(
                          padding: const EdgeInsets.only(top: 55),
                          child: ClipPath(
                            clipper: InvertedTopBorder(circularRadius: 40),
                            child: Container(
                              //height: 440,
                              width: double.infinity,
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const SizedBox(height: 60),
                                  TextInputFindOut(
                                    controller: nameC,
                                    label: 'Your name',
                                    iconData: Icons.account_circle_outlined,
                                    textInputType: TextInputType.text,
                                  ),
                                  const SizedBox(height: 20),
                                  TextInputFindOut(
                                    controller: emailC,
                                    label: 'Email address',
                                    iconData: Icons.alternate_email,
                                    textInputType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: 20),
                                  TextInputFindOut(
                                    controller: passwordC,
                                    label: 'Password',
                                    iconData: Icons.lock_outline,
                                    textInputType:
                                        TextInputType.visiblePassword,
                                  ),
                                  verticalSpaceMedium30,
                                  isLoading
                                      ? CircularProgressIndicator(
                                          strokeWidth: 4,
                                          color: AppColors.primaryColor,
                                          backgroundColor: Colors.grey[300],
                                        )
                                      : SnakeButton(
                                          borderColor: Colors.black,
                                          onPressed: () {
                                            _registerUser();
                                          },
                                          child: Text(
                                            'Signup',
                                            style: GoogleFonts.dmSerifDisplay(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.primaryColor,
                                              decorationStyle:
                                                  TextDecorationStyle.wavy,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DragDownIndication extends StatelessWidget {
  const _DragDownIndication();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Create an account',
            style: text60Italiana.copyWith(
              fontSize: 35.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        verticalSpaceSmall,
        verticalSpaceSmall,
        Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white.withOpacity(.8),
          size: 32,
        ),
      ],
    );
  }
}
