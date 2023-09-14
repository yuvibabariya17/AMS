import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../utils/helper.dart';

class Common {
  Future _ackAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Not in stock'),
          content: const Text('This item is no longer available'),
          actions: [
            ElevatedButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  openDialoag(String name, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(name + ' is now a verified account'),
            title: const Text('Registration Successful'),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Verified',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          );
        });
  }

  Widget getDivider() {
    return Container(
      height: 0.5.h,
      width: 30.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black),
    );
  }

  void _showInSnackBar({required String message}) {
    var _formKey;
    _formKey.currentState.showSnackBar(
      SnackBar(
        content: GestureDetector(
          onTap: () {},
          child: Text(
            message,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        duration: (const Duration(seconds: 4)),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
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

  static Future<Object?> PopupDialog(BuildContext context) {
    return showGeneralDialog(
        barrierColor: black.withOpacity(0.6),
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
                      color: black,
                      fontFamily: fontBold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Text(
                    "1234",
                    style: TextStyle(
                      fontSize: 13,
                      color: black,
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
                            color: black,
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
        barrierColor: black.withOpacity(0.6),
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
                      color: black,
                      fontFamily: fontBold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Text(
                    "Haircutting (also hair shaping) - is the process of cutting, tapering, texturizing and thinning using any hair cutting tools in order to create a shape. ",
                    style: TextStyle(
                      fontSize: 13,
                      color: black,
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
                            color: black,
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
      statusBarBrightness: isDarkMode() ? Brightness.dark : Brightness.light,
    ));
  }
}
