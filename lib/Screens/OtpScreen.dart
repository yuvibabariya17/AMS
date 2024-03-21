import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Screens/LoginScreen/LoginScreen.dart';
import 'package:booking_app/controllers/VerifyOtpController.dart';
import 'package:booking_app/core/Common/toolbar.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:booking_app/custom_componannt/common_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';
import '../core/Common/Common.dart';
import '../core/constants/strings.dart';
import '../core/themes/font_constant.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final controller = Get.put(VerifyOtpController());

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
    controller.clearFocuseNode();
    controller.fieldOne.text = '';
    controller.fieldTwo.text = '';
    controller.fieldThree.text = '';
    controller.fieldFour.text = '';
    controller.fieldFour.text = '';
    controller.otpController.text = "";
    controller.otpController.clear();
    controller.startTimer();
    //if (widget.isPassword == false) {
    // getOtpFromFirebase(context);
    //}
    super.initState();
  }

  @override
  void dispose() {
    controller.timer.cancel();
    controller.otpController.clear();
    controller.fieldOne.text = '';
    controller.fieldTwo.text = '';
    controller.fieldThree.text = '';
    controller.fieldFour.text = '';
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
                          ? 20.sp
                          : 20.sp,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // OtpInput(controller.otp1, false, controller.node1,
                //     controller.handleLastField),
                // SizedBox(width: 4.5.w),
                // OtpInput(controller.otp2, false, controller.node2,
                //     controller.handleLastField),
                // SizedBox(width: 4.5.w),
                // OtpInput(controller.otp3, false, controller.node3,
                //     controller.handleLastField),
                // SizedBox(width: 4.5.w),
                // OtpInput(
                //   controller.otp4,
                //   false,
                //   controller.node4,
                //   controller.handleLastField,
                //   isLast: true,
                // ),

                SizedBox(
                  height: 10.h,
                  child: Pinput(
                    length: 4,
                    controller: controller.otpController,

                    focusNode: controller.otpNode,

                    defaultPinTheme: getPinTheme(),
                    // cursor: Container(height: 1.h,width: 1.h,color: black,),
                    onCompleted: (pin) {
                      if (controller.isFormInvalidate.value =
                          pin.length == 4) {}
                      setState(() {
                        pin.length != 4;
                      });
                      // setState(() => controller.showError =
                      //     // controller.isFormInvalidate.value =
                      //     pin.length != 6);
                    },
                    onChanged: (value) {
                      controller.enableButton(
                        value,
                      );
                      setState(() {});
                    },

                    focusedPinTheme: getPinTheme().copyWith(
                      height: 68.0,
                      width: 64.0,
                      decoration: getPinTheme().decoration!.copyWith(
                            border: Border.all(
                                color: const Color.fromRGBO(114, 178, 238, 1)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                    ),
                    submittedPinTheme: getPinTheme().copyWith(
                      decoration: getPinTheme().decoration!.copyWith(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: black),
                          ),
                    ),
                    errorPinTheme: getPinTheme().copyWith(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 234, 238, 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
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
              margin: EdgeInsets.only(left: 14.w, right: 14.w),
              child: FadeInUp(
                  from: 50,
                  child: Obx(() {
                    return getFormButton(() {
                      if (controller.isFormInvalidate.value == true) {
                        Get.offAll(LoginScreen());
                      }
                    }, Strings.verify,
                        validate: controller.isFormInvalidate.value);
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
