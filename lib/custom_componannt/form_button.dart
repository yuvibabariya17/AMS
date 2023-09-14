import 'package:booking_app/core/themes/color_const.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../core/themes/font_constant.dart';

getFormButton(Function fun, str, {required bool isvalidate}) {
  return InkWell(
    onTap: () {
      fun();
    },
    child: Container(
      padding: EdgeInsets.symmetric(
          vertical: SizerUtil.deviceType == DeviceType.mobile ? 1.2.h : 1.h,
          horizontal: SizerUtil.deviceType == DeviceType.mobile ? 7.h : 6.h),
      //width: SizerUtil.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.7.h),
          // color: validate ? lightPrimaryColor : Colors.grey,
          boxShadow: [
            BoxShadow(
                color:
                    isvalidate == true ? black : Colors.grey.withOpacity(0.2),
                blurRadius: 10.0,
                offset: const Offset(0, 1),
                spreadRadius: 3.0)
          ],
          gradient: LinearGradient(
              colors: isvalidate == true
                  ? [primaryColor, primaryColor.withOpacity(0.5)]
                  : [Colors.grey, Colors.grey],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp)),
      child: Text(
        str,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontFamily: fontBold, fontSize: 14.sp),
      ),
    ),
  );
}

getFormButtonForAddingData(Function fun, str, {required bool isvalidate}) {
  return InkWell(
    onTap: () {
      fun();
    },
    child: Container(
      height: 13.w,
      padding: EdgeInsets.symmetric(
          vertical: SizerUtil.deviceType == DeviceType.mobile ? 1.2.h : 1.h,
          horizontal: SizerUtil.deviceType == DeviceType.mobile ? 7.h : 6.h),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
      //width: SizerUtil.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.7.h),
          // color: validate ? lightPrimaryColor : Colors.grey,
          boxShadow: [
            BoxShadow(
                color: isvalidate == true
                    ? primaryColor.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.2),
                blurRadius: 10.0,
                offset: const Offset(0, 1),
                spreadRadius: 3.0)
          ],
          gradient: LinearGradient(
              colors: isvalidate == true
                  ? [primaryColor, primaryColor.withOpacity(0.5)]
                  : [Colors.grey, Colors.grey],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp)),
      child: Text(
        str,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontFamily: fontBold, fontSize: 14.sp),
      ),
    ),
  );
}

getVerifyOtpButton(Function fun, str, {required bool validate}) {
  return InkWell(
    onTap: () {
      fun();
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 7.h),
      //width: SizerUtil.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.7.h),
          // color: validate ? lightPrimaryColor : Colors.grey,
          boxShadow: [
            BoxShadow(
                color: validate
                    ? primaryColor.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.2),
                blurRadius: 10.0,
                offset: const Offset(0, 1),
                spreadRadius: 3.0)
          ],
          gradient: LinearGradient(
              colors: validate
                  ? [primaryColor, primaryColor.withOpacity(0.5)]
                  : [primaryColor, primaryColor.withOpacity(0.5)],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp)),
      child: Text(
        str,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontFamily: fontBold, fontSize: 14.sp),
      ),
    ),
  );
}

getViewProfileButton(Function fun, str, {bool? isvalidate}) {
  return InkWell(
    onTap: () {
      fun();
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.h),
      //width: SizerUtil.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.7.h),
          // color: validate ? lightPrimaryColor : Colors.grey,
          boxShadow: [
            BoxShadow(
                color: primaryColor.withOpacity(0.5),
                blurRadius: 1.0,
                offset: const Offset(0, 1),
                spreadRadius: 1.0)
          ],
          gradient: LinearGradient(
              colors: [primaryColor, primaryColor.withOpacity(0.5)],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp)),
      child: Text(
        str,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontFamily: fontBold, fontSize: 11.2.sp),
      ),
    ),
  );
}

getButton(str, Function fun, {required bool isvalidate}) {
  return InkWell(
    onTap: () {
      fun();
    },
    child: Container(
      height: SizerUtil.deviceType == DeviceType.mobile ? 13.w : 6.h,
      alignment: Alignment.center,
      padding: EdgeInsets.only(
          top: SizerUtil.deviceType == DeviceType.mobile ? 5 : 2),
      width: SizerUtil.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.7.h),
          boxShadow: [
            BoxShadow(
                color: isvalidate == true
                    ? primaryColor.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.2),
                blurRadius: 10.0,
                offset: const Offset(0, 1),
                spreadRadius: 3.0)
          ],
          gradient: LinearGradient(
              colors: isvalidate == true
                  ? [primaryColor, primaryColor.withOpacity(0.5)]
                  : [Colors.grey, Colors.grey],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp)),
      child: Text(
        "Search",
        style: TextStyle(
            color: Colors.white, fontFamily: fontBold, fontSize: 14.sp),
      ),
    ),
  );
}

commonBtn(str, Function fun, {required bool isvalidate}) {
  return InkWell(
    onTap: () {
      fun();
    },
    child: Container(
      height: SizerUtil.deviceType == DeviceType.mobile ? 13.w : 6.h,
      alignment: Alignment.center,
      padding: EdgeInsets.only(
          top: SizerUtil.deviceType == DeviceType.mobile ? 5 : 2),
      width: SizerUtil.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.7.h),
          boxShadow: [
            BoxShadow(
                color: isvalidate == true
                    ? primaryColor.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.2),
                blurRadius: 10.0,
                offset: const Offset(0, 1),
                spreadRadius: 3.0)
          ],
          gradient: LinearGradient(
              colors: isvalidate == true
                  ? [primaryColor, primaryColor.withOpacity(0.5)]
                  : [Colors.grey, Colors.grey],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp)),
      child: Text(
        str,
        style: TextStyle(
            color: Colors.white, fontFamily: fontBold, fontSize: 14.sp),
      ),
    ),
  );
}
