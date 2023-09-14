import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Screens/ServiceScreen.dart';
import 'package:booking_app/controllers/addservice_controller.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../core/Common/appbar.dart';
import '../core/Common/toolbar.dart';
import '../core/constants/assets.dart';
import '../core/constants/strings.dart';
import '../custom_componannt/common_views.dart';
import '../custom_componannt/form_inputs.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final Addservicecontroller = Get.put(AddserviceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: Colors.white,
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
              getToolbar("Add Service", showBackButton: true, notify: false,
                  callback: () {
                Get.back();
              })
              // HomeAppBar(
              //   title: "Add Services",
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
              child: Container(
                margin: EdgeInsets.only(top: 6.h, left: 1.0.w, right: 1.0.w),
                padding: EdgeInsets.only(
                    left: 7.0.w, right: 7.0.w, top: 2.h, bottom: 1.h),
                child: Form(
                    key: Addservicecontroller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getTitle(Strings.service),
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node: Addservicecontroller.ServiceNode,
                                    controller: Addservicecontroller.Servicectr,
                                    hintLabel: Strings.service_hint,
                                    onChanged: (val) {
                                      Addservicecontroller.validateServicename(
                                          val);
                                    },
                                    errorText: Addservicecontroller
                                        .ServiceModel.value.error,
                                    inputType: TextInputType.text,
                                  );
                                }))),
                        getTitle(Strings.expert),
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node: Addservicecontroller.ExpertNode,
                                    controller: Addservicecontroller.Expertctr,
                                    hintLabel: Strings.expert_hint,
                                    onChanged: (val) {
                                      Addservicecontroller.validateExpertname(
                                          val);
                                      setState(() {});
                                    },
                                    errorText: Addservicecontroller
                                        .ExpertModel.value.error,
                                    inputType: TextInputType.text,
                                  );
                                }))),
                        getTitle(Strings.price),
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node: Addservicecontroller.PriceNode,
                                    controller: Addservicecontroller.Pricectr,
                                    hintLabel: Strings.price_hint,
                                    onChanged: (val) {
                                      Addservicecontroller.validatePrice(val);
                                      setState(() {});
                                    },
                                    errorText: Addservicecontroller
                                        .PriceModel.value.error,
                                    inputType: TextInputType.text,
                                  );
                                }))),
                        Container(
                            margin: EdgeInsets.only(top: 5.h),
                            width: double.infinity,
                            height: 6.h,
                            child: getButton(() {
                              Get.to(ServiceScreen());
                            })),
                      ],
                    )),
              ),
            ),
          ]),
        ));
  }
}
