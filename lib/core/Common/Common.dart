import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:sizer/sizer.dart';

import '../utils/helper.dart';

class Common {
  Widget getDivider() {
    return Container(
      height: 0.5.h,
      width: 30.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black),
    );
  }

  Future commonDetailsDialog(BuildContext context, String title, Widget contain,
      {bool? isNotes, bool? isDescription}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            insetPadding: EdgeInsets.symmetric(
                vertical: isNotes == true
                    ? SizerUtil.deviceType == DeviceType.mobile
                        ? 10.h
                        : 20.h
                    : isDescription == true
                        ? SizerUtil.deviceType == DeviceType.mobile
                            ? 15.h
                            : 25.h
                        : SizerUtil.deviceType == DeviceType.mobile
                            ? 20.h
                            : 10.h,
                horizontal:
                    SizerUtil.deviceType == DeviceType.mobile ? 3.h : 6.h),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20.0), // Adjust the radius as needed
            ),
            elevation: 0.0, // No shadow
            //clipBehavior: Clip.antiAlias,
            backgroundColor: isDarkMode() ? black : white,
            content:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 3.h,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: 55.w,
                          child: title.length > 18
                              ? Marquee(
                                  style: TextStyle(
                                    fontFamily: fontRegular,
                                    color: isDarkMode() ? white : black,
                                    fontSize: SizerUtil.deviceType ==
                                            DeviceType.mobile
                                        ? 16.sp
                                        : 8.sp,
                                  ),
                                  text: title,
                                  scrollAxis: Axis
                                      .horizontal, // Use Axis.vertical for vertical scrolling
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Adjust as needed
                                  blankSpace:
                                      20.0, // Adjust the space between text repetitions
                                  velocity: 50.0, // Adjust the scrolling speed
                                  pauseAfterRound: const Duration(
                                      seconds:
                                          1), // Time to pause after each scroll
                                  startPadding:
                                      2.w, // Adjust the initial padding
                                  accelerationDuration: const Duration(
                                      seconds: 1), // Duration for acceleration
                                  accelerationCurve:
                                      Curves.linear, // Acceleration curve
                                  decelerationDuration: const Duration(
                                      milliseconds:
                                          500), // Duration for deceleration
                                  decelerationCurve:
                                      Curves.easeOut, // Deceleration curve
                                )
                              : Text(
                                  title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: fontRegular,
                                    color: isDarkMode() ? white : black,
                                    fontSize: SizerUtil.deviceType ==
                                            DeviceType.mobile
                                       ? 16.sp
                                        : 8.sp,
                                  ),
                                )),
                      Spacer(),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.cancel,
                            size: 24.0,
                            color: isDarkMode() ? white : black,
                          ),
                        ),
                      ),
                    ]),
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 1.h,
              ),
              contain
            ]));
      },
    );
  }

  Future commonDeleteDialog(
      BuildContext context, String subText, Function callback) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoTheme(
          data: CupertinoThemeData(
            brightness: isDarkMode()
                ? Brightness.dark
                : Brightness.light, // Set the brightness to light
            scaffoldBackgroundColor: white, // Set the background color to white
            textTheme: CupertinoTextThemeData(
              textStyle: TextStyle(color: black), // Set text color to black
            ),
          ),
          child: CupertinoAlertDialog(
            title: Text('Confirm Delete',
                style: TextStyle(
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 17.sp
                        : 9.sp,
                    color: isDarkMode() ? white : black)),
            content: Text('Are you sure you want to delete this ${subText}?',
                style: TextStyle(
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 12.sp
                        : 7.sp,
                    color: isDarkMode() ? white : black)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Cancel',
                    style: TextStyle(
                        fontSize: SizerUtil.deviceType == DeviceType.mobile
                            ? 11.sp
                            : 8.sp,
                        color: isDarkMode() ? white : black)),
              ),
              TextButton(
                onPressed: () {
                  callback();
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  'Yes',
                  style: TextStyle(
                    color: isDarkMode() ? white : black,
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 11.sp
                        : 8.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static getMiniButton(
    Function fun,
    str,
  ) {
    return InkWell(
      onTap: () {
        fun();
      },
      child: Container(
        height: SizerUtil.deviceType == DeviceType.mobile ? 5.h : 4.5.h,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 1),
        width: SizerUtil.deviceType == DeviceType.mobile
            ? SizerUtil.width / 3
            : SizerUtil.width / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: primaryColor,
          boxShadow: [
            BoxShadow(
                color: primaryColor.withOpacity(0.2),
                blurRadius: 10.0,
                offset: const Offset(0, 1),
                spreadRadius: 3.0)
          ],
        ),
        child: Text(
          str,
          style: TextStyle(
              color: Colors.white,
              fontFamily: fontBold,
              fontSize:
                  SizerUtil.deviceType == DeviceType.mobile ? 11.sp : 8.sp),
        ),
      ),
    );
  }

  static Future<Object?> PopupDialogForOtp(BuildContext context) {
    return showGeneralDialog(
        barrierColor:
            isDarkMode() ? white.withOpacity(0.6) : black.withOpacity(0.6),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: CupertinoAlertDialog(
                  title: Text(
                    "RESEND CODE",
                    style: TextStyle(
                      fontSize: 18,
                      color: isDarkMode() ? white : black,
                      fontFamily: fontBold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Text(
                    "1234",
                    style: TextStyle(
                      fontSize: 13,
                      color: isDarkMode() ? white : black,
                      fontFamily: fontMedium,
                    ),
                  ),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("DONE",
                          style: TextStyle(
                            fontSize: 15,
                            color: isDarkMode() ? white : black,
                            fontFamily: fontBold,
                            fontWeight: FontWeight.bold,
                          )),
                      isDefaultAction: true,
                      isDestructiveAction: true,
                    ),
                    // The "No" button
                  ],
                )),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }

  static Future<Object?> PopupDialogs(BuildContext context) {
    return showGeneralDialog(
        barrierColor:
            isDarkMode() ? white.withOpacity(0.6) : black.withOpacity(0.6),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: CupertinoAlertDialog(
                  title: Text(
                    "HairCuts",
                    style: TextStyle(
                      fontSize: 18,
                      color: isDarkMode() ? white : black,
                      fontFamily: fontBold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Text(
                    "Haircutting (also hair shaping) - is the process of cutting, tapering, texturizing and thinning using any hair cutting tools in order to create a shape. ",
                    style: TextStyle(
                      fontSize: 13,
                      color: isDarkMode() ? white : black,
                      fontFamily: fontMedium,
                    ),
                  ),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("DONE",
                          style: TextStyle(
                            fontSize: 15,
                            color: isDarkMode() ? white : black,
                            fontFamily: fontBold,
                            fontWeight: FontWeight.bold,
                          )),
                      isDefaultAction: true,
                      isDestructiveAction: true,
                    ),
                    // The "No" button
                  ],
                )),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }

  void trasparent_statusbar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness:
          isDarkMode() ? Brightness.light : Brightness.dark,
      statusBarColor: isDarkMode() ? Colors.transparent : Colors.transparent,
      statusBarBrightness: isDarkMode() ? Brightness.light : Brightness.dark,
    ));
  }

  String getCurrentDate() {
    // Get the current date
    DateTime now = DateTime.now();
    // Format th date as yyyy-mm-dd
    return DateFormat('yyyy-MM-dd').format(now);
  }

  String getCurrentDateFormate() {
    // Get the current date
    DateTime now = DateTime.now();
    // Format th date as yyyy-mm-dd
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(now);
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('MMMM dd, yyyy').format(dateTime);
  }

  String formatDates(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
}
