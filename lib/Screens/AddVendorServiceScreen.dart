import 'package:animate_do/animate_do.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controllers/AddVendorService_controller.dart';
import '../core/Common/appbar.dart';
import '../core/Common/toolbar.dart';
import '../core/constants/assets.dart';
import '../core/constants/strings.dart';
import '../custom_componannt/common_views.dart';
import '../custom_componannt/form_inputs.dart';

class AddVendorServiceScreen extends StatefulWidget {
  const AddVendorServiceScreen({super.key});

  @override
  State<AddVendorServiceScreen> createState() => _AddVendorServiceScreenState();
}

class _AddVendorServiceScreenState extends State<AddVendorServiceScreen> {
  final AddvendorserviceController = Get.put(AddVendorServiceController());

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
              getToolbar("Add Vendor Service",
                  showBackButton: true, notify: false, callback: () {
                Get.back();
              })
              // HomeAppBar(
              //   title: Strings.add_vendor_service,
              //   leading: Asset.backbutton,
              //   isfilter: false,
              //   icon: Asset.filter,
              //   isBack: true,
              //   onClick: () {
              //     Get.back();
              //   },
              // ),
            ])),
            Container(
              margin: EdgeInsets.only(top: 6.h, left: 1.0.w, right: 1.0.w),
              padding: EdgeInsets.only(
                  left: 7.0.w, right: 7.0.w, top: 2.h, bottom: 1.h),
              child: Form(
                  key: AddvendorserviceController.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getTitle(Strings.field),
                      FadeInUp(
                          from: 30,
                          child: AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              child: Obx(() {
                                return getReactiveFormField(
                                  node: AddvendorserviceController.FieldNode,
                                  controller:
                                      AddvendorserviceController.fieldctr,
                                  hintLabel: Strings.field_hint,
                                  wantSuffix: true,
                                  isDropdown: true,
                                  onChanged: (val) {
                                    AddvendorserviceController
                                        .validateFieldname(val);
                                  },
                                  errorText: AddvendorserviceController
                                      .FieldModel.value.error,
                                  inputType: TextInputType.text,
                                );
                              }))),
                      getTitle(Strings.time),
                      FadeInUp(
                          from: 30,
                          child: AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              child: Obx(() {
                                return getReactiveFormField(
                                  node: AddvendorserviceController.TimeNode,
                                  controller:
                                      AddvendorserviceController.timectr,
                                  hintLabel: Strings.time_hint,
                                  wantSuffix: true,
                                  isStarting: true,
                                  onChanged: (val) {
                                    AddvendorserviceController.validateTime(
                                        val);
                                    setState(() {});
                                  },
                                  errorText: AddvendorserviceController
                                      .TimeModel.value.error,
                                  inputType: TextInputType.text,
                                );
                              }))),
                      getTitle(Strings.approx),
                      FadeInUp(
                          from: 30,
                          child: AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              child: Obx(() {
                                return getReactiveFormField(
                                  node: AddvendorserviceController.ApproxNode,
                                  controller:
                                      AddvendorserviceController.approxctr,
                                  hintLabel: Strings.approx_hint,
                                  onChanged: (val) {
                                    AddvendorserviceController.validateApprox(
                                        val);
                                    setState(() {});
                                  },
                                  errorText: AddvendorserviceController
                                      .ApproxModel.value.error,
                                  inputType: TextInputType.text,
                                );
                              }))),
                      getTitle(Strings.duration),
                      FadeInUp(
                          from: 30,
                          child: AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              child: Obx(() {
                                return getReactiveFormField(
                                  node: AddvendorserviceController.DurationNode,
                                  controller:
                                      AddvendorserviceController.durationctr,
                                  hintLabel: Strings.duration_hint,
                                  wantSuffix: true,
                                  isStarting: true,
                                  onChanged: (val) {
                                    AddvendorserviceController.validateDuration(
                                        val);
                                    setState(() {});
                                  },
                                  errorText: AddvendorserviceController
                                      .DurationModel.value.error,
                                  inputType: TextInputType.text,
                                );
                              }))),
                      Container(
                          margin: EdgeInsets.only(top: 5.h),
                          width: double.infinity,
                          height: 6.h,
                          child: getButton(() {
                            if (AddvendorserviceController
                                .isFormInvalidate.value) {
                              // Get.to(Signup2());
                            }
                          })),
                    ],
                  )),
            ),
          ]),
        ));
  }
}
