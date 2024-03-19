import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:flutter/cupertino.dart';
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
    height: 3.h,
    thickness: 0.5,
    // indent: .h,
    // endIndent: 1.h,
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

Widget setNavtile(
  String svg,
  String title,
  Function callback, {
  bool? isBig,
}) {
  return GestureDetector(
    onTap: () {
      callback();
      logcat("onCLICK", "DONE");
    },
    child: Container(
      color: isDarkMode() ? black : Colors.grey[900],
      padding: EdgeInsets.only(
        top: SizerUtil.deviceType == DeviceType.mobile ? 1.4.h : 1.h,
        bottom: SizerUtil.deviceType == DeviceType.mobile ? 1.4.h : 1.h,
        left: SizerUtil.deviceType == DeviceType.mobile
            ? 7.w
            : title == ScreenTitle.signOut
                ? 5.w
                : 4.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isBig == true
              ? SvgPicture.asset(
                  svg,
                  color: white,
                  height: 2.5.h,
                  width: 1.6.h,
                )
              : SvgPicture.asset(
                  svg,
                  color: white,
                  height: 2.1.h,
                  width: 1.5.h,
                ),
          SizedBox(
            width: isBig == true
                ? SizerUtil.deviceType == DeviceType.mobile
                    ? 3.w
                    : 3.5.w
                : SizerUtil.deviceType == DeviceType.mobile
                    ? 3.5.w
                    : title == ScreenTitle.signOut
                        ? 3.5.w
                        : 3.0.w,
          ),
          Text(title,
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: opensansMedium,
                  fontSize: SizerUtil.deviceType == DeviceType.mobile
                      ? 12.5.sp
                      : 10.sp,
                  fontWeight: FontWeight.w600))
        ],
      ),
    ),
  );
}

Row switchRow(String svg, String title, bool switchValue, Function onChanged) {
  return Row(
    children: [
      SvgPicture.asset(
        svg,
        color: isDarkMode() ? white : black,
      ),
      SizedBox(width: 8.0),
      Text(
        title,
        style: TextStyle(
          fontFamily: opensansMedium,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      Spacer(),
      CupertinoSwitch(
        value: switchValue,
        onChanged: (value) {
          onChanged();
        },
        thumbColor:
            isDarkMode() ? CupertinoColors.black : CupertinoColors.white,
        activeColor:
            isDarkMode() ? CupertinoColors.white : CupertinoColors.black,
        trackColor: Colors.grey,
      ),
    ],
  );
}

Widget settingRow(String svg, String title, Function callback, String arrow) {
  return GestureDetector(
    onTap: () {
      callback();
    },
    child: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          title == SettingConstant.reportBug
              ? SvgPicture.asset(
                  svg,
                  color: isDarkMode() ? white : black,
                  height:
                      SizerUtil.deviceType == DeviceType.mobile ? 2.8.h : 2.5.h,
                  width: SizerUtil.deviceType == DeviceType.mobile ? 1.h : 2.h,
                )
              : SvgPicture.asset(
                  svg,
                  color: isDarkMode() ? white : black,
                  fit: BoxFit.contain,
                  height: SizerUtil.deviceType == DeviceType.mobile ? null : 25,
                  width: SizerUtil.deviceType == DeviceType.mobile ? null : 25,
                ),
          SizedBox(
            width: title == SettingConstant.invite_frd
                ? SizerUtil.deviceType == DeviceType.mobile
                    ? 5.w
                    : 5.w
                : SizerUtil.deviceType == DeviceType.mobile
                    ? 5.5.w
                    : 5.w,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize:
                    SizerUtil.deviceType == DeviceType.mobile ? 14.sp : 11.sp,
                color: isDarkMode() ? white : black,
                fontFamily: opensansMedium,
                fontWeight: FontWeight.w400),
          ),
          Spacer(),
          SvgPicture.asset(
            arrow,
            color: isDarkMode() ? white : black,
          ),
        ],
      ),
    ),
  );
  // return ListTile(

  //   leading: title == "Report Bug"
  //       ? SvgPicture.asset(
  //           svg,
  //           color: isDarkMode() ? white : black,
  //           height: 3.h,
  //           width: 1.h,
  //         )
  //       : SvgPicture.asset(
  //           svg,
  //           color: isDarkMode() ? white : black,
  //         ),
  //   horizontalTitleGap: 0.1,
  //   visualDensity: VisualDensity(horizontal: 1, vertical: -1),
  //   title: Text(
  //     title,
  //     style: TextStyle(
  //         fontSize: 14.sp,
  //         fontFamily: opensansMedium,
  //         fontWeight: FontWeight.w400),
  //   ),
  //   onTap: () {
  //     callback();
  //   },

  //   trailing: SvgPicture.asset(
  //     arrow,
  //     color: isDarkMode() ? white : black,
  //   ),
  // );
}

Widget darkSwitch(
  String svg,
  String title,
) {
  // return GestureDetector(
  //   onTap: () {
  //       callback();
  //   },
  //   child: Container(

  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         title == "Report Bug"
  //             ? SvgPicture.asset(
  //                 svg,
  //                 color: isDarkMode() ? white : black,
  //                 height: 3.h,
  //                 width: 1.h,
  //               )
  //             : SvgPicture.asset(
  //                 svg,
  //                 color: isDarkMode() ? white : black,
  //               ),
  //               SizedBox(width: 3.w,),
  //         Text(
  //           title,
  //           style: TextStyle(
  //               fontSize: 14.sp,
  //               fontFamily: opensansMedium,
  //               fontWeight: FontWeight.w400),
  //         ),
  //         Spacer(),
  //         SvgPicture.asset(
  //           arrow,
  //           color: isDarkMode() ? white : black,
  //         ),
  //       ],
  //     ),
  //   ),
  // );
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
    // onTap: () {
    //   callback();
    // },

    // trailing: SvgPicture.asset(
    //   arrow,
    //   color: isDarkMode() ? white : black,
    // ),
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
