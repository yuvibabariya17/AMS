import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Screens/DashboardScreen/DashboardScreen.dart';
import 'package:booking_app/Screens/LoginScreen/LoginScreen.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/custom_componannt/common_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../core/Common/Common.dart';
import '../core/Common/OTP_Textfield.dart';
import '../core/constants/strings.dart';
import '../core/themes/font_constant.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late TextEditingController otp1 = TextEditingController();
  late TextEditingController otp2 = TextEditingController();
  late TextEditingController otp3 = TextEditingController();
  late TextEditingController otp4 = TextEditingController();
  FocusNode node1 = FocusNode();
  FocusNode node2 = FocusNode();
  FocusNode node3 = FocusNode();
  FocusNode node4 = FocusNode();

  RxBool isFormInvalidate = true.obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    node1.dispose();
    node2.dispose();
    node3.dispose();
    node4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeInDown(
                  from: 50,
                  child: Container(
                    padding: EdgeInsets.only(
                      top:
                          SizerUtil.deviceType == DeviceType.mobile ? 7.h : 4.h,
                    ),
                    child: Text(
                      Strings.verification,
                      style: TextStyle(
                          fontFamily: opensans_Bold,
                          fontSize: SizerUtil.deviceType == DeviceType.mobile
                              ? 30.sp
                              : 22.sp,
                          fontWeight: SizerUtil.deviceType == DeviceType.mobile
                              ? FontWeight.w700
                              : FontWeight.w500),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeInDown(
                        from: 50,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                Asset.otp,
                                height: 40.h,
                                width: 30.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        Strings.otp_code,
                        style: TextStyle(
                            fontSize: SizerUtil.deviceType == DeviceType.mobile
                                ? 14.sp
                                : 10.sp,
                            fontFamily: opensansMedium,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          OtpInput(
                            otp1,
                            false,
                            node1,
                          ),
                          SizedBox(width: 4.5.w),
                          OtpInput(otp2, false, node2),
                          SizedBox(width: 4.5.w),
                          OtpInput(otp3, false, node3),
                          SizedBox(width: 4.5.w),
                          OtpInput(otp4, false, node4),
                        ],
                      ),
                      SizedBox(
                        height: 3.0.h,
                      ),
                      FadeInUp(
                        from: 50,
                        child: Container(
                          child: Text(
                            Strings.not_receive_code,
                            style: TextStyle(
                                fontSize:
                                    SizerUtil.deviceType == DeviceType.mobile
                                        ? 13.5.sp
                                        : 12.sp,
                                fontFamily: opensansMedium,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      FadeInUp(
                        from: 50,
                        child: InkWell(
                          onTap: () {
                            Common.PopupDialogForOtp(context);
                          },
                          child: Container(
                            child: Text(
                              Strings.resend,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.black,
                                  decorationThickness: 1.5,
                                  fontSize:
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? 15.sp
                                          : 10.sp,
                                  fontFamily: opensans_Bold,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizerUtil.deviceType == DeviceType.mobile
                            ? 5.h
                            : 4.h,
                      ),
                      FadeInUp(
                          from: 50,
                          child: Obx(() {
                            return getFormButton(() {
                              if (isFormInvalidate.value == true) {
                                Get.offAll(LoginScreen());
                              }
                            }, Strings.verify,
                                validate: isFormInvalidate.value);
                          })),
                      // FadeInUp(
                      //   from: 50,
                      //   child: SizedBox(
                      //       width: 80.w,
                      //       height: 6.h,
                      //       child: ElevatedButton(
                      //           onPressed: () {
                      //             Get.offAll(LoginScreen());
                      //           },
                      //           style: ElevatedButton.styleFrom(
                      //               backgroundColor: Colors.black,
                      //               shape: RoundedRectangleBorder(
                      //                   borderRadius:
                      //                       BorderRadius.circular(50))),
                      //           child: Text(
                      //             Strings.verify,
                      //             style: TextStyle(
                      //                 color: Colors.white,
                      //                 fontSize: 14.5.sp,
                      //                 fontFamily: opensans_Bold,
                      //                 fontWeight: FontWeight.w700),
                      //           ))),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ]));
  }
}
