import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../themes/font_constant.dart';

Widget getDivider() {
  return Container(
    height: 0.5.h,
    width: 22.w,
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: Colors.black),
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
