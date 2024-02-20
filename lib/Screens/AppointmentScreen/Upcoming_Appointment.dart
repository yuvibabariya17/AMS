import 'package:booking_app/controllers/UpcomingAppointment_controller.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Models/notification_model.dart';
import '../../Models/product.dart';
import '../../core/Common/Common.dart';
import '../../core/constants/assets.dart';
import '../../core/themes/color_const.dart';
import '../../core/themes/font_constant.dart';

class UpcomingAppointment extends StatefulWidget {
  const UpcomingAppointment({super.key});

  @override
  State<UpcomingAppointment> createState() => _UpcomingAppointmentState();
}

class _UpcomingAppointmentState extends State<UpcomingAppointment> {
  var controller = Get.put(UpcomingAppointmentController());
  List<ProductItem> staticData = notificationItems;
  bool state = false;

  @override
  void initState() {
    controller.getAppointmentList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Common().trasparent_statusbar();
    return ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: false,
        clipBehavior: Clip.antiAlias,
        itemBuilder: (context, index) {
             ProductItem data = staticData[index];
       //   ListofAppointment data = controller.filteredExpertObjectList[index];
          return Container(
            margin:
                EdgeInsets.only(left: 7.w, right: 7.w, bottom: 1.h, top: 3.h),
            padding:
                EdgeInsets.only(top: 2.h, left: 4.w, right: 4.w, bottom: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                      'March 22,2023',
              //  data.customerInfo.contactNo,
                  style: TextStyle(
                    fontFamily: opensansMedium,
                    fontWeight: FontWeight.w700,
                    fontSize: 10.sp,
                    color: isDarkMode() ? white : black,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
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
                                //  data.customerInfo.name ,
                                  style: TextStyle(
                                      color: isDarkMode() ? white : black,
                                      fontFamily: opensansMedium,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          Container(
                              child: Text(
                                   data.title,
                                  //  data.customerInfo.email,
                            style: TextStyle(
                                color: isDarkMode() ? white : black,
                                fontFamily: opensansMedium,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      color: isDarkMode() ? white : black,
                      Asset.user,
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      'Ahn Hyeon Seop',
                      style: TextStyle(
                        color: isDarkMode() ? white : black,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // padding: EdgeInsets.only(left: 3.h),
                      child: CupertinoSwitch(
                        value: state,
                        onChanged: (value) {
                          state = value;
                          setState(
                            () {},
                          );
                        },
                        thumbColor: CupertinoColors.white,
                        activeColor: CupertinoColors.black,
                        trackColor: Colors.grey,
                      ),
                    ),
                    Text(
                      'Remind me',
                      style: TextStyle(
                        color: isDarkMode() ? white : black,
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: isDarkMode() ? white : black,
                        )),
                    Spacer(),
                    Container(
                      height: 4.h,
                      width: 20.w,
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: isDarkMode() ? black : white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: isDarkMode() ? white : black,
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
                    )
                  ],
                )
              ],
            ),
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
          );
        },
        itemCount: staticData.length);
       // itemCount: controller.filteredExpertObjectList.length,);
  }
}
