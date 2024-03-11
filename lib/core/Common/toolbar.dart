import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Screens/LoginScreen/LoginScreen.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../preference/UserPreference.dart';
import '../constants/assets.dart';
import '../themes/color_const.dart';
import '../themes/font_constant.dart';

getToolbar(title,
    {bool showBackButton = true,
    Function? callback,
    bool logo = true,
    Function? islogo,
    bool notify = true,
    Function? isNotify}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Expanded(
        child: Row(
          children: [
            if (showBackButton) iosBackPress(callback),
          ],
        ),
      ),
      Expanded(
        flex: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              child: Text(
                title,
                style: TextStyle(
                    fontFamily: fontBold,
                    color: isDarkMode() ? white : headingTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp),
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: Row(
          children: [
            if (notify) notification(isNotify),
          ],
        ),
      ),
    ],
  );
}

getImageToolbar(
  String? title, {
  Function? callback,
}) {
  return Stack(
    children: [
      Positioned(
        left: 0,
        top: 0,
        child: FadeInDown(
          child: Container(
            margin: EdgeInsets.only(
                left: SizerUtil.deviceType == DeviceType.mobile ? 3.w : 5.w),
            child: GestureDetector(
              onTap: () {
                callback!();
              },
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    Asset.arrowBack,
                    height:
                        SizerUtil.deviceType == DeviceType.mobile ? 4.h : 5.h,
                    color: white,
                  )),
            ),
          ),
        ),
      ),
      // Positioned(
      //   top: 0,
      //   right: 0,
      //   child: FadeInDown(
      //           child: Text(
      //             title!,
      //             style: TextStyle(
      //                 fontFamily: fontBold,
      //                 color: white,
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 18.sp),
      //           ),
      //         ),)
    ],
  );
}

getImage(title, {bool showBackButton = true, Function? callback}) {
  return Row(
    children: [
      Container(
        margin: EdgeInsets.only(
            left: SizerUtil.deviceType == DeviceType.mobile ? 1.w : 2.w),
        child: GestureDetector(
          onTap: () {
            callback!();
          },
          child: Container(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                Asset.arrowBack,
                height: SizerUtil.deviceType == DeviceType.mobile ? 4.h : 5.h,
                color: white,
              )),
        ),
      ),
      Expanded(
        flex: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInDown(
              child: Container(
                margin: EdgeInsets.only(right: 15.w),
                child: Text(
                  title,
                  style: TextStyle(
                      fontFamily: fontBold,
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

bool isSmallDevice(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  // Retrieve the screen height
  final screenHeight = mediaQuery.size.height;
  // Define the threshold height below which the device is considered small
  const smallDeviceHeightThreshold = 700.0;
  // Check if the device is small based on the screen height
  return screenHeight < smallDeviceHeightThreshold;
}

getSizedBox() {
  return SizedBox(
    height: 1.7.h,
  );
}

// checkInternet() {
//   return Scaffold(
//       body: SizedBox(
//     child: Center(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             Asset.noInternet,
//             height: 20.h,
//           ),
//           SizedBox(
//             height: 2.h,
//           ),
//           Text(
//             textAlign: TextAlign.center,
//             "Please Check Your\nInternet Connection.",
//             style: TextStyle(
//               color: Colors.red,
//               fontFamily: fontBold,
//               fontSize: 18.sp,
//             ),
//           ),
//         ],
//       ),
//     ),
//   ));
// }

getSizedBoxForDropDown() {
  return SizedBox(
    height: 0.90.h,
  );
}

getCommonToolbar(title, Function? callback) {
  return Row(
    children: [
      commonBackPress(callback),
      Expanded(
        flex: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInDown(
              child: Container(
                margin: EdgeInsets.only(right: 15.w),
                child: Text(
                  title,
                  style: TextStyle(
                      fontFamily: fontBold,
                      color: isDarkMode() ? white : black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

getAppbar(
  title,
) {
  return Row(
    children: [
      Expanded(
        flex: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInDown(
              child: Container(
                //  margin: EdgeInsets.only(right: 15.w),
                child: Text(
                  title,
                  style: TextStyle(
                      fontFamily: fontBold,
                      color: isDarkMode() ? white : headingTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

checkInternet() {
  return Scaffold(
      body: SizedBox(
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Asset.noInternet,
            height: 20.h,
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            textAlign: TextAlign.center,
            "Please Check Your\nInternet Connection.",
            style: TextStyle(
              color: Colors.red,
              fontFamily: fontBold,
              fontSize: 18.sp,
            ),
          ),
        ],
      ),
    ),
  ));
}

getViewProfile(title, {bool showBackButton = true, Function? callback}) {
  return Row(
    children: [
      if (showBackButton) iosBackPress(callback),
      Expanded(
        flex: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInDown(
              child: Container(
                margin: EdgeInsets.only(right: 15.w),
                child: Text(
                  title,
                  style: TextStyle(
                      fontFamily: fontBold,
                      color: isDarkMode() ? white : headingTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 21.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

getdivider() {
  return Divider(
    height: 3.5.h,
    indent: 0.1.h,
    endIndent: 0.1.h,
    thickness: 1,
    color: primaryColor.withOpacity(0.5),
  );
}

getDividerForShowDialog() {
  return Divider(
    height: 0.5.h,
    indent: 0.1.h,
    endIndent: 0.1.h,
    thickness: 1,
    color: isDarkMode() ? white : primaryColor.withOpacity(0.5),
  );
}

Widget backPress(callback) {
  return FadeInDown(
    child: Container(
      margin: EdgeInsets.only(
          left: SizerUtil.deviceType == DeviceType.mobile ? 3.w : 2.3.w),
      child: GestureDetector(
        onTap: () {
          callback();
        },
        child: Container(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              Asset.arrowBack,
              height: SizerUtil.deviceType == DeviceType.mobile ? 4.h : 5.h,
            )),
      ),
    ),
  );
}

Widget iosBackPress(callback) {
  return FadeInDown(
    child: Container(
      margin: EdgeInsets.only(
          left: SizerUtil.deviceType == DeviceType.mobile ? 3.w : 5.w),
      child: GestureDetector(
        onTap: () {
          callback();
        },
        child: Container(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              Asset.arrowBack,
              height: SizerUtil.deviceType == DeviceType.mobile ? 4.h : 5.h,
            )),
      ),
    ),
  );
}

Widget commonBackPress(callback) {
  return Container(
    margin: EdgeInsets.only(
        left: SizerUtil.deviceType == DeviceType.mobile ? 5.5.w : 10.w),
    child: GestureDetector(
      onTap: () {
        print("CLICK");
        callback();
      },
      child: Container(
          padding: const EdgeInsets.all(2),
          child: SvgPicture.asset(
            Asset.arrowBack,
            color: isDarkMode() ? white : black,
            height: SizerUtil.deviceType == DeviceType.mobile ? 4.h : 5.h,
          )),
    ),
  );
}

Widget notification(isNotify) {
  return GestureDetector(
    onTap: () {
      isNotify();
    },
    child: Container(
      padding: EdgeInsets.only(left: 1.w, right: 0.3.w),
      margin: EdgeInsets.only(
          right: 2.w,
          left: SizerUtil.deviceType == DeviceType.mobile ? 9.w : 11.w),
      height: 3.5.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Icon(
        Icons.notifications_outlined,
        color: Colors.black,
        size: 3.5.h,
      ),
    ),
  );
}

Future<Object?> PopupDialogsforSignOut(BuildContext context) {
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
                  "Sign Out",
                  style: TextStyle(
                    fontSize: 18,
                    color: isDarkMode() ? white : white,
                    fontFamily: fontBold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Text(
                  "Are you sure to SignOut?",
                  style: TextStyle(
                    fontSize: 13,
                    color: isDarkMode() ? white : white,
                    fontFamily: fontMedium,
                  ),
                ),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    isDefaultAction: true,
                    isDestructiveAction: true,
                    child: Text("No",
                        style: TextStyle(
                          fontSize: 15,
                          color: isDarkMode() ? white : white,
                          fontFamily: fontBold,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                      UserPreferences().logout();
                      Get.offAll(LoginScreen());
                    },
                    isDefaultAction: true,
                    isDestructiveAction: true,
                    child: Text("Yes",
                        style: TextStyle(
                          fontSize: 15,
                          color: isDarkMode() ? white : white,
                          fontFamily: fontBold,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  // The "No" button
                ],
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
