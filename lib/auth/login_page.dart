import 'dart:async';

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

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final resizeNotifier = ValueNotifier(false);

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  bool isLoading = false;

  _login() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseAuthHelper()
        .login(email: emailC.text, pass: passwordC.text)
        .then((statusValue) {
      if (statusValue == AuthResultStatus.successful) {
        resizeNotifier.value = false;
        setState(() {
          isLoading = false;
        });
        _openHomePage(context);
      } else {
        setState(() {
          isLoading = false;
        });
        final errorMsg =
            AuthExceptionHandler.generateExceptionMessage(statusValue);
        ScaffoldMessenger.of(context)
            .showSnackBar(generateErrorMessage(errorMsg));
      }
    });
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
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.black87, Colors.transparent],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              child: _DragDownIndication()),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 55),
                          child: ClipPath(
                            clipper: InvertedTopBorder(circularRadius: 40),
                            child: Container(
                              height: 340,
                              width: double.infinity,
                              color: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const SizedBox(height: 60),
                                  TextInputFindOut(
                                    controller: emailC,
                                    label: 'Email address',
                                    iconData: Icons.email_outlined,
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
                                  verticalSpaceMedium25,
                                  isLoading
                                      ? CircularProgressIndicator(
                                          strokeWidth: 4,
                                          color: AppColors.primaryColor,
                                          backgroundColor: Colors.grey[300],
                                        )
                                      : SnakeButton(
                                          borderColor: AppColors.primaryColor,
                                          snakeColor: Colors.black,
                                          onPressed: () {
                                            _login();
                                          },
                                          child: Text(
                                            'Login',
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

  _openHomePage(BuildContext context) {
    final newRoute = PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: HomePage(),
        );
      },
    );
    Navigator.pushReplacement(context, newRoute);
  }
}

class _DragDownIndication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Welcome back!',
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
