import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../constants/strings.dart';
import 'color_const.dart';
import 'font_constant.dart';

class AppTheme {
  const AppTheme._();
  static final lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25.sp,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
          fontSize: 10.sp, color: Colors.black, fontFamily: fontRegular),
      bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
    //colorScheme: ColorScheme(background: lightBackgroundColor,brightness: Brightness.dark)
  );

  static final darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    primaryColor: lightPrimaryColor,
    textTheme: TextTheme(
        displayMedium: TextStyle(
            fontSize: 10.sp, color: Colors.white, fontFamily: fontRegular),
        displayLarge: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25.sp, color: Colors.white)),
    // colorScheme: ColorScheme(background: appDarkPrimaryColor)
  );

  static Brightness currentSystemBrightness() {
    return SchedulerBinding.instance.window.platformBrightness;
  }

  static Future<Brightness> getCurrentSystemBrightness() async {
    Brightness currentBrightness;
    final EncryptedSharedPreferences encryptedSharedPreferences =
        EncryptedSharedPreferences();
    String value = await encryptedSharedPreferences.getString(Strings.keyTheme);

    if (value.toString().isEmpty || value == Strings.lightTheme) {
      currentBrightness = Brightness.light;
    } else {
      currentBrightness = Brightness.dark;
    }
    return currentBrightness;
  }

  static setStatusNavigationbarColor(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness:
            themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: themeMode == ThemeMode.light
            ? lightBackgroundColor
            : darkBackgroundColor,
        systemNavigationBarDividerColor: Colors.transparent));

    //change status bar text color
    SystemChrome.setSystemUIOverlayStyle(themeMode == ThemeMode.light
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light);
  }
}
