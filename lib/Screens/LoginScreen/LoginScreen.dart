import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Screens/EmailScreen.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:booking_app/preference/UserPreference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/login_controller.dart';
import '../../core/Common/Common.dart';
import '../../core/Common/util.dart';
import '../../core/constants/strings.dart';
import '../../custom_componannt/common_views.dart';
import '../../custom_componannt/form_inputs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(LoginController());
  bool _isHidden = true;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // Show the dialog after the frame has been rendered
    //   _showInitialDialog();
    // });
  }

  @override
  Widget build(BuildContext context) {
    Common().trasparent_statusbar();

    return GestureDetector(
        onTap: () {
          hideKeyboard(context);
        },
        child: CustomScaffold(
          // resizeToAvoidBottomInset: false,
          body: Stack(children: [
            // SizedBox(
            //   height: double.infinity,
            //   width: double.infinity,
            //   child: isDarkMode()
            //       ? SvgPicture.asset(
            //           Asset.dark_bg,
            //           fit: BoxFit.cover,
            //         )
            //       : SvgPicture.asset(
            //           Asset.bg,
            //           fit: BoxFit.cover,
            //         ),
            // ),
            SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Container(
                  padding: EdgeInsets.only(
                      left: 7.0.w, right: 7.0.w, top: 8.h, bottom: 5.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 3.5.w),
                        child: FadeInDown(
                          from: 50,
                          child: isDarkMode()
                              ? SvgPicture.asset(
                                  Asset.ams_black_logo,
                                  fit: BoxFit.cover,
                                )
                              : SvgPicture.asset(
                                  Asset.ams_logo,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 6.5.w),
                        child: FadeInDown(
                          from: 50,
                          child: Text(
                            CommonConstant.ams,
                            style: TextStyle(
                                color: isDarkMode() ? white : black,
                                fontSize: 35.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: fontUrbanistBlack),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.0.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 2.w),
                        child: FadeInDown(
                          from: 50,
                          child: Text(
                            LoginScreenConstant.signInAccount,
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontFamily: opensans_Bold,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            getTitle(LoginScreenConstant.emailId),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.Email,
                                        controller: controller.emailctr,
                                        hintLabel:
                                            LoginScreenConstant.emailId_hint,
                                        onChanged: (val) {
                                          controller.validateEmail(val);
                                        },
                                        errorText:
                                            controller.emailModel.value.error,
                                        inputType: TextInputType.text,
                                      );
                                    }))),
                            getTitle(CommonConstant.password),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.Pass,
                                        controller: controller.passctr,
                                        hintLabel:
                                            LoginScreenConstant.enter_password,
                                        wantSuffix: true,
                                        isPassword: true,
                                        onChanged: (val) {
                                          controller.validatePassword(val);
                                        },
                                        fromObsecureText: "LOGIN",
                                        errorText:
                                            controller.passModel.value.error,
                                        inputType: TextInputType.text,
                                      );
                                    })))
                          ]),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(EmailScreen());
                            },
                            child: Text(
                              LoginScreenConstant.forgot_pass,
                              style: TextStyle(
                                  fontFamily: opensans_Bold,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      FadeInUp(
                          from: 50,
                          child: Obx(() {
                            return getFormButton(() {
                              if (controller.isFormInvalidate.value == true) {
                                controller.signInAPI(context);
                              }
                            }, "Sign In",
                                validate: controller.isFormInvalidate.value);
                          })),

                      // OR AND GOOGLE FACEBOOK

                      // SizedBox(
                      //   height: 4.5.h,
                      // ),
                      // FadeInUp(
                      //   from: 50,
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     mainAxisAlignment: MainAxisAlignment.center,

                      //     // ignore: prefer_const_literals_to_create_immutables
                      //     children: [
                      //       getDivider(),
                      //       Text(
                      //         'Or',
                      //         style: TextStyle(
                      //             fontFamily: opensans_Bold,
                      //             fontSize: 14.sp,
                      //             fontWeight: FontWeight.w700),
                      //       ),
                      //       getDivider(),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 1.h,
                      // ),
                      // FadeInUp(
                      //   from: 50,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Container(
                      //         height: 4.5.h,
                      //         width: 4.5.h,
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(20),
                      //             color: isDarkMode() ? white : black),
                      //         child: Icon(
                      //           FontAwesomeIcons.googlePlusG,
                      //           size: 16.sp,
                      //           color: isDarkMode() ? black : white,
                      //         ),
                      //       ),
                      //       SizedBox(width: 4.5.w),
                      //       Container(
                      //         height: 4.5.h,
                      //         width: 4.5.h,
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(20),
                      //             color: isDarkMode() ? white : black),
                      //         child: Icon(
                      //           FontAwesomeIcons.facebookF,
                      //           size: 16.sp,
                      //           color: isDarkMode() ? black : white,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      // SizedBox(
                      //   height: 3.7.h,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     FadeInUp(
                      //       from: 50,
                      //       child: RichText(
                      //           text: TextSpan(
                      //               style: TextStyle(
                      //                   color: isDarkMode() ? white : black,
                      //                   fontWeight: FontWeight.w500,
                      //                   fontFamily: opensansMedium,
                      //                   fontSize: 14.sp),
                      //               children: [
                      //             TextSpan(
                      //               text: Strings.havnt_account,
                      //             ),
                      //             TextSpan(
                      //                 text: Strings.sing_up,
                      //                 recognizer: TapGestureRecognizer()
                      //                   ..onTap = () {
                      //                     Get.to(SignupScreens());
                      //                   },
                      //                 style: TextStyle(
                      //                     decoration: TextDecoration.underline,
                      //                     decorationThickness: 1.5.sp,
                      //                     color:
                      //                         Color.fromARGB(255, 77, 180, 224),
                      //                     fontFamily: opensans_Bold,
                      //                     fontSize: 14.sp,
                      //                     fontWeight: FontWeight.w700)),
                      //           ])),
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ));
  }

  void _showInitialDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              getTitle("IP Address"),
              FadeInUp(
                  from: 30,
                  child: AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      child: Obx(() {
                        return getReactiveFormField(
                          node: controller.ipAddressNode,
                          controller: controller.ipCtr,
                          hintLabel: "Enter IP Address",
                          onChanged: (val) {},
                          errorText: controller.passModel.value.error,
                          inputType: TextInputType.emailAddress,
                        );
                      }))),
              SizedBox(
                height: 1.h,
              ),
              GestureDetector(
                onTap: () async {
                  String url = "http://";
                  String api = "/api/";
                  String finalUrl =
                      url + controller.ipCtr.text.toString().trim() + api;
                  String appendedString =
                      url + controller.ipCtr.text.toString().trim() + "/";
                  UserPreferences().setIP(finalUrl);
                  UserPreferences().setBuildIP(appendedString);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 5.h,
                  width: 40.w,
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(color: white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        SizerUtil.deviceType == DeviceType.mobile
                            ? 5.h
                            : 1.4.h),
                    color: black,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
