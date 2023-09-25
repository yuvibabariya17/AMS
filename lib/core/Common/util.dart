import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../themes/color_const.dart';
import '../themes/font_constant.dart';
import '../utils/helper.dart';

Widget getDivider() {
  return Container(
    height: 0.5.h,
    width: 22.w,
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: Colors.black),
  );
}

Widget dividerforSetting() {
  return Divider(
    height: 1.5,
    thickness: 1,
    indent: 2.h,
    endIndent: 2.h,
  );
}

void hideKeyboard(context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

void log(tag, data) {
  print("$tag : ${data}");
}

Widget setListTile(String svg, String title, Function callback) {
  return ListTile(
    leading: SvgPicture.asset(svg),
    horizontalTitleGap: 0.1,
    visualDensity: VisualDensity(horizontal: -2, vertical: -2),
    title: Text(title,
        style: TextStyle(
            color: Colors.grey, fontFamily: opensansMedium, fontSize: 11.5.sp)),
    onTap: () {
      callback();
    },
  );
}

Widget settingListtile(
    String svg, String title, Function callback, String arrow) {
  return ListTile(
    leading: SvgPicture.asset(
      svg,
      color: isDarkMode() ? white : black,
    ),
    horizontalTitleGap: 0.1,
    visualDensity: VisualDensity(horizontal: 1, vertical: -1),
    title: Text(
      title,
      style: TextStyle(
          fontSize: 14.sp,
          fontFamily: opensansMedium,
          fontWeight: FontWeight.w400),
    ),
    onTap: () {
      callback();
    },
    trailing: SvgPicture.asset(
      arrow,
      color: isDarkMode() ? white : black,
    ),
  );
}
