import 'package:flutter/material.dart';
import 'package:my_team/utils/utility.dart';

generateErrorMessage(String text) {
  return SnackBar(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      backgroundColor: Colors.red,
      content: Row(
        children: [
          Icon(
            Icons.error,
            color: Colors.white,
          ),
          horizontalSpaceMedium15,
          Text(
            text,
            style: text18.copyWith(color: Colors.white),
          ),
        ],
      ));
}
