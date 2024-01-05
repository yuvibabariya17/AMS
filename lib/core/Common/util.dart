import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
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
        borderRadius: BorderRadius.circular(20),
        color: isDarkMode() ? white : black),
  );
}

Widget dividerforSetting() {
  return Divider(
    height: 1.h,
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
    leading: title == "Customer"
        ? SvgPicture.asset(
            svg,
            color: isDarkMode() ? white : white,
            height: 3.2.h,
            width: 1.h,
          )
        : title == "Product"
            ? Container(
                margin: EdgeInsets.only(right: 4.w),
                child: SvgPicture.asset(
                  svg,
                  color: isDarkMode() ? white : white,
                  height: 3.5.h,
                  width: 1.5.w,
                ),
              )
            : title == "Service"
                ? Container(
                    padding: const EdgeInsets.only(right: 12),
                    child: SvgPicture.asset(
                      svg,
                      color: isDarkMode() ? white : white,
                      height: 3.5.h,
                      width: 3.5.w,
                      alignment: Alignment.topLeft,
                      fit: BoxFit.cover,
                    ),
                  )
                : SvgPicture.asset(
                    svg,
                    color: isDarkMode() ? white : white,
                  ),
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

Widget setNavtile(
  String svg,
  String title,
  Function callback, {
  bool? isBig,
}) {
  return GestureDetector(
    onTap: () {
      callback();
    },
    child: Container(
      padding: EdgeInsets.only(
        top: 1.5.h,
        bottom: 1.5.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isBig == true
              ? SvgPicture.asset(
                  svg,
                  color: isDarkMode() ? white : white,
                  height: 2.5.h,
                  width: 1.5.h,
                )
              : SvgPicture.asset(
                  svg,
                  color: isDarkMode() ? white : white,
                  height: 2.1.h,
                  width: 1.5.h,
                ),
          SizedBox(
            width: isBig == true ? 3.w : 3.5.w,
          ),
          Text(title,
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: opensansMedium,
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w600))
        ],
      ),
    ),
  );
}

Widget settingListtile(
    String svg, String title, Function callback, String arrow) {
  return ListTile(
    
    leading: title == "Report Bug"
        ? SvgPicture.asset(
            svg,
            color: isDarkMode() ? white : black,
            height: 3.h,
            width: 1.h,
          )
        : SvgPicture.asset(
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

String formatDateTime(DateTime dateTime) {
  final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ', 'en_US');
  return formatter.format(dateTime);
}
