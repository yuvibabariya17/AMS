import 'package:booking_app/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'color_const.dart';
import 'font_constant.dart';

styleTextForFieldLabel(FocusNode node) {
  return TextStyle(
    fontFamily: fontRegular,
    color: isDarkMode() ? white : Color(0xFF262C2E),
    fontSize: SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 6.sp,
  );
}

styleTextForFieldHint() {
  return TextStyle(
      fontSize: SizerUtil.deviceType == DeviceType.mobile ? 11.sp : 9.sp,
      fontFamily: fontRegular,
      color: isDarkMode() ? white : black);
}

styleTextForErrorFieldHint() {
  return TextStyle(
      fontSize: 11.sp,
      fontFamily: fontRegular,
      color: isDarkMode() ? white : red);
}

styleTextFormFieldText() {
  return TextStyle(
      fontFamily: fontRegular,
      fontSize: SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 9.sp,
      color: isDarkMode() ? white : Color(0xFF262C2E));
}

TextStyle styleForSecondaryText() {
  return TextStyle(
      fontSize: 10.sp,
      color: isDarkMode() ? white : lightAccentColor,
      fontFamily: fontRegular,
      decoration: TextDecoration.underline);
}

styleTextForField() {
  return TextStyle(
      fontSize: 11.sp,
      fontFamily: fontRegular,
      color: isDarkMode() ? white : lightAccentColor,
      fontWeight: FontWeight.bold);
}

TextStyle styleForTextWithUnderline() {
  return TextStyle(
      fontSize: 10.sp,
      color: isDarkMode() ? white : lightAccentColor,
      fontFamily: fontRegular,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline);
}
