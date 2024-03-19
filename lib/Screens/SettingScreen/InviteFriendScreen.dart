import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/Common/toolbar.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/strings.dart';
import '../../custom_componannt/CustomeBackground.dart';

class InviteFriendScreen extends StatefulWidget {
  const InviteFriendScreen({super.key});

  @override
  State<InviteFriendScreen> createState() => _InviteFriendScreenState();
}

class _InviteFriendScreenState extends State<InviteFriendScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Column(
      children: [
        getCommonToolbar("Invite Friends", () {
          Get.back();
        }),
        SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              padding: EdgeInsets.only(
                left: 8.0.w,
                right: 8.0.w,
                top: 3.h,
              ),
              child: SvgPicture.asset(
                Asset.referfriend,
                height: SizerUtil.deviceType == DeviceType.mobile ? 32.h : 30.h,
                width: SizerUtil.deviceType == DeviceType.mobile ? 32.h : 30.h,
              ),
            ),
            SizedBox(
              height: SizerUtil.deviceType == DeviceType.mobile ? 1.5.h : 1.h,
            ),
            Text(
              Strings.share_code,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: opensansMedium,
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 13.sp : 10.sp,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: SizerUtil.deviceType == DeviceType.mobile ? 3.h : 2.h,
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
                                  fontSize:
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? 16.sp
                                          : 13.sp,
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
                              color: isDarkMode() ? white : Colors.black,
                              strokeWidth: 2,
                              child: Center(
                                  child: Text(
                                "4854WAF",
                                style: TextStyle(
                                    fontFamily: fontUrbanistBold,
                                    fontSize: SizerUtil.deviceType ==
                                            DeviceType.mobile
                                        ? 15.sp
                                        : 12.sp),
                              )),
                            )),
                        Container(
                            height: 5.5.h,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        isDarkMode() ? white : Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
                                child: Text(
                                  Strings.copy,
                                  style: TextStyle(
                                      color:
                                          isDarkMode() ? black : Colors.white,
                                      fontSize: SizerUtil.deviceType ==
                                              DeviceType.mobile
                                          ? 15.sp
                                          : 11.sp,
                                      fontFamily: opensans_Bold,
                                      fontWeight: FontWeight.w400),
                                )))
                      ],
                    ),
                    SizedBox(
                      height:
                          SizerUtil.deviceType == DeviceType.mobile ? 4.h : 3.h,
                    ),
                    Text(
                      Strings.social_media,
                      style: TextStyle(
                          fontFamily: opensans_Bold,
                          fontSize: SizerUtil.deviceType == DeviceType.mobile
                              ? 16.sp
                              : 13.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                        height: SizerUtil.deviceType == DeviceType.mobile
                            ? 4.h
                            : 3.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 5.h,
                            width: 35.w,
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    color: black.withOpacity(0.2),
                                    spreadRadius: 0.1,
                                    blurRadius: 10,
                                    offset: Offset(0.5, 0.5)),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: SvgPicture.asset(
                                    Asset.facebook,
                                    height: SizerUtil.deviceType ==
                                            DeviceType.mobile
                                        ? null
                                        : 3.h,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Container(
                                  child: Text(
                                    Strings.fb,
                                    style: TextStyle(
                                      color: black,
                                      fontFamily: opensansMedium,
                                      fontWeight: FontWeight.w500,
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
                            color: white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: black.withOpacity(0.2),
                                  spreadRadius: 0.1,
                                  blurRadius: 10,
                                  offset: Offset(0.5, 0.5)),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: SvgPicture.asset(
                                  Asset.twitter,
                                  height:
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? null
                                          : 3.h,
                                ),
                              ),
                              SizedBox(width: 1.w),
                              Container(
                                child: Text(Strings.twitter,
                                    style: TextStyle(
                                      fontFamily: opensansMedium,
                                      color: isDarkMode() ? black : black,
                                      fontWeight: FontWeight.w500,
                                    )),
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
                            color: white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: black.withOpacity(0.2),
                                  spreadRadius: 0.1,
                                  blurRadius: 10,
                                  offset: Offset(0.5, 0.5)),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: SvgPicture.asset(
                                  Asset.instagram,
                                  height:
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? null
                                          : 3.h,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Container(
                                child: Text(Strings.instagram,
                                    style: TextStyle(
                                      fontFamily: opensansMedium,
                                      color: isDarkMode() ? black : black,
                                      fontWeight: FontWeight.w500,
                                    )),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 5.h,
                          width: 35.w,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: black.withOpacity(0.2),
                                  spreadRadius: 0.1,
                                  blurRadius: 10,
                                  offset: Offset(0.5, 0.5)),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: SvgPicture.asset(
                                  Asset.message,
                                  height:
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? null
                                          : 3.h,
                                ),
                              ),
                              SizedBox(width: 1.w),
                              Container(
                                child: Text(Strings.message,
                                    style: TextStyle(
                                      fontFamily: opensansMedium,
                                      fontWeight: FontWeight.w500,
                                      color: isDarkMode() ? black : black,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
            )
          ]),
        ),
      ],
    ));
  }
}
