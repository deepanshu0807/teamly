import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget horizontalSpaceTiny = SizedBox(width: 5.0.w);
Widget horizontalSpaceSmall = SizedBox(width: 10.0.w);
Widget horizontalSpaceMedium15 = SizedBox(width: 15.0.w);
Widget horizontalSpaceMedium20 = SizedBox(width: 20.0.w);
Widget horizontalSpaceMedium25 = SizedBox(width: 25.0.w);
Widget horizontalSpaceMedium30 = SizedBox(width: 30.0.w);
Widget horizontalSpaceMedium40 = SizedBox(width: 40.0.w);
Widget horizontalSpaceMassive = SizedBox(width: 100.0.w);

Widget verticalSpaceTiny = SizedBox(height: 5.0.h);
Widget verticalSpaceSmall = SizedBox(height: 10.0.h);
Widget verticalSpaceMedium15 = SizedBox(height: 15.0.h);
Widget verticalSpaceMedium20 = SizedBox(height: 20.0.h);
Widget verticalSpaceMedium25 = SizedBox(height: 25.0.h);
Widget verticalSpaceMedium30 = SizedBox(height: 30.0.h);
Widget verticalSpaceLarge = SizedBox(height: 50.0.h);
Widget verticalSpaceMassive = SizedBox(height: 100.0.h);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0}) =>
    (screenHeight(context) - offsetBy) / dividedBy;

double screenWidthFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0}) =>
    (screenWidth(context) - offsetBy) / dividedBy;

double halfScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 2);

double thirdScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 3);
