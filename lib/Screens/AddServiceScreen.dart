import 'package:animate_do/animate_do.dart';
import 'package:booking_app/controllers/AddService_controller.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../core/Common/toolbar.dart';
import '../core/constants/strings.dart';
import '../custom_componannt/common_views.dart';
import '../custom_componannt/form_inputs.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final controller = Get.put(AddserviceController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Column(
      children: [
        getCommonToolbar("Add Service", () {
          Get.back();
        }),
        Expanded(
            child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(left: 1.0.w, right: 1.0.w),
                padding: EdgeInsets.only(
                    left: 7.0.w, right: 7.0.w, top: 2.h, bottom: 1.h),
                child: Form(
                    key: controller.formKey,
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
                                      setState(() {});
                                    },
                                    errorText:
                                        controller.ExpertModel.value.error,
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
                                      setState(() {});
                                    },
                                    errorText:
                                        controller.PriceModel.value.error,
                                    inputType: TextInputType.number,
                                  );
                                }))),
                        SizedBox(
                          height: 4.h,
                        ),
                        FadeInUp(
                            from: 50,
                            child: Obx(() {
                              return getFormButton(() {
                                if (controller.isFormInvalidate.value == true) {
                                  controller.addServiceApi(context);
                                }
                              }, Strings.submit,
                                  validate: controller.isFormInvalidate.value);
                            }))
                      ],
                    )),
              ),
            )
          ],
        ))
      ],
    ));
  }
}
