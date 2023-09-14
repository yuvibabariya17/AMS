import 'package:booking_app/Screens/HomeScreen.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import '../Models/Staff_model.dart';
import '../Models/service.dart';
import '../Models/service_model.dart';
import '../Models/staff.dart';
import '../core/Common/Common.dart';
import '../core/Common/appbar.dart';
import '../core/Common/toolbar.dart';
import '../core/constants/assets.dart';
import '../core/constants/get_storage_key.dart';
import '../core/constants/strings.dart';
import '../core/utils/helper.dart';
import 'UpdateVendor.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  List<ServiceItem> staticData = SettingsItems;
  List<StaffItem> staticData1 = StaffItems;
  var currentPage = 0;
  bool state = false;
  int isDarkModes = 0;
  final getStorage = GetStorage();

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 3, initialIndex: 0);
    isDarkModes = getStorage.read(GetStorageKey.IS_DARK_MODE) ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Common().trasparent_statusbar();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: isDarkMode() ? black : white,
        body: SafeArea(
          minimum: EdgeInsets.only(top: 1.h),
          child: Stack(children: [
            isDarkMode()
                ? SvgPicture.asset(
                    Asset.dark_bg,
                    fit: BoxFit.cover,
                  )
                : SvgPicture.asset(
                    Asset.bg,
                    fit: BoxFit.cover,
                  ),
            Container(
              color: isDarkMode() ? black : white,
              child: Column(
                children: [
                  Center(
                      child: Column(
                    children: [
                      getToolbar("Profile", showBackButton: true, notify: false,
                          callback: () {
                        Get.back();
                      })

                      // HomeAppBar(
                      //   title: Strings.profile,
                      //   leading: Asset.backbutton,
                      //   isfilter: false,
                      //   icon: Asset.filter,
                      //   isBack: true,
                      //   onClick: () {
                      //     Get.put(HomeScreen());
                      //   },
                      // ),
                    ],
                  )),
                  SizedBox(
                    height: 2.h,
                  ),
                  // Container(
                  //   child: CupertinoSwitch(
                  //     value: state,
                  //     onChanged: (value) async {
                  //       state = value;
                  //       setState(() {
                  //         isDarkMode = isDarkMode == 0 ? 1 : 0;
                  //       });
                  //       var switchOn;
                  //       if (value == true) {
                  //         switchOn = 1;
                  //       } else {
                  //         switchOn = 0;
                  //       }
                  //       await getStorage.write(
                  //           GetStorageKey.IS_DARK_MODE, isDarkMode);
                  //       //setState(() {});
                  //       Get.find<ThemeController>().updateState(isDarkMode);
                  //       Get.find<ThemeController>().update();
                  //       setState(
                  //         () {},
                  //       );
                  //     },
                  //     thumbColor: CupertinoColors.white,
                  //     activeColor: CupertinoColors.black,
                  //     trackColor: Colors.grey,
                  //   ),
                  // ),
                  Center(
                    child: SvgPicture.asset(
                      Asset.profileimg,
                      height: 10.h,
                      color: isDarkMode() ? white : black,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    Strings.name,
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
          ]),
        ));
  }

  getListViewItem() {
    return Container(
      color: isDarkMode() ? black : white,
      margin: EdgeInsets.only(top: 26.h),
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
                controller: tabController,
                children: [
                  Container(
                      child: Container(
                    margin: EdgeInsets.only(
                        top: 5.h, left: 8.w, right: 8.w, bottom: 1.h),
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 1.5.h, left: 6.w, right: 4.w, bottom: 1.5.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                Strings.vendor_type,
                                style: TextStyle(
                                    fontFamily: opensansMedium,
                                    fontWeight: FontWeight.w400,
                                    color: isDarkMode() ? Colors.grey : black,
                                    fontSize: 13.5.sp),
                              ),
                              IconButton(
                                  alignment: Alignment.topRight,
                                  onPressed: () {
                                    Get.to(UpdateVendor());
                                  },
                                  icon: SvgPicture.asset(Asset.edit,
                                      color: isDarkMode() ? white : black))
                            ],
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            Strings.abc,
                            style: TextStyle(
                                color: isDarkMode() ? white : black,
                                fontFamily: opensansMedium,
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            Strings.company_name,
                            style: TextStyle(
                                fontFamily: opensansMedium,
                                fontWeight: FontWeight.w400,
                                color: isDarkMode() ? Colors.grey : black,
                                fontSize: 13.5.sp),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            Strings.company_name_hint,
                            style: TextStyle(
                                color: isDarkMode() ? white : black,
                                fontFamily: opensansMedium,
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            Strings.address,
                            style: TextStyle(
                                fontFamily: opensansMedium,
                                fontWeight: FontWeight.w400,
                                color: isDarkMode() ? Colors.grey : black,
                                fontSize: 13.5.sp),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            Strings.address_hint,
                            style: TextStyle(
                                color: isDarkMode() ? white : black,
                                fontFamily: opensansMedium,
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            Strings.contact_one,
                            style: TextStyle(
                                fontFamily: opensansMedium,
                                fontWeight: FontWeight.w400,
                                color: isDarkMode() ? Colors.grey : black,
                                fontSize: 13.5.sp),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            Strings.contact_one_hint,
                            style: TextStyle(
                                color: isDarkMode() ? white : black,
                                fontFamily: opensansMedium,
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            Strings.contact_two,
                            style: TextStyle(
                                fontFamily: opensansMedium,
                                fontWeight: FontWeight.w400,
                                color: isDarkMode() ? Colors.grey : black,
                                fontSize: 13.5.sp),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            Strings.contact_two_hint,
                            style: TextStyle(
                                color: isDarkMode() ? white : black,
                                fontFamily: opensansMedium,
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: isDarkMode() ? black : white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 0.1,
                              blurRadius: 10,
                              offset: Offset(0.5, 0.5)),
                        ],
                      ),
                    ),
                  )),
                  Container(
                    margin: EdgeInsets.only(top: 3.h),
                    child: ListView.builder(
                        shrinkWrap: false,
                        clipBehavior: Clip.antiAlias,
                        itemBuilder: (context, index) {
                          StaffItem data = staticData1[index];
                          return Container(
                            margin: EdgeInsets.only(
                                top: 1.5.h,
                                left: 8.w,
                                right: 8.w,
                                bottom: 1.5.h),
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 1.5.h,
                                  left: 4.w,
                                  right: 4.w,
                                  bottom: 1.5.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Stack(children: [
                                        CircleAvatar(
                                          radius: 3.7.h,
                                          backgroundColor: Colors.white,
                                          child: SvgPicture.asset(
                                            Asset.profileimg,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ]),
                                      SizedBox(width: 3.w),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Text(
                                              data.title,
                                              style: TextStyle(
                                                  fontFamily: opensansMedium,
                                                  fontSize: 15.5.sp,
                                                  fontWeight: FontWeight.w700),
                                            )),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Text(
                                              data.number,
                                              style: TextStyle(
                                                  fontFamily: opensansMedium,
                                                  fontSize: 11.sp,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 0.1,
                                      blurRadius: 10,
                                      offset: Offset(0.5, 0.5)),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: staticData1.length),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3.h),
                    child: ListView.builder(
                        shrinkWrap: false,
                        clipBehavior: Clip.antiAlias,
                        itemBuilder: (context, index) {
                          ServiceItem data = staticData[index];
                          return Container(
                            margin: EdgeInsets.only(
                                top: 1.5.h, left: 8.w, right: 8.w, bottom: 1.h),
                            child: InkWell(
                              onTap: () {
                                Common.PopupDialogs(context);
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 1.5.h,
                                    left: 4.w,
                                    right: 4.w,
                                    bottom: 1.5.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: data.icon,
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Container(
                                          child: Text(
                                            data.Name,
                                            style: TextStyle(
                                                fontFamily: opensansMedium,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0.1,
                                        blurRadius: 10,
                                        offset: Offset(0.5, 0.5)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: staticData.length),
                  ),
                ],
              ),
            ),
          ])),
    );
  }

  getTab(str, pad, index) {
    return Bounce(
      duration: Duration(milliseconds: 200),
      onPressed: (() {
        currentPage = index;
        if (tabController.indexIsChanging == false) {
          tabController.index = index;
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
            color: currentPage == index || isDarkMode() ? white : black,
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
                  color: currentPage == index || isDarkMode() ? black : white,
                )),
          ],
        ),
      ),
    );
  }
}
