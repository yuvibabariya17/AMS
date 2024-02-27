import 'package:booking_app/Screens/Profile/BasicProfileTab.dart';
import 'package:booking_app/Screens/Profile/ServicebasedProfileTab.dart';
import 'package:booking_app/Screens/Profile/StaffProfileTab.dart';
import 'package:booking_app/controllers/ProfileController.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/preference/UserPreference.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/Common/Common.dart';
import '../../core/Common/toolbar.dart';
import '../../core/constants/assets.dart';
import '../../core/utils/helper.dart';
import '../../models/SignInModel.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    super.key,
    this.callBack,
    required this.isfromNav,
  });
  Function? callBack;
  bool isfromNav;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  final controller = Get.put(ProfileController());
  String name = '';
  String number = '';
  int selectedTabIndex = 0;

  @override
  void initState() {
    controller.tabController =
        TabController(vsync: this, length: 3, initialIndex: selectedTabIndex);
    initDataSet(context);

    //  controller.isDarkModes = getStorage.read(GetStorageKey.IS_DARK_MODE) ?? 1;
    super.initState();
  }

  void initDataset(BuildContext context) async {
    SignInData? retrievedObject = await UserPreferences().getSignInInfo();

    controller.profilePic.value =
        "http://192.168.1.7.4000/uploads/${retrievedObject!.profilePic}";
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
          backgroundColor: transparent,
          body: Container(
            margin: EdgeInsets.only(left: 1.5.w, right: 1.5.w, top: 1.h),
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Center(
                          child: Column(
                        children: [
                          widget.isfromNav
                              ? getCommonToolbar(ScreenTitle.profile, () {
                                  Get.back();
                                })
                              : getAppbar(
                                  ScreenTitle.profile,
                                )
                        ],
                      )),
                      SizedBox(
                        height: 2.h,
                      ),
                      Center(
                          child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: controller.profilePic.value,
                        placeholder: (context, url) => SvgPicture.asset(
                          Asset.profileimg,
                          height: 8.h,
                          color: isDarkMode() ? white : black,
                          fit: BoxFit.cover,
                        ),
                        errorWidget: (context, url, error) => SvgPicture.asset(
                          Asset.profileimg,
                          height: 8.h,
                          color: isDarkMode() ? white : black,
                          fit: BoxFit.cover,
                        ),
                      )

                          // SvgPicture.asset(
                          //   Asset.profileimg,
                          //   height: 10.h,
                          //   color: isDarkMode() ? white : black,
                          // ),
                          ),
                      SizedBox(height: 1.h),
                      Text(
                        name.toString(),
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
        //color: isDarkMode() ? black : transparent,
        child: DefaultTabController(
            length: 3,
            child: Column(children: [
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getTab(ScreenTitle.basic, 30, 0),
                  getTab(ScreenTitle.staff, 30, 1),
                  getTab(ScreenTitle.service, 30, 2),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller.tabController,
                  children: [
                    BasicprofileTabScreen(callBack: callback),
                    StaffprofileTabScreen(),
                    ServiceProfileTabScreen()
                  ],
                ),
              ),
            ])),
      ),
    );
  }

  callback() {
    initDataSet(context);
  }

  getTab(str, pad, index) {
    return Bounce(
      duration: Duration(milliseconds: 200),
      onPressed: (() {
        controller.currentPage = index;
        selectedTabIndex = index;
        controller.tabController.index = index;
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
            color: selectedTabIndex == index
                ? black
                : isDarkMode()
                    ? Colors.white
                    : Colors.white,
            border: Border.all(
                color: isDarkMode() ? Colors.white : Colors.transparent),
            boxShadow: [
              BoxShadow(
                  color: isDarkMode()
                      ? Colors.white.withOpacity(0.2)
                      : Colors.black.withOpacity(0.2),
                  spreadRadius: 0.1,
                  blurRadius: 10,
                  offset: Offset(0.5, 0.5)),
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
                  color: selectedTabIndex == index
                      ? white
                      : isDarkMode()
                          ? black
                          : black,
                )),
          ],
        ),
      ),
    );
  }

  void initDataSet(BuildContext context) async {
    SignInData? retrievedObject = await UserPreferences().getSignInInfo();
    name = retrievedObject!.userName.toString();
    setState(() {});
  }
}
