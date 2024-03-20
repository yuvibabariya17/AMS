import 'package:booking_app/controllers/notification_screen_controller.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Models/notification_Static.dart';
import '../../../core/constants/assets.dart';
import '../../../core/themes/font_constant.dart';
import '../../core/utils/helper.dart';

class PreviousNotificationScreen extends StatefulWidget {
  const PreviousNotificationScreen({super.key});

  @override
  State<PreviousNotificationScreen> createState() =>
      _PreviousNotificationScreenState();
}

class _PreviousNotificationScreenState
    extends State<PreviousNotificationScreen> {
  var controller = Get.put(NotificationScreenController());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: false,
      physics: BouncingScrollPhysics(),
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.only(bottom: 5.h, top: 1.h),
      itemBuilder: (context, index) {
        return getListItem(context, index);
      },
      itemCount: controller.staticData.length,
    );
  }

  getListItem(BuildContext context, int index) {
    NotificationItem data = controller.staticData[index];
    return Container(
      margin: EdgeInsets.only(
          top: SizerUtil.deviceType == DeviceType.mobile ? 1.h : 2.h,
          left: SizerUtil.deviceType == DeviceType.mobile ? 7.w : 10.w,
          right: SizerUtil.deviceType == DeviceType.mobile ? 7.w : 10.w,
          bottom: 1.h),
      decoration: BoxDecoration(
        color: isDarkMode() ? black : white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: isDarkMode()
                  ? Colors.white.withOpacity(0.2)
                  : Colors.black.withOpacity(0.2),
              spreadRadius: 0.1,
              blurRadius: 10,
              offset: Offset(0.5, 0.5)),
        ],
      ),
      padding: EdgeInsets.only(top: 2.h, left: 4.w, right: 4.w, bottom: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(children: [
                CircleAvatar(
                  radius: 3.7.h,
                  backgroundColor: isDarkMode() ? black : white,
                  child: SvgPicture.asset(
                    Asset.profileimg,
                    fit: BoxFit.cover,
                    color: isDarkMode() ? white : black,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: controller.isOnline
                      ? Container(
                          width: 2.h,
                          height: 2.h,
                          decoration: BoxDecoration(
                            color: data.Status == "Completed"
                                ? Colors.green
                                : data.Status == 'Pending'
                                    ? Colors.orange
                                    : Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        )
                      : SizedBox(),
                )
              ]),
              SizedBox(width: 5.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            data.Name,
                            style: TextStyle(
                                color: isDarkMode() ? white : black,
                                fontFamily: opensansMedium,
                                fontSize:
                                    SizerUtil.deviceType == DeviceType.mobile
                                        ? 12.sp
                                        : 8.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Spacer(),
                        Text(
                          data.Status,
                          style: TextStyle(
                              color: data.Status == "Completed"
                                  ? Colors.green
                                  : data.Status == 'Pending'
                                      ? Colors.orange
                                      : Colors.red,
                              fontFamily: opensans_Regular,
                              fontSize:
                                  SizerUtil.deviceType == DeviceType.mobile
                                      ? 12.sp
                                      : 8.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Container(
                        child: Text(
                      data.title,
                      style: TextStyle(
                          color: isDarkMode() ? white : black,
                          fontFamily: opensansMedium,
                          fontSize: SizerUtil.deviceType == DeviceType.mobile
                              ? 12.sp
                              : 8.sp,
                          fontWeight: FontWeight.w400),
                    )),
                    Text(
                      data.time,
                      style: TextStyle(
                          color: isDarkMode() ? white : black,
                          fontFamily: opensansMedium,
                          fontSize: SizerUtil.deviceType == DeviceType.mobile
                              ? 12.sp
                              : 8.sp,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
