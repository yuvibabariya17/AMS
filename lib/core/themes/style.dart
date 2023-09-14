import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'color_const.dart';
import 'font_constant.dart';

styleTextForFieldLabel(FocusNode node) {
  return TextStyle(
    fontFamily: fontRegular,
    color: Color(0xFF262C2E),
    fontSize: SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 6.sp,
  );
}

styleTextForFieldHint() {
  return TextStyle(
      fontSize: 11.sp, fontFamily: fontRegular, color: primaryColor);
}

styleTextFormFieldText() {
  return TextStyle(
      fontFamily: fontRegular,
      fontSize: SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 7.sp,
      color: Color(0xFF262C2E));
}

TextStyle styleForSecondaryText() {
  return TextStyle(
      fontSize: 10.sp,
      color: lightAccentColor,
      fontFamily: fontRegular,
      decoration: TextDecoration.underline);
}

styleTextForField() {
  return TextStyle(
      fontSize: 11.sp,
      fontFamily: fontRegular,
      color: lightAccentColor,
      fontWeight: FontWeight.bold);
}

TextStyle styleForTextWithUnderline() {
  return TextStyle(
      fontSize: 10.sp,
      color: lightAccentColor,
      fontFamily: fontRegular,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline);
}
