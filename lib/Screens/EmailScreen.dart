import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Screens/OtpScreen.dart';
import 'package:booking_app/controllers/EmailController.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/custom_componannt/common_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../core/Common/toolbar.dart';
import '../custom_componannt/CustomeBackground.dart';
import '../custom_componannt/form_inputs.dart';

class EmailScreen extends StatefulWidget {
  EmailScreen({
    super.key,
  });

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final controller = Get.put(EmailController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.hideKeyboard(context);
      },
      child: CustomScaffold(
          // resizeToAvoidBottomInset: false,
          body: Stack(children: [
        SingleChildScrollView(
            child: Form(
          key: controller.resetpasskey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            getViewProfile("Email", showBackButton: true, callback: () {
              Get.back();
            }),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: SizerUtil.deviceType == DeviceType.mobile
                        ? EdgeInsets.only(
                            left: 6.0.w,
                            right: 7.0.w,
                          )
                        : EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Asset.email,
                            height: SizerUtil.deviceType == DeviceType.mobile
                                ? 20.h
                                : 14.h,
                            width: SizerUtil.deviceType == DeviceType.mobile
                                ? 15.h
                                : 14.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 7.0.w, right: 7.0.w, bottom: 3.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node: controller.emailNode,
                                    controller: controller.emailctr,
                                    hintLabel: "Enter Email",
                                    onChanged: (val) {
                                      controller.validateEmail(val);
                                    },
                                    errorText:
                                        controller.emailModel.value.error,
                                    inputType: TextInputType.text,
                                  );
                                }))),
                        SizedBox(
                          height: 3.h,
                        ),
                        FadeInUp(
                          from: 50,
                          child: Obx(() {
                            return getFormButton(() {
                              if (controller.isFormInvalidate.value == true) {
                                Get.to(OtpScreen());
                              }
                            }, CommonConstant.done,
                                validate: controller.isFormInvalidate.value);
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
