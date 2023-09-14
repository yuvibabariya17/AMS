import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Screens/LoginScreen/LoginScreen.dart';
import 'package:booking_app/controllers/sign_up_controller.dart';
import 'package:booking_app/core/Common/appbar.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/custom_componannt/common_views.dart';
import 'package:booking_app/custom_componannt/form_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../core/Common/toolbar.dart';
import '../../core/utils/helper.dart';

class SignupScreens extends StatefulWidget {
  const SignupScreens({super.key});

  @override
  State<SignupScreens> createState() => _SignupScreensState();
}

class _SignupScreensState extends State<SignupScreens> {
  final signinController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: SafeArea(
          minimum: EdgeInsets.only(top: 1.h),
          child: Stack(children: [
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
            SizedBox(
              height: 0.5.h,
            ),
            Center(
                child: Column(children: [
              getToolbar("Add Vendor Service", showBackButton: true,
                  callback: () {
                Get.back();
              })
              // HomeAppBar(
              //   title: Strings.add_vendor,
              //   leading: Asset.backbutton,
              //   isfilter: false,
              //   icon: Asset.filter,
              //   isBack: true,
              //   onClick: () {
              //     Get.back();
              //   },
              // ),
            ])),
            SingleChildScrollView(
              child: Form(
                key: signinController.formKey,
                child: Container(
                  margin: EdgeInsets.only(top: 6.h, left: 1.0.w, right: 1.0.w),
                  padding: EdgeInsets.only(
                      left: 7.0.w, right: 7.0.w, top: 2.h, bottom: 1.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getTitle(Strings.vendor_name),
                      FadeInUp(
                          from: 30,
                          child: AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              child: Obx(() {
                                return getReactiveFormField(
                                  node: signinController.vendorNameNode,
                                  controller: signinController.vendorNameCtr,
                                  hintLabel: 'Enter Name',
                                  onChanged: (val) {
                                    signinController.validateVendorname(val);
                                  },
                                  errorText: signinController
                                      .vendorNameModel.value.error,
                                  inputType: TextInputType.text,
                                );
                              }))),
                      getTitle(Strings.company_title),
                      FadeInUp(
                          from: 30,
                          child: AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              child: Obx(() {
                                return getReactiveFormField(
                                  node: signinController.companyNameNode,
                                  controller: signinController.companyNameCtr,
                                  hintLabel: Strings.enter_company_name,
                                  onChanged: (val) {
                                    signinController.validateCompanyname(val);
                                    setState(() {});
                                  },
                                  errorText: signinController
                                      .companyNameModel.value.error,
                                  inputType: TextInputType.text,
                                );
                              }))),
                      getTitle(Strings.company_address),
                      FadeInUp(
                          from: 30,
                          child: AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              child: Obx(() {
                                return getReactiveFormField(
                                  node: signinController.addressNode,
                                  controller: signinController.addressCtr,
                                  hintLabel: Strings.company_address_hint,
                                  onChanged: (val) {
                                    signinController.validateAddressname(val);
                                    setState(() {});
                                  },
                                  isExpand: true,
                                  errorText:
                                      signinController.addressModel.value.error,
                                  inputType: TextInputType.text,
                                );
                              }))),
                      getTitle(Strings.emailId),
                      FadeInUp(
                          from: 30,
                          child: AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              child: Obx(() {
                                return getReactiveFormField(
                                  node: signinController.emailNode,
                                  controller: signinController.emailCtr,
                                  hintLabel: Strings.emailId_hint,
                                  onChanged: (val) {
                                    signinController.validateEmail(val);
                                    setState(() {});
                                  },
                                  errorText:
                                      signinController.emailModel.value.error,
                                  inputType: TextInputType.text,
                                );
                              }))),
                      getTitle(Strings.contact_no),
                      FadeInUp(
                          from: 30,
                          child: AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              child: Obx(() {
                                return getReactiveFormField(
                                  node: signinController.contactNode,
                                  controller: signinController.contactCtr,
                                  formType: FieldType.Mobile,
                                  hintLabel: Strings.contact_no_hint,
                                  onChanged: (val) {
                                    signinController.validatePhone(val);
                                    setState(() {});
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9,+,' ']")),
                                    // MaskedTextInputFormatter(
                                    //   mask: 'xxxx xxxx xx',
                                    //   separator: ' ',
                                    // ),
                                  ],
                                  errorText: signinController
                                      .mobileNoModel.value.error,
                                  inputType: TextInputType.number,
                                );
                              }))),
                      Container(
                          margin: EdgeInsets.only(top: 5.h),
                          width: double.infinity,
                          height: 6.h,
                          child: getButton(() {
                            if (signinController.isFormInvalidate.value) {
                              Get.to(LoginScreen());
                            } else {
                              Get.to(LoginScreen());
                            }
                          })),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
