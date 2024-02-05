import 'package:flutter/material.dart';
import 'package:my_team/utils/textstyles.dart';

class RectangularButton extends StatelessWidget {
  const RectangularButton({
    required this.label,
    required this.onPressed,
  });
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );

    return SizedBox(
      height: MediaQuery.of(context).size.height * .056,
      child: TextButton(
        onPressed: onPressed,
        style: flatButtonStyle,
        child: Text(
          label,
          style: text14.copyWith(
            color: Colors.white70,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
