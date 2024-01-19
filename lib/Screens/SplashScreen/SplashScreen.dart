import 'dart:async';

import 'package:booking_app/Screens/DashboardScreen/DashboardScreen.dart';
import 'package:booking_app/Screens/OnboardingScreen/IntroScreen%20.dart';
import 'package:booking_app/Screens/StudentScreen/StudentScreen.dart';
import 'package:booking_app/models/SignInModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/constants/assets.dart';
import '../../preference/UserPreference.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      SignInData? retrievedObject = await UserPreferences().getSignInInfo();
      if (retrievedObject != null) {
        Get.offAll(const dashboard());
      } else {
        Get.offAll(const IntroScreen());
        // Get.offAll(const IntroScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: SvgPicture.asset(Asset.splash_bg,
            fit: BoxFit.cover,
            width: SizerUtil.deviceType == DeviceType.mobile
                ? SizerUtil.width
                : 500),
      ),
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: SizedBox(
    //       child: AnimatedSplashScreen(
    //           splash: SvgPicture.asset(Asset.splash_bg,
    //               width: SizerUtil.width, fit: BoxFit.cover),
    //           duration: 2000,
    //           splashIconSize: double.infinity,
    //           splashTransition: SplashTransition.fadeTransition,
    //           animationDuration: Duration(seconds: 3),
    //           nextScreen: IntroScreen())),
    // );
  }
}
