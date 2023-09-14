import 'package:booking_app/Models/setting.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

List<SettingItem> SettingsItems = <SettingItem>[
  SettingItem(
    icon: SvgPicture.asset(Asset.user, color: Colors.black),
    Name: 'Profile Information',
    button: SvgPicture.asset(Asset.rightbackbutton),
  ),
  SettingItem(
    icon: SvgPicture.asset(Asset.adduser, color: Colors.black),
    Name: 'Invite Friends',
    button: SvgPicture.asset(Asset.rightbackbutton),
  ),
  SettingItem(
    icon: SvgPicture.asset(Asset.moon, color: Colors.black),
    Name: 'Change Theme',
    button: SvgPicture.asset(
      Asset.togglebutton,
      height: 4.h,
      width: 4.h,
    ),
  ),
  SettingItem(
    icon: SvgPicture.asset(Asset.rate_us, color: Colors.black),
    Name: 'Rate Us',
    button: null,
  ),
  SettingItem(
    icon: SvgPicture.asset(Asset.share, color: Colors.black),
    Name: 'Share us',
    button: null,
  ),
  SettingItem(
    icon: SvgPicture.asset(Asset.signout, color: Colors.black),
    Name: 'Log Out',
    button: null,
  ),
];
