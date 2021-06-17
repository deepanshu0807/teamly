import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_team/auth/login_page.dart';
import 'package:my_team/auth/register_page.dart';
import 'package:my_team/utils/colors.dart';
import 'package:my_team/utils/textstyles.dart';
import 'package:my_team/utils/utility.dart';
import 'package:my_team/widgets/animated_background.dart';
import 'package:my_team/widgets/rectangular_button.dart';
import 'package:my_team/widgets/snake_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final hideNotifier = ValueNotifier(false);

  bool opacTrue = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          AnimatedOpacity(
              duration: Duration(milliseconds: 600),
              opacity: opacTrue ? 0.8 : 1,
              child: AnimatedBackground()),
          ValueListenableBuilder(
            valueListenable: hideNotifier,
            builder: (context, value, child) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                curve: Curves.fastOutSlowIn,
                top: 0,
                bottom: value ? -100 : 0,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.fastOutSlowIn,
                  opacity: value ? 0.0 : 1.0,
                  child: child,
                ),
              );
            },
            child: Center(
              child: Container(
                height: size.height * .75,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      verticalSpaceMassive,
                      verticalSpaceMassive,
                      Text(
                        'Teamly',
                        style: text60.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Meetings on the Go',
                        textAlign: TextAlign.center,
                        style: text30.copyWith(
                            color: Colors.white.withOpacity(.5)),
                      ),
                      const Spacer(flex: 5),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: SnakeButton(
                              onPressed: () => _openPage(context, LoginPage()),
                              child: Text(
                                'Login',
                                style: text18.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: RectangularButton(
                              onPressed: () =>
                                  _openPage(context, RegisterPage()),
                              label: 'Register',
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _openPage(BuildContext context, Widget page) async {
    setState(() {
      opacTrue = !opacTrue;
    });
    hideNotifier.value = true;
    await Navigator.push(
        context,
        PageRouteBuilder(
          opaque: false,
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(opacity: animation, child: page);
          },
        ));
    hideNotifier.value = false;
    setState(() {
      opacTrue = !opacTrue;
    });
  }
}
