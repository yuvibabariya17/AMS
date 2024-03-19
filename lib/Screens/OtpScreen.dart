import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Screens/LoginScreen/LoginScreen.dart';
import 'package:booking_app/controllers/OtpController.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
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
  final controller = Get.put(OtpController());

  late TextEditingController otp1 = TextEditingController();
  late TextEditingController otp2 = TextEditingController();
  late TextEditingController otp3 = TextEditingController();
  late TextEditingController otp4 = TextEditingController();
  FocusNode node1 = FocusNode();
  FocusNode node2 = FocusNode();
  FocusNode node3 = FocusNode();
  FocusNode node4 = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    controller.node1.dispose();
    controller.node2.dispose();
    controller.node3.dispose();
    controller.node4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInDown(
              from: 50,
              child: Container(
                padding: EdgeInsets.only(
                  top: SizerUtil.deviceType == DeviceType.mobile ? 1.h : 4.h,
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
            FadeInDown(
              from: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
            Text(
              Strings.otp_code,
              style: TextStyle(
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 14.sp : 10.sp,
                  fontFamily: opensansMedium,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 3.h,
            ),
            Obx(
              () {
                controller.allFieldsFilled.value;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OtpInput(controller.otp1, false, controller.node1,
                        controller.handleLastField),
                    SizedBox(width: 4.5.w),
                    OtpInput(controller.otp2, false, controller.node2,
                        controller.handleLastField),
                    SizedBox(width: 4.5.w),
                    OtpInput(controller.otp3, false, controller.node3,
                        controller.handleLastField),
                    SizedBox(width: 4.5.w),
                    OtpInput(controller.otp4, false, controller.node4,
                        controller.handleLastField),
                  ],
                );
              },
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
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
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
              child: GestureDetector(
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
                        fontSize: SizerUtil.deviceType == DeviceType.mobile
                            ? 15.sp
                            : 10.sp,
                        fontFamily: opensans_Bold,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizerUtil.deviceType == DeviceType.mobile ? 5.h : 4.h,
            ),
            Container(
              margin: EdgeInsets.only(left: 11.w, right: 11.w),
              child: FadeInUp(
                  from: 50,
                  child: Obx(() {
                    return getFormButton(() {
                      if (controller.allFieldsFilled.value == true) {
                        Get.offAll(LoginScreen());
                      }
                    }, Strings.verify,
                        validate: controller.allFieldsFilled.value);
                  })),
            )
          ],
        ),
      ),
    );

    // Scaffold(
    //     resizeToAvoidBottomInset: true,
    //     body: Stack(children: [
    //       SizedBox(
    //         height: double.infinity,
    //         width: double.infinity,
    //         child: isDarkMode()
    //             ? SvgPicture.asset(
    //                 Asset.dark_bg,
    //                 fit: BoxFit.cover,
    //               )
    //             : SvgPicture.asset(
    //                 Asset.bg,
    //                 fit: BoxFit.cover,
    //               ),
    //       ),
    //       SingleChildScrollView(
    //         child:

    //       ),
    //     ]));
  }
}
