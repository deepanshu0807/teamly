import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_team/utils/utility.dart';

class AnimatedBackground extends StatefulWidget {
  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> {
  late PageController pageController;
  late Timer timerSlide;
  List<String> captions = [
    "Create or Join meetings seamlessly!",
    "Your meetings are encrypted and we respect your privacy",
    "Connect with your family or friends in a go!"
  ];

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: .999);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      timerSlide =
          Timer.periodic(const Duration(seconds: 5), (Timer timer) async {
        pageController.nextPage(
            duration: const Duration(milliseconds: 1400),
            curve: Curves.easeInOutCubicEmphasized);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timerSlide.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      itemBuilder: (context, index) {
        final i = index % 3;
        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              'images/img${(i + 1).toInt()}.jpg',
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black54,
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 50,
              right: 50,
              child: Center(
                  child: SizedBox(
                width: screenWidth(context),
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    captions[i],
                    style: text16.copyWith(
                      color: Colors.white.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
            ),
          ],
        );
      },
    );
  }
}
