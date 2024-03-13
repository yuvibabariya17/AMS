import 'dart:async';

import 'package:booking_app/Screens/BrandCategoryScreen.dart';
import 'package:booking_app/Screens/ChangepasswordScreen.dart';
import 'package:booking_app/Screens/CourseScreen/CourseScreen.dart';
import 'package:booking_app/Screens/CustomerScreen/CustomerScreen.dart';
import 'package:booking_app/Screens/DashboardScreen/DashboardScreen.dart';
import 'package:booking_app/Screens/ExpertScreen/ExpertScreen.dart';
import 'package:booking_app/Screens/OfferScreen/OfferForm.dart';
import 'package:booking_app/Screens/OnboardingScreen/IntroScreen%20.dart';
import 'package:booking_app/Screens/PackageScreen/PackageScreen.dart';
import 'package:booking_app/Screens/ProductCategoryScreen/ProductCategoryList.dart';
import 'package:booking_app/Screens/ProductScreen/ProductScreen.dart';
import 'package:booking_app/Screens/SettingScreen/AddReportBugScreen.dart';
import 'package:booking_app/Screens/SettingScreen/ReportBug.dart';
import 'package:booking_app/Screens/SettingScreen/SettingScreen.dart';
import 'package:booking_app/Screens/StudentScreen/StudentCourseScreen.dart';
import 'package:booking_app/Screens/StudentScreen/StudentScreen.dart';
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
        Get.offAll(const dashboard());
      } else {
        Get.offAll(const IntroScreen());
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
