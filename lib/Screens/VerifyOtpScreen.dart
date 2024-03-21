// import 'package:animate_do/animate_do.dart';
// import 'package:booking_app/controllers/VerifyOtpController.dart';
// import 'package:booking_app/controllers/internet_controller.dart';
// import 'package:booking_app/core/Common/toolbar.dart';
// import 'package:booking_app/core/themes/color_const.dart';
// import 'package:booking_app/core/themes/font_constant.dart';
// import 'package:booking_app/custom_componannt/form_button.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pinput/pinput.dart';
// import 'package:sizer/sizer.dart';

// enum OTPType { email, mobile }

// enum RouteType { signUp, signIn, changeId }

// // ignore: must_be_immutable
// class VerifyOTPScreen extends StatefulWidget {
//   VerifyOTPScreen({
//     this.mobile,
//     this.otp,
//     this.isVerify,
//     this.isPassword,
//     this.verificationId,
//     Key? key,
//   }) : super(key: key);
//   bool? isVerify;
//   bool? isPassword;

//   String? otp;
//   String? mobile;
//   String? verificationId;

//   @override
//   State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
// }

// class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
//   var controller = Get.put(VerifyOtpController());

//   @override
//   void initState() {
//     controller.clearFocuseNode();
//     controller.fieldOne.text = '';
//     controller.fieldTwo.text = '';
//     controller.fieldThree.text = '';
//     controller.fieldFour.text = '';
//     controller.fieldFour.text = '';
//     controller.otpController.text = "";
//     controller.otpController.clear();
//     controller.startTimer();
//     //if (widget.isPassword == false) {
//     // getOtpFromFirebase(context);
//     //}
//     super.initState();
//   }

//   // void getOtpFromFirebase(BuildContext context) async {
//   //   try {
//   //     if (mounted) {
//   //       await Future.delayed(const Duration(seconds: 1)).then((value) {
//   //         print("MOOOO : " + widget.mobile.toString());
//   //         controller.updateData(
//   //             context, widget.isPassword!, widget.mobile.toString());
//   //       });
//   //     }
//   //   } catch (e) {
//   //     logcat("ERROR", e);
//   //   }
//   // }

//   @override
//   void dispose() {
//     controller.timer.cancel();
//     controller.otpController.clear();
//     controller.fieldOne.text = '';
//     controller.fieldTwo.text = '';
//     controller.fieldThree.text = '';
//     controller.fieldFour.text = '';
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(onTap: () {
//       controller.hideKeyboard(context);
//     }, child: GetBuilder<InternetController>(builder: (internetCtr) {
//       // ignore: unrelated_type_equality_checks

//       return Scaffold(
//         body: WillPopScope(
//           onWillPop: () async {
//             controller.hideKeyboard(context);
//             Get.back();
//             return false;
//           },
//           child: Stack(
//             children: [
//               CustomScrollView(
//                 slivers: <Widget>[
//                   SliverToBoxAdapter(
//                     child: Padding(
//                       padding: EdgeInsets.only(bottom: 4.h),
//                       child: Form(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                               height: 4.h,
//                             ),
//                             // getOtpVerificationToolbar(
//                             //     context, LocalizationKeys.verificationTitle.tr,
//                             //     showBackButton: true, callback: () {
//                             //   Get.back();
//                             // }),
//                             SizedBox(
//                               height: 3.h,
//                             ),
//                             // getSubTextWidget(),
//                             SizedBox(
//                               height: 1.h,
//                             ),
//                             FadeInUp(
//                                 child: Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 12.w),
//                               child: Text('+91 ${widget.mobile}',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     fontFamily: fontRegular,
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: SizerUtil.deviceType ==
//                                             DeviceType.mobile
//                                         ? 12.sp
//                                         : 8.sp,
//                                   )),
//                             )),
//                             SizedBox(
//                               height: 4.5.h,
//                             ),
//                             SizedBox(
//                               height: 10.h,
//                               child: Pinput(
//                                 length: widget.isPassword == true ? 4 : 4,
//                                 controller: controller.otpController,
//                                 focusNode: controller.otpNode,
//                                 defaultPinTheme: getPinTheme(widget.isPassword),
//                                 onCompleted: (pin) {
//                                   if (widget.isPassword == true) {
//                                     if (controller.isFormInvalidate.value =
//                                         pin.length == 4) {}
//                                   } else {
//                                     if (controller.isFormInvalidate.value =
//                                         pin.length == 4) {}
//                                   }
//                                   setState(() {
//                                     if (widget.isPassword == true) {
//                                       pin.length != 4;
//                                     } else {
//                                       pin.length != 4;
//                                     }
//                                   });
//                                   // setState(() => controller.showError =
//                                   //     // controller.isFormInvalidate.value =
//                                   //     pin.length != 6);
//                                 },
//                                 onChanged: (value) {
//                                   controller.enableButton(
//                                       value, widget.isPassword);
//                                   setState(() {});
//                                 },
//                                 focusedPinTheme:
//                                     getPinTheme(widget.isPassword).copyWith(
//                                   height: 68.0,
//                                   width: 64.0,
//                                   decoration: getPinTheme(widget.isPassword)
//                                       .decoration!
//                                       .copyWith(
//                                         border: Border.all(
//                                             color: const Color.fromRGBO(
//                                                 114, 178, 238, 1)),
//                                       ),
//                                 ),
//                                 errorPinTheme:
//                                     getPinTheme(widget.isPassword).copyWith(
//                                   decoration: BoxDecoration(
//                                     color:
//                                         const Color.fromRGBO(255, 234, 238, 1),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 4.h,
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(
//                                 left: 14.w,
//                                 right: 14.w,
//                               ),
//                               child: FadeInUp(
//                                 from: 50,
//                                 child: Obx(
//                                   () {
//                                     return getFormButton(
//                                       () {
//                                         if (controller.isFormInvalidate.value ==
//                                             true) {
//                                           //Old Logic
//                                           // return widget.isVerify == true
//                                           //     ? Get.offAll(const MainScreen())
//                                           //     : widget.isPassword == true
//                                           //         ? controller.getOtpScreen(
//                                           //             context,
//                                           //             widget.otp.toString(),
//                                           //             widget.mobile.toString())
//                                           //         : controller.getRegisterOtp(
//                                           //             context,
//                                           //             widget.otp.toString(),
//                                           //             widget.mobile.toString());
//                                           // //New Logic
//                                         }
//                                       },
//                                       "Submit",
//                                       isvalidate:
//                                           controller.isFormInvalidate.value,
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 3.h,
//                             ),
//                             FadeInUp(
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 14.w),
//                                 child: FadeInUp(
//                                   child: Obx(
//                                     () {
//                                       return InkWell(
//                                         canRequestFocus: false,
//                                         onTap: () {
//                                           //  sendOtp(true);
//                                           controller.clearFocuseNode();
//                                         },
//                                         child: controller.countdown.value == 0
//                                             ? GestureDetector(
//                                                 onTap: () {
//                                                   // OLD LOGIC
//                                                   // widget.isPassword == true
//                                                   //     ? controller.getForgotOtp(
//                                                   //         context,
//                                                   //         widget.mobile
//                                                   //             .toString())
//                                                   //     : controller.getSignUpOtp(
//                                                   //         context,
//                                                   //         widget.mobile
//                                                   //             .toString());

//                                                   // if (widget.isPassword ==
//                                                   //     true) {
//                                                   //   controller.getForgotOtp(
//                                                   //       context,
//                                                   //       widget.mobile
//                                                   //           .toString());
//                                                   // } else {
//                                                   //   //NEW LOGIC
//                                                   //   controller.updateData(
//                                                   //       context,
//                                                   //       widget.isPassword!,
//                                                   //       widget.mobile
//                                                   //           .toString());
//                                                   // }

//                                                   //NEW LOGIC
//                                                   // controller.updateData(context,
//                                                   //     widget.mobile.toString());
//                                                   // return;
//                                                 },
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     // Text(
//                                                     //   "${LocalizationKeys.verifyScreenFooterTitle.tr} ",
//                                                     //   style:
//                                                     //       styleDidtReceiveOTP(
//                                                     //           context),
//                                                     // ),
//                                                     // Text(
//                                                     //   LocalizationKeys
//                                                     //       .verifyScreenResendTitle
//                                                     //       .tr,
//                                                     //   style:
//                                                     //       styleResentButton(),
//                                                     // ),
//                                                   ],
//                                                 ),
//                                               )
//                                             : Text(
//                                                 "${"Time Remaining"} ${controller.countdown} ${"Seconds"}",
//                                                 style: TextStyle(
//                                                     fontSize: SizerUtil
//                                                                 .deviceType ==
//                                                             DeviceType.mobile
//                                                         ? 11.5.sp
//                                                         : 9.sp,
//                                                     fontWeight: FontWeight.w100,
//                                                     fontFamily: fontRegular,
//                                                     color: labelTextColor),
//                                               ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 3.h,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );
//     }));
//   }

//   performBackpress(String uuid, bool isverified) {
//     Map data = {"uuid": uuid, "isVerified": isverified};
//     Get.back(result: data);
//   }
// }
