import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_team/screens/splashscreen.dart';
import 'package:my_team/utils/colors.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.secondaryColor,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.secondaryColor));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppHome(),
    );
  }
}

//Navigator context was facing issue, separating this class from MyApp to fix for the time being
class AppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (ctx, child) {
          ScreenUtil.init(ctx, designSize: const Size(375, 812));
          return Theme(
            data: ThemeData(),
            child: SplashScreen(),
          );
        },
        title: 'Teamly',
        debugShowCheckedModeBanner: false);
    //     },
    //   );
  }
}
