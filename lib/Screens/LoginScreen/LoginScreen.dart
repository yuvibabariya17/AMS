import 'package:animate_do/animate_do.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/screens/ChangepasswordScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  Widget build(BuildContext context) {
    Common().trasparent_statusbar();
    return GestureDetector(
        onTap: () {
          hideKeyboard(context);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
              child: Form(
                key: controller.formKey,
                child: Container(
                  padding: EdgeInsets.only(
                      left: 7.0.w, right: 7.0.w, top: 8.h, bottom: 5.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeInDown(
                        from: 50,
                        child: Center(
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
                        margin: EdgeInsets.only(right: 5.w),
                        child: FadeInDown(
                          from: 50,
                          child: Text(
                            Strings.title,
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
                            Strings.signInAccount,
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
                            getTitle(Strings.emailId),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.Email,
                                        controller: controller.emailctr,
                                        hintLabel: Strings.emailId_hint,
                                        onChanged: (val) {
                                          controller.validateEmail(val);
                                        },
                                        errorText:
                                            controller.emailModel.value.error,
                                        inputType: TextInputType.text,
                                      );
                                    }))),
                            getTitle(Strings.password),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.Pass,
                                        controller: controller.passctr,
                                        hintLabel: Strings.pass_hint,
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
                              Get.to(ChangePasswordScreen(
                                fromProfile: false,
                              ));
                            },
                            child: Text(
                              Strings.forgot_pass,
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
                      SizedBox(
                        height: 4.5.h,
                      ),
                      FadeInUp(
                        from: 50,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,

                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            getDivider(),
                            Text(
                              'Or',
                              style: TextStyle(
                                  fontFamily: opensans_Bold,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                            getDivider(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      FadeInUp(
                        from: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 4.5.h,
                              width: 4.5.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black),
                              child: Icon(
                                FontAwesomeIcons.googlePlusG,
                                size: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 4.5.w),
                            Container(
                              height: 4.5.h,
                              width: 4.5.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black),
                              child: Icon(
                                FontAwesomeIcons.facebookF,
                                size: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.7.h,
                      ),
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

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
