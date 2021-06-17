import 'package:flutter/material.dart';
import 'package:my_team/utils/textstyles.dart';

class RectangularButton extends StatelessWidget {
  const RectangularButton({
    Key key,
    @required this.label,
    @required this.onPressed,
  }) : super(key: key);
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .056,
      child: FlatButton(
        onPressed: onPressed,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 3)),
        child: Text(
          label,
          style: text18.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
