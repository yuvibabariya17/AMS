import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Screens/LoginScreen/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/ChangePassword_controller.dart';
import '../core/Common/toolbar.dart';
import '../core/constants/assets.dart';
import '../core/constants/strings.dart';
import '../custom_componannt/CustomeBackground.dart';
import '../custom_componannt/common_views.dart';
import '../custom_componannt/form_inputs.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({super.key, this.fromProfile});
  bool? fromProfile;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.hideKeyboard(context);
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
          key: controller.resetpasskey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            getCommonToolbar(
                widget.fromProfile == false
                    ? "Forgot Password"
                    : ScreenTitle.changePassTitle, () {
              Get.back();
            }),
            SizedBox(
              height: 3.5.h,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 7.0.w,
                      right: 7.0.w,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Asset.changepass,
                            height: 25.h,
                            width: 15.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 7.0.w, right: 7.0.w, top: 3.h, bottom: 3.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.fromProfile == true)
                          getTitle(ChangePassConstant.previous_pass),
                        widget.fromProfile == true
                            ? FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.currentpassNode,
                                        controller: controller.currentCtr,
                                        hintLabel:
                                            ChangePassConstant.currentPassHint,
                                        wantSuffix: true,
                                        isPassword: true,
                                        onChanged: (val) {
                                          controller.validateCurrentPass(val);
                                        },
                                        index: "0",
                                        fromObsecureText: "RESETPASS",
                                        errorText: controller
                                            .currentPassModel.value.error,
                                        inputType: TextInputType.text,
                                      );
                                    })))
                            : Container(),
                        getTitle(ChangePassConstant.new_pass),
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node: controller.newpassNode,
                                    controller: controller.newpassCtr,
                                    hintLabel: ChangePassConstant.passHint,
                                    wantSuffix: true,
                                    isPassword: true,
                                    onChanged: (val) {
                                      widget.fromProfile == true
                                          ? controller.validateNewPass(val)
                                          : controller.validateNewPassword(val);
                                    },
                                    index: "1",
                                    fromObsecureText: "RESETPASS",
                                    errorText:
                                        controller.newPassModel.value.error,
                                    inputType: TextInputType.text,
                                  );
                                }))),
                        getTitle(ChangePassConstant.confirm_new_pass),
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node: controller.confirmpassNode,
                                    controller: controller.confirmCtr,
                                    hintLabel:
                                        ChangePassConstant.confirmPassHint,
                                    onChanged: (val) {
                                      widget.fromProfile == true
                                          ? controller.validateConfirmPass(val)
                                          : controller.validateForgotPass(val);
                                    },
                                    index: "2",
                                    fromObsecureText: "RESETPASS",
                                    wantSuffix: true,
                                    isPassword: true,
                                    errorText:
                                        controller.confirmPassModel.value.error,
                                    inputType: TextInputType.text,
                                  );
                                }))),
                        SizedBox(height: 5.0.h),
                        FadeInUp(
                          from: 50,
                          child: Obx(() {
                            return widget.fromProfile == false
                                ? getFormButton(
                                    () {
                                      if (controller.isFormInvalidate.value ==
                                          true) {
                                        Get.to(LoginScreen());
                                      }
                                    },
                                    CommonConstant.done,
                                    validate: widget.fromProfile == true
                                        ? controller.isFormInvalidate.value
                                        : controller
                                            .isForgotPasswordValidate.value,
                                  )
                                : getFormButton(
                                    () {
                                      if (controller.isFormInvalidate.value ==
                                          true) {
                                        controller.ChangePasswordApi(
                                            context, true);
                                      }
                                    },
                                    CommonConstant.done,
                                    validate: widget.fromProfile == true
                                        ? controller.isFormInvalidate.value
                                        : controller
                                            .isForgotPasswordValidate.value,
                                  );
                          }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
        ))
      ])),
    );
  }
}
