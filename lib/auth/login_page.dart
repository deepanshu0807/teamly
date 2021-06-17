import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_team/screens/homepage.dart';
import 'package:my_team/services/auth-exception-handler.dart';
import 'package:my_team/services/auth-result-status.dart';
import 'package:my_team/services/firebase-auth-helper.dart';
import 'package:my_team/utils/textstyles.dart';
import 'package:my_team/utils/utility.dart';
import 'package:my_team/widgets/inverted_top_border.dart';
import 'package:my_team/widgets/snackbar.dart';
import 'package:my_team/widgets/text_input_find_out.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final resizeNotifier = ValueNotifier(false);

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  _login() async {
    final status = await FirebaseAuthHelper()
        .login(email: emailC.text, pass: passwordC.text);
    if (status == AuthResultStatus.successful) {
      _btnController.success();
      resizeNotifier.value = false;
      Timer(Duration(seconds: 2), () {
        _openHomePage(context);
      });
    } else {
      _btnController.error();
      Timer(Duration(seconds: 1), () {
        _btnController.reset();
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
          if (details.primaryDelta > 10) {
            resizeNotifier.value = false;
            Navigator.pop(context);
          }
        },
        child: Stack(
          children: <Widget>[
            ValueListenableBuilder(
              valueListenable: resizeNotifier,
              builder: (context, value, child) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.fastOutSlowIn,
                  bottom: value ? 0 : -size.height * .5,
                  left: 0,
                  right: 0,
                  child: child,
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
                                  RoundedLoadingButton(
                                    width: size.width * .65,
                                    borderRadius: 5,
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
                                    onPressed: () {
                                      _login();
                                    },
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
      transitionDuration: const Duration(milliseconds: 2500),
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
  const _DragDownIndication({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Login',
            style: text30.copyWith(
                fontWeight: FontWeight.bold, color: Colors.white)),
        Text(
          'Drag to close',
          style: TextStyle(
              height: 2, fontSize: 14, color: Colors.white.withOpacity(.9)),
        ),
        Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white.withOpacity(.8),
          size: 32,
        ),
      ],
    );
  }
}
