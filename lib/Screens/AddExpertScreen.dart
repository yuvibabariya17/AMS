import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Screens/ExpertScreen.dart';
import 'package:booking_app/controllers/addexpert_controller.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../core/Common/toolbar.dart';
import '../core/constants/assets.dart';
import '../core/constants/strings.dart';
import '../custom_componannt/common_views.dart';
import '../custom_componannt/form_inputs.dart';

class AddExpertScreen extends StatefulWidget {
  const AddExpertScreen({super.key});

  @override
  State<AddExpertScreen> createState() => _AddExpertScreenState();
}

class _AddExpertScreenState extends State<AddExpertScreen> {
  final controller = Get.put(AddexpertController());
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
              getToolbar("Add Expert", showBackButton: true, notify: false,
                  callback: () {
                Get.back();
              })
              // HomeAppBar(
              //   title: "Add Experts",
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
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getTitle(Strings.expert),
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node: controller.ExpertNode,
                                    controller: controller.Expertctr,
                                    hintLabel: Strings.expert_hint,
                                    onChanged: (val) {
                                      controller.validateExpertname(val);
                                    },
                                    errorText:
                                        controller.ExpertModel.value.error,
                                    inputType: TextInputType.text,
                                  );
                                }))),
                        getTitle(Strings.service),
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node: controller.ServiceNode,
                                    controller: controller.Servicectr,
                                    hintLabel: Strings.service_hint,
                                    onChanged: (val) {
                                      controller.validateServicename(val);
                                    },
                                    errorText:
                                        controller.ServiceModel.value.error,
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
                                    node: controller.PriceNode,
                                    controller: controller.Pricectr,
                                    hintLabel: Strings.price_hint,
                                    onChanged: (val) {
                                      controller.validatePrice(val);
                                    },
                                    errorText:
                                        controller.PriceModel.value.error,
                                    inputType: TextInputType.number,
                                  );
                                }))),
                        FadeInUp(
                            from: 50,
                            child: Obx(() {
                              return getFormButton(() {
                                if (controller.isFormInvalidate.value == true) {
                                  controller.AddExpertApi(context);
                                }
                              }, Strings.submit,
                                  validate: controller.isFormInvalidate.value);
                            }))
                      ],
                    )),
              ),
            ),
          ]),
        ));
  }
}
