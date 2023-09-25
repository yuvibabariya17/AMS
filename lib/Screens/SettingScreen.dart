import 'package:booking_app/controllers/theme_controller.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import '../Models/setting.dart';
import '../Models/settings_model.dart';
import '../core/Common/toolbar.dart';
import '../core/Common/util.dart';
import '../core/constants/assets.dart';
import '../core/constants/get_storage_key.dart';
import '../core/constants/strings.dart';
import '../core/utils/helper.dart';

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
    return Scaffold(
        body: Stack(children: [
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
      SafeArea(
          minimum: EdgeInsets.only(top: 2.h),
          child: Container(
              margin: EdgeInsets.only(
                top: 1.h,
              ),
              child: Center(
                  child: Column(children: [
                getCommonToolbar("Settings", () {
                  Get.back();
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
                  margin: EdgeInsets.only(left: 2.h),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      settingListtile(Asset.user, Strings.profile_info, () {},
                          Asset.rightbackbutton),
                      dividerforSetting(),
                      settingListtile(Asset.user, Strings.invite_frd, () {},
                          Asset.rightbackbutton),

                      // ListTile(
                      //   // horizontalTitleGap: 0.1,
                      //   // leading: data.icon,
                      //   // title: Container(
                      //   //     // margin: EdgeInsets.only(right: 1.h),
                      //   //     child: Text(
                      //   //   data.Name,
                      //   //   style: TextStyle(
                      //   //       fontFamily: fontUrbanistRegular,
                      //   //       fontWeight: FontWeight.w400,
                      //   //       fontSize: 15.sp),
                      //   // )),
                      //   // trailing:
                      //   //     data.button != null ? data.button : null),
                      //   leading: SvgPicture.asset(
                      //     Asset.user,
                      //     color: isDarkMode() ? white : black,
                      //   ),
                      //   horizontalTitleGap: 0.1,
                      //   visualDensity:
                      //       VisualDensity(horizontal: 0, vertical: -1),
                      //   title: GestureDetector(
                      //     onTap: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => ProfileScreen()));
                      //     },
                      //     child: Text(
                      //       Strings.profile_info,
                      //       style: TextStyle(
                      //           fontSize: 14.sp,
                      //           fontFamily: opensansMedium,
                      //           fontWeight: FontWeight.w400),
                      //     ),
                      //   ),
                      //   trailing: IconButton(
                      //       onPressed: () {
                      //         Get.to(ProfileScreen());
                      //         // Navigator.push(
                      //         //     context,
                      //         //     MaterialPageRoute(
                      //         //         builder: (context) => ProfileScreen()));
                      //       },
                      //       icon: SvgPicture.asset(
                      //         Asset.rightbackbutton,
                      //         color: isDarkMode() ? white : black,
                      //       )),
                      // ),

                      // ListTile(
                      //   leading: SvgPicture.asset(
                      //     Asset.adduser,
                      //     color: isDarkMode() ? white : black,
                      //   ),
                      //   visualDensity:
                      //       VisualDensity(horizontal: 0, vertical: -1),
                      //   horizontalTitleGap: 0.1,
                      //   title: GestureDetector(
                      //     onTap: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) =>
                      //                   InviteFriendScreen()));
                      //     },
                      //     child: Text(
                      //       Strings.invite_frd,
                      //       style: TextStyle(
                      //           fontFamily: opensansMedium,
                      //           fontSize: 14.sp,
                      //           fontWeight: FontWeight.w400),
                      //     ),
                      //   ),
                      //   trailing: IconButton(
                      //       onPressed: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) =>
                      //                     InviteFriendScreen()));
                      //       },
                      //       icon: SvgPicture.asset(
                      //         Asset.rightbackbutton,
                      //         color: isDarkMode() ? white : black,
                      //       )),
                      //   // trailing: TextButton(
                      //   //     onPressed: () {
                      //   //       Navigator.push(
                      //   //           context,
                      //   //           MaterialPageRoute(
                      //   //               builder: (context) => referal()));
                      //   //     },
                      //   //     child: SvgPicture.asset(Asset.rightbackbutton)),
                      // ),
                      dividerforSetting(),
                      ListTile(
                          leading: SvgPicture.asset(
                            Asset.moon,
                            color: isDarkMode() ? white : black,
                          ),
                          horizontalTitleGap: 0.1,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -1),
                          title: Text(
                            Strings.change_theme,
                            style: TextStyle(
                                fontFamily: opensansMedium,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          trailing: Container(
                            padding: EdgeInsets.only(right: 1.5.h),
                            child: CupertinoSwitch(
                              value: isDarkMode() ? true : false,
                              onChanged: (value) async {
                                state = value;
                                setState(() {
                                  _isDarkMode = _isDarkMode == 0 ? 1 : 0;
                                });
                                var switchOn;
                                if (value == true) {
                                  switchOn = 1;
                                } else {
                                  switchOn = 0;
                                }
                                await getStorage.write(
                                    GetStorageKey.IS_DARK_MODE, _isDarkMode);
                                //setState(() {});
                                Get.find<ThemeController>()
                                    .updateState(_isDarkMode);
                                Get.find<ThemeController>().update();
                                print(getStorage
                                    .read(GetStorageKey.IS_DARK_MODE));
                                setState(
                                  () {},
                                );
                              },
                              thumbColor: isDarkMode()
                                  ? CupertinoColors.black
                                  : CupertinoColors.white,
                              activeColor: isDarkMode()
                                  ? CupertinoColors.white
                                  : CupertinoColors.black,
                              trackColor: Colors.grey,
                            ),
                            // child: CupertinoSwitch(
                            //   value: state,
                            //   onChanged: (value) {
                            //     state = value;
                            //     setState(
                            //       () {},
                            //     );
                            //   },
                            //   thumbColor: CupertinoColors.white,
                            //   activeColor: CupertinoColors.black,
                            //   trackColor: Colors.grey,
                            // ),
                          )),
                      dividerforSetting(),
                      settingListtile(Asset.rate_us, Strings.rate_us, () {},
                          Asset.rightbackbutton),
                      dividerforSetting(),
                      settingListtile(Asset.share, Strings.share_us, () {},
                          Asset.rightbackbutton),
                      dividerforSetting(),
                      settingListtile(Asset.signout, Strings.logout, () {
                        PopupDialogs(context);
                      }, Asset.rightbackbutton),
                      // ListTile(
                      //   leading: SvgPicture.asset(
                      //     Asset.rate_us,
                      //     color: isDarkMode() ? white : black,
                      //   ),
                      //   horizontalTitleGap: 0.1,
                      //   visualDensity:
                      //       VisualDensity(horizontal: 0, vertical: -1),
                      //   title: Text(
                      //     Strings.rate_us,
                      //     style: TextStyle(
                      //         fontFamily: opensansMedium,
                      //         fontSize: 14.sp,
                      //         fontWeight: FontWeight.w400),
                      //   ),
                      // ),
                      dividerforSetting(),
                      // ListTile(
                      //   leading: SvgPicture.asset(
                      //     Asset.share,
                      //     color: isDarkMode() ? white : black,
                      //   ),
                      //   horizontalTitleGap: 0.1,
                      //   visualDensity:
                      //       VisualDensity(horizontal: 0, vertical: -1),
                      //   title: Text(
                      //     Strings.share_us,
                      //     style: TextStyle(
                      //         fontFamily: opensansMedium,
                      //         fontSize: 14.sp,
                      //         fontWeight: FontWeight.w400),
                      //   ),
                      // ),

                      // ListTile(
                      //   leading: SvgPicture.asset(
                      //     Asset.signout,
                      //     color: isDarkMode() ? white : black,
                      //   ),
                      //   onTap: () {
                      //     PopupDialogs(context);
                      //   },
                      //   horizontalTitleGap: 0.1,
                      //   visualDensity:
                      //       VisualDensity(horizontal: 0, vertical: -1),
                      //   title: Text(
                      //     Strings.logout,
                      //     style: TextStyle(
                      //         fontFamily: opensansMedium,
                      //         fontSize: 14.sp,
                      //         fontWeight: FontWeight.w400),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ]))))
    ]));
  }
}
