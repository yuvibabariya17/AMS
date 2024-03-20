import 'package:animate_do/animate_do.dart';
import 'package:booking_app/core/utils/helper.dart';
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
            child: CupertinoTheme(
              data: CupertinoThemeData(
                brightness: isDarkMode()
                    ? Brightness.dark
                    : Brightness.light, // Set the brightness to light
                scaffoldBackgroundColor:
                    Colors.white, // Set the background color to white
                textTheme: CupertinoTextThemeData(
                  textStyle:
                      TextStyle(color: Colors.black), // Set text color to black
                ),
              ),
              child: CupertinoAlertDialog(
                title: Text(
                  title!,
                  style: TextStyle(
                    fontFamily: fontBold,
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 15.sp
                        : 8.sp,
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
                            color: isDarkMode() ? white : black,
                          ),
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
                            color: isDarkMode() ? white : black,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          callback!();
                        })
                ],
              ),
            ),
          ));
}

void showDropdownMessage(
  BuildContext context,
  // Widget content,
  String title,
) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
              title: Padding(
                padding: EdgeInsets.only(
                    left: SizerUtil.deviceType == DeviceType.mobile
                        ? 0.w
                        : 2.9.w),
                child: Text(
                  title,
                  style: TextStyle(fontFamily: fontMedium, fontSize: 20.sp),
                ),
              ),
              contentPadding:
                  EdgeInsets.only(left: 6.7.w, top: 0.5.h, right: 6.7.w),
              content: Container()
              // content,
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
                style: TextStyle(
                    fontSize:
                        SizerUtil.deviceType == DeviceType.mobile ? 6.sp : 6.sp,
                    fontFamily: fontMedium),
              )),
            )
          else if (isApiIsLoading == true)
            Expanded(
                child: Center(
              child: ClipOval(
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: isDarkMode() ? black : white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.asset(
                    "assets/gif/apiloader.gif",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )),
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
      width: SizerUtil.deviceType == DeviceType.mobile
          ? SizerUtil.width
          : SizerUtil.width / 1.5, // Change as per your requirement
      child: Column(
        children: [
          getDividerForShowDialog(),
          searchcontent != null ? searchcontent : Container(),
          if (list.isEmpty)
            Expanded(
              child: Center(
                  child: Text(
                "Empty List",
                style: TextStyle(
                    fontSize:
                        SizerUtil.deviceType == DeviceType.mobile ? 6.sp : 6.sp,
                    fontFamily: fontMedium,
                    color: isDarkMode() ? white : black),
              )),
            ),
          list.isNotEmpty ? Expanded(child: content) : Container(),
          SizedBox(
            height: 1.0.h,
          ),
        ],
      ));
}

Future showDropDownDialog(BuildContext context, Widget content, String title) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDarkMode() ? black : white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          title: Padding(
            padding: EdgeInsets.only(
                left: SizerUtil.deviceType == DeviceType.mobile ? 0.w : 2.9.w),
            child: Text(
              title,
              style: TextStyle(
                  fontFamily: fontMedium,
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 20.sp : 13.sp,
                  color: isDarkMode() ? white : black),
            ),
          ),
          contentPadding:
              EdgeInsets.only(left: 6.7.w, top: 0.5.h, right: 6.7.w),
          content: content,
        );
      });
}

Future<Object?> selectImageFromCameraOrGallery(BuildContext context,
    {Function? cameraClick, Function? galleryClick, bool? isVideo}) {
  return showGeneralDialog(
      // barrierColor: black.withOpacity(0.6),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
              opacity: a1.value,
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  brightness: isDarkMode()
                      ? Brightness.dark
                      : Brightness.light, // Set the brightness to light
                  scaffoldBackgroundColor:
                      white, // Set the background color to white
                  textTheme: CupertinoTextThemeData(
                    textStyle:
                        TextStyle(color: black), // Set text color to black
                  ),
                ),
                child: CupertinoAlertDialog(
                  title: Text(
                    isVideo == true ? "Video" : "Photo",
                    style: TextStyle(
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? 18
                          : 10.sp,
                      color: isDarkMode() ? white : black,
                      fontFamily: fontBold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Text(
                    isVideo == true ? "Upload Video From" : "Upload Photo From",
                    style: TextStyle(
                      fontSize:
                          SizerUtil.deviceType == DeviceType.mobile ? 13 : 8.sp,
                      color: isDarkMode() ? white : black,
                      fontFamily: fontMedium,
                    ),
                  ),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () {
                        cameraClick!();
                        Navigator.pop(context);
                      },
                      isDefaultAction: true,
                      isDestructiveAction: true,
                      child: Text(
                        "Camera",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: isDarkMode() ? white : black,
                            fontFamily: fontRegular,
                            fontSize: SizerUtil.deviceType == DeviceType.mobile
                                ? 13.sp
                                : 8.sp),
                      ),
                    ),
                    CupertinoDialogAction(
                      onPressed: () {
                        galleryClick!();
                        Navigator.pop(context);
                      },
                      isDefaultAction: true,
                      isDestructiveAction: true,
                      child: Text(
                        "Gallery",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: isDarkMode() ? white : black,
                            fontFamily: fontRegular,
                            fontSize: SizerUtil.deviceType == DeviceType.mobile
                                ? 13.sp
                                : 8.sp),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      });
}
