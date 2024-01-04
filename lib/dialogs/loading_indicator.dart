import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoadingProgressDialog {
  show(BuildContext data, message) {
    showDialog(
      context: data,
      barrierDismissible: false,
      builder: (BuildContext parentContext) {
        return Center(
            child: Material(
          color: Colors.transparent,
          child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.transparent,
              ),
              child: Container(
                height: 8.h,
                width: 8.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: isDarkMode() ? black : white,
                ),
                child: Center(
                  child: ClipOval(
                    child: Image.asset(
                      'assets/gif/loadingIndicator.gif',
                      color: isDarkMode() ? black : white,
                      height: 6.h,
                      width: 6.h,
                    ),
                  ),
                ),
              )),
        ));
      },
    );
  }

  hide(BuildContext context) async {
    Navigator.pop(context);
  }
}
