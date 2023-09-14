import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'dart:io' show Platform;

import '../controllers/AppointmentBooking_controller.dart';
import '../core/constants/assets.dart';
import '../core/constants/strings.dart';
import '../core/themes/color_const.dart';
import '../core/themes/font_constant.dart';
import '../core/utils/helper.dart';

bool Click = true;
bool White = true;
bool Black = true;

Widget getScreenBackground(context) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Theme.of(context).colorScheme.background.withOpacity(0.05),
          Theme.of(context).colorScheme.background.withOpacity(0.01),
        ],
        stops: const [0.0, 1.0],
      ),
    ),
    width: SizerUtil.width,
  );
}

Widget getText(contex, String title, String str) {
  return Column(
    children: [
      Row(
        children: [
          Text(
            ('${title}'),
            maxLines: 1,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontFamily: fontSemiBold,
                color: isDarkMode() ? labelTextColor : Colors.white,
                fontSize:
                    SizerUtil.deviceType == DeviceType.mobile ? 8.0.sp : 6.sp,
                overflow: TextOverflow.ellipsis),
          ),
          Flexible(
            child: Text(
              ('${str}'),
              maxLines: 1,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: fontSemiBold,
                  color: isDarkMode() ? labelTextColor : Colors.white,
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 7.0.sp : 6.sp,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          SizedBox(
            height: 1.5.h,
          )
        ],
      ),
    ],
  );
}

getTitle(String title) {
  return Column(
    children: [
      Text(
        title,
        style: TextStyle(
            fontFamily: opensans_Bold,
            fontSize: SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 13.sp,
            fontWeight: FontWeight.w700),
      ),
      SizedBox(
        height: 0.5.h,
      ),
    ],
  );
}

getTime(String time, AppointmentBookingController controler) {
  return Row(
    children: [
      InkWell(
        onTap: () {
          controler.isClickd.value = !controler.isClickd.value;
          //controler.setOnClick(controler.isClickd.value);
          print("ISCLICK::::${controler.isClickd.value}");
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 5.h,
          width: 25.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: controler.isClickd.value ? Colors.black : Colors.grey),
          child: Center(
            child: Text(
              time,
              style: TextStyle(
                  fontFamily: opensans_Bold,
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 13.sp,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 0.5.h,
      ),
    ],
  );

  // return Row(
  //   children: [
  //     InkWell(
  //       onTap: () {
  //         isClick = !isClick;
  //       },
  //       child: AnimatedContainer(
  //         duration: const Duration(milliseconds: 300),
  //         height: 5.h,
  //         width: 25.w,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(20),
  //             color: isClick ? Colors.black : Colors.grey),
  //         child: Center(
  //           child: Text(
  //             time,
  //             style: TextStyle(
  //                 fontFamily: opensans_Bold,
  //                 fontSize:
  //                     SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 13.sp,
  //                 fontWeight: FontWeight.w700),
  //           ),
  //         ),
  //       ),
  //     ),
  //     SizedBox(
  //       height: 0.5.h,
  //     ),
  //   ],
  // );
}

getTopBackground(context) {
  return SvgPicture.asset(Asset.add_service,
      height: 20.h, width: 20.h, color: isDarkMode() ? null : Colors.white);
}

getBottomBackground(context) {
  return SvgPicture.asset(Asset.ams_logo,
      height: 9.h, width: 9.h, color: isDarkMode() ? null : Colors.white);
}

getButton(
  Function fun,
) {
  return FadeInUp(
    child: ElevatedButton(
        onPressed: () {
          fun();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        child: Text(
          Strings.submit,
          style: TextStyle(
              color: Colors.white,
              fontSize: 14.5.sp,
              fontFamily: opensans_Bold,
              fontWeight: FontWeight.w700),
        )),
  );
}

getMiniButton(
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
      width: SizerUtil.width / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: lightPrimaryColor,
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
            fontSize: SizerUtil.deviceType == DeviceType.mobile ? 11.sp : 8.sp),
      ),
    ),
  );
}

getFormButton(Function fun, str, {required bool validate}) {
  return InkWell(
    onTap: () {
      fun();
    },
    child: Container(
      height: SizerUtil.deviceType == DeviceType.mobile ? 6.h : 5.9.h,
      alignment: Alignment.center,
      //  padding: EdgeInsets.only(top: 1.h),
      width: SizerUtil.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            SizerUtil.deviceType == DeviceType.mobile ? 5.h : 1.4.h),
        color: validate ? black : Colors.grey,
        boxShadow: [
          BoxShadow(
              color: validate
                  ? primaryColor.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.2),
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
            fontSize: SizerUtil.deviceType == DeviceType.mobile ? 14.sp : 8.sp),
      ),
    ),
  );
}

getPaddingFromStatusBar() {
  return SizedBox(
    height: Platform.isAndroid ? 3.5.h : 0,
  );
}

getBackNav(Function fun) {
  return GestureDetector(
    onTap: () {
      fun();
    },
    child: Container(
      margin: EdgeInsets.only(left: 4.w),
      padding: const EdgeInsets.all(10),
      child: Icon(
        Icons.arrow_back,
        size: SizerUtil.deviceType == DeviceType.mobile ? 6.w : 5.w,
      ),
    ),
  );
}
