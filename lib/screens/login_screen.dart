import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_utility/constant_utility.dart';
import 'package:my_team/auth/login_page.dart';
import 'package:my_team/auth/register_page.dart';
import 'package:my_team/screens/testHomeAnim.dart';
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
            child: AnimatedBackground(),
          ),
          ValueListenableBuilder(
            valueListenable: hideNotifier,
            builder: (context, value, child) {
              value as bool;
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
            child: Column(
              crossAxisAlignment: crossS,
              children: <Widget>[
                verticalSpaceMassive,
                verticalSpaceMassive,
                verticalSpaceMassive,
                verticalSpaceMassive,
                Center(
                  child: Text(
                    'Teamly',
                    style: text60Italiana.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    'Meetings on-the-Go',
                    textAlign: TextAlign.center,
                    style: text60Pacifico.copyWith(
                      color: Colors.white.withOpacity(.5),
                      fontSize: 30.sp,
                    ),
                  ),
                ),
                const Spacer(flex: 1),
                verticalSpaceMedium30,
                Center(
                  child: SizedBox(
                    height: screenHeight(context) / 6,
                    child: Column(
                      children: [
                        Builder(builder: (context) {
                          return SnakeButton(
                            borderColor: Colors.white,
                            onPressed: () async {
                              setState(() {
                                opacTrue = !opacTrue;
                                hideNotifier.value = true;
                              });

                              await Navigator.of(context).push(PageRouteBuilder(
                                opaque: false,
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: LoginPage(),
                                  );
                                },
                              ));

                              setState(() {
                                hideNotifier.value = false;
                                opacTrue = !opacTrue;
                              });
                            },
                            child: Text(
                              'Login',
                              style: text18.copyWith(color: Colors.white),
                            ),
                          );
                        }),
                        verticalSpaceMedium20,
                        RectangularButton(
                          onPressed: () async {
                            setState(() {
                              opacTrue = !opacTrue;
                              hideNotifier.value = true;
                            });

                            await Navigator.of(context).push(PageRouteBuilder(
                              opaque: false,
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: RegisterPage(),
                                );
                              },
                            ));

                            setState(() {
                              hideNotifier.value = false;
                              opacTrue = !opacTrue;
                            });
                          },
                          label: 'Create a new account',
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
