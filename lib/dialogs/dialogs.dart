import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Models/CategoryModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../core/Common/toolbar.dart';
import '../core/themes/color_const.dart';
import '../core/themes/font_constant.dart';

void showMessage(
    {required BuildContext context,
    Function? callback,
    String? title,
    String? message,
    String? positiveButton,
    String? negativeButton}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => FadeInUp(
            duration: const Duration(milliseconds: 300),
            animate: true,
            from: 30,
            child: CupertinoAlertDialog(
              title: Text(
                title!,
                style: TextStyle(
                  fontFamily: fontBold,
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 15.sp : 8.sp,
                ),
              ),
              content: Text(
                message!,
                style: const TextStyle(
                  fontFamily: fontRegular,
                ),
              ),
              actions: [
                if (negativeButton!.isNotEmpty)
                  CupertinoDialogAction(
                      child: Text(
                        negativeButton,
                        style: TextStyle(
                            fontSize: SizerUtil.deviceType == DeviceType.mobile
                                ? 12.sp
                                : 6.sp,
                            fontFamily: fontMedium,
                            color: black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                if (positiveButton!.isNotEmpty)
                  CupertinoDialogAction(
                      child: Text(
                        positiveButton,
                        style: TextStyle(
                            fontSize: SizerUtil.deviceType == DeviceType.mobile
                                ? 12.sp
                                : 6.sp,
                            fontFamily: fontMedium,
                            color: black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        callback!();
                      })
              ],
            ),
          ));
}

void showDropdownMessage(
  BuildContext context,
  Widget content,
  String title,
) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Padding(
              padding: EdgeInsets.only(
                  left:
                      SizerUtil.deviceType == DeviceType.mobile ? 0.w : 2.9.w),
              child: Text(
                title,
                style: TextStyle(fontFamily: fontMedium, fontSize: 20.sp),
              ),
            ),
            contentPadding:
                EdgeInsets.only(left: 6.7.w, top: 0.5.h, right: 6.7.w),
            content: content,
          );
        });
      });
}

Widget setDropDownContent(RxList<dynamic> list, Widget content,
    {Widget? searchcontent, bool isApiIsLoading = false}) {
  return SizedBox(
      height: SizerUtil.deviceType == DeviceType.mobile
          ? SizerUtil.height / 2
          : SizerUtil.height / 1.9, // Change as per your requirement
      width: SizerUtil.width, // Change as per your requirement
      child: Column(
        children: [
          getDividerForShowDialog(),
          searchcontent != null ? searchcontent : Container(),
          if (list.isEmpty && isApiIsLoading == false)
            Expanded(
              child: Center(
                  child: Text(
                "Empty List",
                style: TextStyle(fontSize: 4.5.w, fontFamily: fontMedium),
              )),
            )
          else if (isApiIsLoading == true)
            Expanded(
              child: Center(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    "assets/gif/ZKZg.gif",
                    width: 50,
                    height: 50,
                  ),
                ),
              )),
            ),
          list.isNotEmpty ? Expanded(child: content) : Container(),
          SizedBox(
            height: 1.0.h,
          ),
        ],
      ));
}

Widget setDropDownTestContent(RxList<dynamic> list, Widget content,
    {Widget? searchcontent}) {
  return SizedBox(
      height: SizerUtil.deviceType == DeviceType.mobile
          ? SizerUtil.height / 2
          : SizerUtil.height / 1.9, // Change as per your requirement
      width: SizerUtil.width, // Change as per your requirement
      child: Column(
        children: [
          getDividerForShowDialog(),
          searchcontent != null ? searchcontent : Container(),
          if (list.isEmpty)
            Expanded(
              child: Center(
                  child: Text(
                "Empty List",
                style: TextStyle(fontSize: 4.5.w, fontFamily: fontMedium),
              )),
            ),
          list.isNotEmpty ? Expanded(child: content) : Container(),
          SizedBox(
            height: 1.0.h,
          ),
        ],
      ));
}
