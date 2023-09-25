import 'package:booking_app/Screens/BasicProfileTab.dart';
import 'package:booking_app/Screens/ServicebasedProfileTab.dart';
import 'package:booking_app/Screens/StaffProfileTab.dart';
import 'package:booking_app/controllers/ProfileController.dart';
import 'package:booking_app/controllers/home_screen_controller.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../core/Common/Common.dart';
import '../core/Common/toolbar.dart';
import '../core/constants/assets.dart';
import '../core/utils/helper.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key, this.callBack});
  Function? callBack;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  final controller = Get.put(ProfileController());

  @override
  void initState() {
    controller.tabController =
        TabController(vsync: this, length: 3, initialIndex: 0);

    //  controller.isDarkModes = getStorage.read(GetStorageKey.IS_DARK_MODE) ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Common().trasparent_statusbar();
    return WillPopScope(
      onWillPop: () async {
        if (widget.callBack != null) {
          widget.callBack!(0);
        } else {
          Get.back();
        }
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            margin: EdgeInsets.only(left: 1.5.w, right: 1.5.w),
            child: Column(
              children: [
                Container(
                  color: isDarkMode() ? black : transparent,
                  child: Column(
                    children: [
                      Center(
                          child: Column(
                        children: [
                          getAppbar(
                            "Profile",
                          )
                        ],
                      )),
                      SizedBox(
                        height: 2.h,
                      ),
                      Center(
                        child: SvgPicture.asset(
                          Asset.profileimg,
                          height: 10.h,
                          color: isDarkMode() ? white : black,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        Get.find<HomeScreenController>().name.toString(),
                        style: TextStyle(
                            color: isDarkMode() ? white : black,
                            fontFamily: opensansMedium,
                            fontSize: 16.5.sp,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                getListViewItem()
              ],
            ),
          ),
        ),
      ),
    );
  }

  getListViewItem() {
    return Expanded(
      child: Container(
        color: isDarkMode() ? black : transparent,
        child: DefaultTabController(
            length: 3,
            child: Column(children: [
              SizedBox(
                height: 1.5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getTab("Basic", 30, 0),
                  getTab("Staff", 30, 1),
                  getTab("Service", 30, 2),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller.tabController,
                  children: [
                    BasicprofileTabScreen(),
                    StaffprofileTabScreen(),
                    ServiceProfileTabScreen()
                  ],
                ),
              ),
            ])),
      ),
    );
  }

  getTab(str, pad, index) {
    return Bounce(
      duration: Duration(milliseconds: 200),
      onPressed: (() {
        controller.currentPage = index;
        if (controller.tabController.indexIsChanging == false) {
          controller.tabController.index = index;
        }
        setState(() {});
      }),
      child: AnimatedContainer(
        width: 25.w,
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(
          horizontal: 8,
        ),
        padding: EdgeInsets.only(top: 11, bottom: 11),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color:
                controller.currentPage == index || isDarkMode() ? white : black,
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
            Text(str,
                style: TextStyle(
                  fontSize: 12.2.sp,
                  fontFamily: opensans_Bold,
                  fontWeight: FontWeight.w700,
                  color: controller.currentPage == index || isDarkMode()
                      ? black
                      : white,
                )),
          ],
        ),
      ),
    );
  }
}
