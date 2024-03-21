import 'dart:async';
import 'package:booking_app/Screens/DashboardScreen/DashboardScreen.dart';
import 'package:booking_app/Screens/OnboardingScreen/IntroScreen%20.dart';
import 'package:booking_app/core/utils/helper.dart';
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
        Get.offAll(MyHomePage());
      } else {
        Get.offAll(IntroScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: isDarkMode()
              ? SvgPicture.asset(Asset.amsblack,
                  fit: BoxFit.cover, width: SizerUtil.width)
              : SvgPicture.asset(Asset.splash_bg,
                  fit: BoxFit.cover, width: SizerUtil.width),
        ),
      ),
    );
  }
}
