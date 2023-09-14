import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../core/Common/appbar.dart';
import '../core/Common/toolbar.dart';
import '../core/constants/assets.dart';
import '../core/constants/strings.dart';

class InviteFriendScreen extends StatefulWidget {
  const InviteFriendScreen({super.key});

  @override
  State<InviteFriendScreen> createState() => _InviteFriendScreenState();
}

class _InviteFriendScreenState extends State<InviteFriendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: Colors.white,
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
              minimum: EdgeInsets.only(top: 1.h),
              child: Container(
                  margin: EdgeInsets.only(
                    top: 0.5.h,
                  ),
                  child: Center(
                      child: Column(
                    children: [
                      getToolbar("Add Vendor Service", showBackButton: true,
                          callback: () {
                        Get.back();
                      })
                      // HomeAppBar(
                      //   title: Strings.invite_friends,
                      //   leading: Asset.backbutton,
                      //   isfilter: false,
                      //   icon: Asset.filter,
                      //   isBack: true,
                      //   onClick: () {},
                      // ),
                    ],
                  )))),
          SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 8.0.w,
                      right: 8.0.w,
                      top: 12.h,
                    ),
                    child: SvgPicture.asset(
                      Asset.referfriend,
                      height: 32.h,
                      width: 32.h,
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Text(
                    Strings.share_code,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: opensansMedium,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    Strings.refer_code,
                                    style: TextStyle(
                                        fontFamily: opensans_Bold,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height: 5.5.h,
                                  width: 27.h,
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(12),
                                    dashPattern: [5, 5],
                                    color: Colors.black,
                                    strokeWidth: 2,
                                    child: Center(
                                        child: Text(
                                      "4854WAF",
                                      style: TextStyle(
                                          fontFamily: fontUrbanistBold,
                                          fontSize: 15.sp),
                                    )),
                                  )),
                              Container(
                                  height: 5.5.h,
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12))),
                                      child: Text(
                                        Strings.copy,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.sp,
                                            fontFamily: opensans_Bold,
                                            fontWeight: FontWeight.w400),
                                      )))
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            Strings.social_media,
                            style: TextStyle(
                                fontFamily: opensans_Bold,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 5.h,
                                  width: 35.w,
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: SvgPicture.asset(Asset.facebook),
                                      ),
                                      SizedBox(width: 2.w),
                                      Container(
                                        child: Text(
                                          Strings.fb,
                                          style: TextStyle(
                                            fontFamily: opensansMedium,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 5.h,
                                width: 35.w,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: SvgPicture.asset(Asset.twitter),
                                    ),
                                    SizedBox(width: 1.w),
                                    Container(
                                      child: Text(Strings.twitter,
                                          style: TextStyle(
                                              fontFamily: opensansMedium)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 5.h,
                                width: 35.w,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: SvgPicture.asset(Asset.instagram),
                                    ),
                                    SizedBox(width: 2.w),
                                    Container(
                                      child: Text(Strings.instagram,
                                          style: TextStyle(
                                              fontFamily: opensansMedium)),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 5.h,
                                width: 35.w,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: SvgPicture.asset(Asset.message),
                                    ),
                                    SizedBox(width: 1.w),
                                    Container(
                                      child: Text(Strings.message,
                                          style: TextStyle(
                                              fontFamily: opensansMedium)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ]),
                  )
                ]),
          )
        ]));
  }
}
