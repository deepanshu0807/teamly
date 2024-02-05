import 'package:flutter/material.dart';
import 'package:my_team/utils/utility.dart';

ButtonStyle flatbuttonStyle(RoundedRectangleBorder borderShape,
    EdgeInsets padding, Color? primaryColor) {
  return TextButton.styleFrom(
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );
}
