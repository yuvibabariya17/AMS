import 'package:booking_app/Screens/PreviousNotificationScreen.dart';
import 'package:booking_app/Screens/UpcomingNotificationScreen.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/notification_screen_controller.dart';
import '../../core/Common/Common.dart';
import '../../core/Common/appbar.dart';
import '../../core/Common/toolbar.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/strings.dart';
import '../../core/themes/font_constant.dart';
import '../../custom_componannt/common_views.dart';
import '../../dialogs/bottomsheetdialog.dart';

// ignore: must_be_immutable
class NotificationScreen extends StatefulWidget {
  NotificationScreen(this.icon, this.leading, {super.key});

  var icon;
  var leading;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with TickerProviderStateMixin {
  var controller = Get.put(NotificationScreenController());
  var upcomingNotificationScreen = UpcomingNotificationScreen();
  var previousNotificationScreen = PreviousNotificationScreen();

  @override
  void initState() {
    controller.tabController =
        TabController(vsync: this, length: 2, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Common().trasparent_statusbar();
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        minimum: EdgeInsets.only(top: 1.h),
        child: Stack(children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: isDarkMode()
                ? SvgPicture.asset(
                    Asset.dark_bg,
                    fit: BoxFit.cover,
                  )
                : SvgPicture.asset(
                    Asset.bg,
                    fit: BoxFit.cover,
                  ),
          ),
          Container(
              margin: EdgeInsets.only(
                top: 0.5.h,
              ),
              child: Center(
                  child: Column(children: [
                // getToolbar("Notifications", showBackButton: true, callback: () {
                //   Get.back();
                // })
                HomeAppBar(
                  title: 'Notifications',
                  leading: Asset.backbutton,
                  isfilter: false,
                  icon: Asset.filter,
                  isBack: true,
                  onClick: () {
                    showbottomsheetdialog(context);
                  },
                ),
              ]))),
          Container(
            margin: EdgeInsets.only(top: 4.h),
            child: getListViewItem(),
          ),
        ]),
      ),
    );
  }

  getListViewItem() {
    return DefaultTabController(
        length: 2,
        child: Column(children: [
          getPaddingFromStatusBar(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getTab(Strings.upcoming_title, 30, 0),
              getTab(Strings.previous_title, 30, 1),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 2.h, top: 2.h, left: 3.5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'March 22,2023',
                  style: TextStyle(
                      color: isDarkMode() ? white : black,
                      fontSize: 14.sp,
                      fontFamily: opensansMedium,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: controller.tabController,
                children: [
                  upcomingNotificationScreen,
                  previousNotificationScreen
                ]),
          ),
        ]));
  }

  getTab(str, pad, index) {
    return Obx(
      () {
        return Bounce(
          duration: Duration(milliseconds: 200),
          onPressed: (() {
            controller.currentPage.value = index;
            if (controller.tabController.indexIsChanging == false) {
              controller.tabController.index = index;
            }
          }),
          child: AnimatedContainer(
            width: 40.w,
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(
              horizontal: 3.5.w,
            ),
            padding: EdgeInsets.only(
                left: 5.w, right: 5.w, top: 1.3.h, bottom: 1.3.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: controller.currentPage.value == index
                    ? Colors.black
                    : Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 0.1,
                    color: Colors.black.withOpacity(.1),
                  )
                ],
                borderRadius: BorderRadius.circular(50)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  str,
                  style: TextStyle(
                      fontSize: 12.5.sp,
                      fontFamily: opensans_Bold,
                      fontWeight: FontWeight.w700,
                      color: controller.currentPage.value == index
                          ? Colors.white
                          : Colors.grey[850]),
                ),
                SizedBox(
                  width: controller.currentPage.value == index ? 4.w : 0,
                ),
                controller.currentPage.value == index
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: controller.currentPage.value == index ||
                                  isDarkMode()
                              ? white
                              : black,
                        ),
                        padding: EdgeInsets.only(
                            left: 5, right: 5, top: 1, bottom: 1),
                        child: controller.currentPage.value == index
                            ? Text("6",
                                style: TextStyle(
                                  fontSize: 12.5.sp,
                                  color: isDarkMode() ? black : null,
                                ))
                            : null,
                      )
                    : Container()
              ],
            ),
          ),
        );
      },
    );
  }
}
