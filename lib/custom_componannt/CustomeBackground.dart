import 'package:booking_app/Screens/DashboardScreen/DashboardScreen.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final Widget? floatingActionBtn;
  bool? isListScreen;
  bool? isFromSettingScreen;

  CustomScaffold({
    required this.body,
    this.floatingActionBtn,
    this.isListScreen,
    this.isFromSettingScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: transparent,
      body: WillPopScope(
        onWillPop: () async {
          if (isFromSettingScreen == true) {
            Get.offAll(MyHomePage(
              isFromSettingScreen: true,
            ));
          }
          return true;
        },
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: isDarkMode()
                  ? SvgPicture.asset(
                      Asset.dark_bg,
                      fit: BoxFit.cover,
                    )
                  : SvgPicture.asset(
                      Asset.bg,
                      fit: BoxFit.cover,
                    ),
            ),
            Scaffold(
              resizeToAvoidBottomInset: isListScreen == true ? false : true,
              backgroundColor:
                  transparent, // Make the Scaffold's background transparent
              body: SafeArea(child: body),
              floatingActionButton: floatingActionBtn,
            ),
          ],
        ),
      ),
    );
  }
}
