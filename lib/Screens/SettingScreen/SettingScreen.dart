import 'package:booking_app/Screens/DashboardScreen/DashboardScreen.dart';
import 'package:booking_app/Screens/SettingScreen/InviteFriendScreen.dart';
import 'package:booking_app/Screens/SettingScreen/ReportBugScreen.dart';
import 'package:booking_app/controllers/theme_controller.dart';
import 'package:booking_app/core/Common/Common.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import '../../Models/setting.dart';
import '../../Models/settings_model.dart';
import '../../core/Common/toolbar.dart';
import '../../core/Common/util.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/get_storage_key.dart';
import '../../core/constants/strings.dart';
import '../../core/utils/helper.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<SettingItem> staticData = SettingsItems;
  get index => null;
  int _isDarkMode = 0;
  final getStorage = GetStorage();

  bool state = false;

  @override
  Widget build(BuildContext context) {
    Common().trasparent_statusbar();
    return CustomScaffold(
        body: Container(
            margin: EdgeInsets.only(
              top: 1.h,
            ),
            child: Center(
                child: Column(children: [
              getCommonToolbar(ScreenTitle.settings, () {
                Get.offAll(dashboard());
              }),
              // HomeAppBar(
              //   title: Strings.settings,
              //   leading: Asset.backbutton,
              //   isfilter: false,
              //   icon: Asset.filter,
              //   isBack: true,
              //   onClick: () {},
              // ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                margin: EdgeInsets.only(left: 8.w, right: 8.w),
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    //PROFILE INFORMATION SCREEN

                    // settingRow(Asset.user, SettingConstant.profile_info, () {
                    //   Get.to(ProfileInformationScreen());
                    // }, Asset.rightbackbutton),
                    // dividerforSetting(),

                    settingRow(Asset.invite, SettingConstant.invite_frd, () {
                      Get.to(InviteFriendScreen());
                    }, Asset.rightbackbutton),
                    dividerforSetting(),
                    Row(
                      children: [
                        SvgPicture.asset(
                          Asset.moon,
                          color: isDarkMode() ? white : black,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.5.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                SettingConstant.change_theme,
                                style: TextStyle(
                                  fontFamily: opensansMedium,
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 20.w,
                          height: 1.h,
                          // margin: const EdgeInsets.only(
                          //     right: 16.0), // Adjust right margin as needed
                          child: CupertinoSwitch(
                            value: isDarkMode() ? true : false,
                            onChanged: (value) async {
                              print("Switch Click");
                              state = value;
                              setState(() {
                                _isDarkMode = _isDarkMode == 0 ? 1 : 0;
                              });
                              await getStorage.write(
                                  GetStorageKey.IS_DARK_MODE, _isDarkMode);
                              Get.find<ThemeController>()
                                  .updateState(_isDarkMode);
                              Get.find<ThemeController>().update();
                              print(
                                  getStorage.read(GetStorageKey.IS_DARK_MODE));
                              setState(() {});
                            },
                            thumbColor: isDarkMode()
                                ? CupertinoColors.black
                                : CupertinoColors.white,
                            activeColor: isDarkMode()
                                ? CupertinoColors.white
                                : CupertinoColors.black,
                            trackColor: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    // ListTile(
                    //     leading: SvgPicture.asset(
                    //       Asset.moon,
                    //       color: isDarkMode() ? white : black,
                    //     ),
                    //     horizontalTitleGap: 0.1,
                    //     visualDensity:
                    //         VisualDensity(horizontal: 0, vertical: -1),
                    //     title: Text(
                    //       SettingConstant.change_theme,
                    //       style: TextStyle(
                    //           fontFamily: opensansMedium,
                    //           fontSize: 14.sp,
                    //           fontWeight: FontWeight.w400),
                    //     ),
                    //     trailing: Container(
                    //       //padding: EdgeInsets.only(right: 2.h),
                    //       child: CupertinoSwitch(
                    //         value: isDarkMode() ? true : false,
                    //         onChanged: (value) async {
                    //           state = value;
                    //           setState(() {
                    //             _isDarkMode = _isDarkMode == 0 ? 1 : 0;
                    //           });
                    //           await getStorage.write(
                    //               GetStorageKey.IS_DARK_MODE, _isDarkMode);
                    //           //setState(() {});
                    //           Get.find<ThemeController>()
                    //               .updateState(_isDarkMode);
                    //           Get.find<ThemeController>().update();
                    //           print(
                    //               getStorage.read(GetStorageKey.IS_DARK_MODE));
                    //           setState(
                    //             () {},
                    //           );
                    //         },
                    //         thumbColor: isDarkMode()
                    //             ? CupertinoColors.black
                    //             : CupertinoColors.white,
                    //         activeColor: isDarkMode()
                    //             ? CupertinoColors.white
                    //             : CupertinoColors.black,
                    //         trackColor: Colors.grey,
                    //       ),

                    //     )),

                    dividerforSetting(),
                    settingRow(Asset.bug, "Report Bug", () {
                      Get.to(ReportBugScreen());
                    }, Asset.rightbackbutton),
                    dividerforSetting(),
                    settingRow(Asset.rate_us, SettingConstant.rate_us, () {},
                        Asset.rightbackbutton),
                    dividerforSetting(),
                    settingRow(Asset.share, SettingConstant.share_us, () {},
                        Asset.rightbackbutton),
                    dividerforSetting(),
                    settingRow(Asset.signout, SettingConstant.logout, () {
                      PopupDialogsforSignOut(context);
                    }, Asset.rightbackbutton),
                    dividerforSetting(),
                  ],
                ),
              ),
            ]))));
  }
}
