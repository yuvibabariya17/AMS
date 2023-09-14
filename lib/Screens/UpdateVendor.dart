import 'package:animate_do/animate_do.dart';
import 'package:booking_app/controllers/UpdateVendor_controller.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../core/Common/appbar.dart';
import '../core/Common/toolbar.dart';
import '../core/constants/assets.dart';
import '../core/constants/strings.dart';
import '../custom_componannt/common_views.dart';
import '../custom_componannt/form_inputs.dart';

class UpdateVendor extends StatefulWidget {
  const UpdateVendor({super.key});

  @override
  State<UpdateVendor> createState() => _UpdateVendorState();
}

class _UpdateVendorState extends State<UpdateVendor> {
  final UpdatevendorController = Get.put(UpdateVendorController());
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
              getToolbar("Update Vendor", showBackButton: true, callback: () {
                Get.back();
              })
              // HomeAppBar(
              //   title: Strings.update_vendor,
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
                    key: UpdatevendorController.formKey,
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
                                    node: UpdatevendorController.VendornameNode,
                                    controller:
                                        UpdatevendorController.Vendornamectr,
                                    hintLabel: 'Enter Name',
                                    onChanged: (val) {
                                      UpdatevendorController.validateVendorname(
                                          val);
                                      setState(() {});
                                    },
                                    errorText: UpdatevendorController
                                        .vendornameModel.value.error,
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
                                    node:
                                        UpdatevendorController.CompanynameNode,
                                    controller:
                                        UpdatevendorController.companyctr,
                                    hintLabel: Strings.enter_company_name,
                                    onChanged: (val) {
                                      UpdatevendorController
                                          .validateCompanyname(val);
                                      setState(() {});
                                    },
                                    errorText: UpdatevendorController
                                        .companyModel.value.error,
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
                                    node: UpdatevendorController
                                        .CompanyAddressNode,
                                    controller:
                                        UpdatevendorController.addressctr,
                                    hintLabel: Strings.company_address_hint,
                                    isExpand: true,
                                    onChanged: (val) {
                                      UpdatevendorController
                                          .validateAddressname(val);
                                      setState(() {});
                                    },
                                    errorText: UpdatevendorController
                                        .addressModel.value.error,
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
                                    node: UpdatevendorController.EmailNode,
                                    controller: UpdatevendorController.emailctr,
                                    hintLabel: Strings.emailId_hint,
                                    onChanged: (val) {
                                      UpdatevendorController.validateEmail(val);
                                      setState(() {});
                                    },
                                    errorText: UpdatevendorController
                                        .emailModel.value.error,
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
                                    node: UpdatevendorController.PassNode,
                                    controller: UpdatevendorController.passctr,
                                    hintLabel: Strings.pass_hint,
                                    onChanged: (val) {
                                      UpdatevendorController.validatePass(val);
                                      setState(() {});
                                    },
                                    errorText: UpdatevendorController
                                        .passModel.value.error,
                                    inputType: TextInputType.text,
                                  );
                                }))),
                        getTitle(Strings.contact_no_one),
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node:
                                        UpdatevendorController.Contact_oneNode,
                                    controller:
                                        UpdatevendorController.contact_onectr,
                                    formType: FieldType.Mobile,
                                    hintLabel: Strings.contact_no_hint,
                                    onChanged: (val) {
                                      UpdatevendorController.validatePhone1(
                                          val);
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
                                    errorText: UpdatevendorController
                                        .contactoneModel.value.error,
                                    inputType: TextInputType.number,
                                  );
                                }))),
                        getTitle(Strings.contact_no_two),
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node:
                                        UpdatevendorController.Contact_twoNode,
                                    controller:
                                        UpdatevendorController.contact_twoctr,
                                    formType: FieldType.Mobile,
                                    hintLabel: Strings.contact_no_hint,
                                    onChanged: (val) {
                                      UpdatevendorController.validatePhone2(
                                          val);
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
                                    errorText: UpdatevendorController
                                        .contacttwoModel.value.error,
                                    inputType: TextInputType.number,
                                  );
                                }))),
                        getTitle(Strings.whatsapp_no),
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node: UpdatevendorController.WhatsappNode,
                                    controller:
                                        UpdatevendorController.whatsappctr,
                                    formType: FieldType.Mobile,
                                    hintLabel: Strings.contact_no_hint,
                                    onChanged: (val) {
                                      UpdatevendorController.validatePhone3(
                                          val);
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
                                    errorText: UpdatevendorController
                                        .whatsappModel.value.error,
                                    inputType: TextInputType.number,
                                  );
                                }))),
                        getTitle(Strings.logo),
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node: UpdatevendorController.LogoNode,
                                    controller: UpdatevendorController.logoctr,
                                    hintLabel: Strings.logo_hint,
                                    wantSuffix: true,
                                    onChanged: (val) {
                                      UpdatevendorController.validateLogo(val);
                                      setState(() {});
                                    },
                                    errorText: UpdatevendorController
                                        .logoModel.value.error,
                                    inputType: TextInputType.text,
                                  );
                                }))),
                        getTitle(Strings.breachers),
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node: UpdatevendorController.BreachersNode,
                                    controller:
                                        UpdatevendorController.breacherctr,
                                    hintLabel: Strings.breachers_hint,
                                    wantSuffix: true,
                                    onChanged: (val) {
                                      UpdatevendorController.validateBreacher(
                                          val);
                                      setState(() {});
                                    },
                                    errorText: UpdatevendorController
                                        .breacherModel.value.error,
                                    inputType: TextInputType.text,
                                  );
                                }))),
                        getTitle(Strings.profile),
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node: UpdatevendorController.ProfileNode,
                                    controller:
                                        UpdatevendorController.profilectr,
                                    hintLabel: Strings.profile_hint,
                                    wantSuffix: true,
                                    onChanged: (val) {
                                      UpdatevendorController.validateProfile(
                                          val);
                                      setState(() {});
                                    },
                                    errorText: UpdatevendorController
                                        .profileModel.value.error,
                                    inputType: TextInputType.text,
                                  );
                                }))),
                        getTitle(Strings.property),
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node: UpdatevendorController.PropertyNode,
                                    controller:
                                        UpdatevendorController.propertyctr,
                                    hintLabel: Strings.property_hint,
                                    wantSuffix: true,
                                    onChanged: (val) {
                                      UpdatevendorController.validateProperty(
                                          val);
                                      setState(() {});
                                    },
                                    errorText: UpdatevendorController
                                        .propertyModel.value.error,
                                    inputType: TextInputType.text,
                                  );
                                }))),
                        Container(
                            margin: EdgeInsets.only(top: 5.h),
                            width: double.infinity,
                            height: 6.h,
                            child: getButton(() {
                              if (UpdatevendorController
                                  .isFormInvalidate.value) {
                                // Get.to(Signup2());
                              }
                            })),
                      ],
                    )),
              ),
            ),
          ]),
        ));
  }
}
