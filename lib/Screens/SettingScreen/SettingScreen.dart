import 'package:booking_app/Screens/DashboardScreen/DashboardScreen.dart';
import 'package:booking_app/Screens/SettingScreen/InviteFriendScreen.dart';
import 'package:booking_app/Screens/SettingScreen/AddReportBugScreen.dart';
import 'package:booking_app/controllers/home_screen_controller.dart';
import 'package:booking_app/controllers/theme_controller.dart';
import 'package:booking_app/core/Common/Common.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
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
  int _isDarkMode = 1;
  late final Box<int> storageBox;
  final getStorage = GetStorage();

  bool state = false;
  var lastSelectedLanguage;

  @override
  void initState() {
    getDarkMode();
    super.initState();
  }

  getDarkMode() async {
    storageBox = await Hive.openBox<int>(Strings.storeDarkMode);
    lastSelectedLanguage = storageBox.get(Strings.selectedMode) ?? 1;
    logcat('lastSelectedMode', lastSelectedLanguage.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Common().trasparent_statusbar();
    return CustomScaffold(
        isFromSettingScreen: true,
        body: Container(
            margin: EdgeInsets.only(
              top: 1.h,
            ),
            child: Center(
                child: Column(children: [
              getCommonToolbar(ScreenTitle.settings, () {
                Get.offAll(MyHomePage(
                  isFromSettingScreen: true,
                ));
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
                height: SizerUtil.deviceType == DeviceType.mobile ? 3.h : 1.h,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: SizerUtil.deviceType == DeviceType.mobile ? 8.w : 6.w,
                  right: SizerUtil.deviceType == DeviceType.mobile ? 8.w : 6.w,
                ),
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    //PROFILE INFORMATION SCREEN
                    // settingRow(Asset.user, SettingConstant.profile_info, () {6+7
                    //   Get.to(ProfileInformationScreen());
                    // }, Asset.rightbackbutton),
                    // dividerforSetting(),

                    settingRow(Asset.invite, SettingConstant.invite_frd, () {
                      Get.to(InviteFriendScreen());
                    }, Asset.rightbackbutton),
                    dividerforSetting(),
                    Container(
                      width: SizerUtil.width,
                      height:
                          SizerUtil.deviceType == DeviceType.mobile ? 3.h : 4.h,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Asset.moon,
                            color: isDarkMode() ? white : black,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizerUtil.deviceType == DeviceType.mobile
                                    ? 5.5.w
                                    : 5.7.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  SettingConstant.change_theme,
                                  style: TextStyle(
                                    color: isDarkMode() ? white : black,
                                    fontFamily: opensansMedium,
                                    fontSize: SizerUtil.deviceType ==
                                            DeviceType.mobile
                                        ? 13.5.sp
                                        : 10.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: CupertinoSwitch(
                              value: isDarkMode() ? true : false,
                              onChanged: (value) async {
                                //state = value;
                                _isDarkMode = getStorage
                                            .read(GetStorageKey.IS_DARK_MODE) ==
                                        0
                                    ? 1
                                    : 0;
                                setState(() {});
                                // Delay for a short period to ensure the state changes are processed
                                await Future.delayed(
                                    const Duration(milliseconds: 50));

                                setState(() {});
                                await getStorage.write(
                                    GetStorageKey.IS_DARK_MODE, _isDarkMode);
                                Get.find<ThemeController>()
                                    .updateState(_isDarkMode);
                                Get.find<ThemeController>().update();
                                logcat(
                                    'DarkModeStatus::',
                                    (getStorage
                                        .read(GetStorageKey.IS_DARK_MODE)));
                                // Delay before updating MainScreenController
                                await Future.delayed(
                                    const Duration(milliseconds: 50));
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
                    ),
                    dividerforSetting(),
                    settingRow(Asset.bug, SettingConstant.reportBug, () {
                      Get.to(AddReportBugScreen());
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
