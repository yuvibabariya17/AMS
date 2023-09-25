import 'package:animate_do/animate_do.dart';
import 'package:booking_app/controllers/UpdateVendor_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../core/Common/toolbar.dart';
import '../core/constants/strings.dart';
import '../custom_componannt/CustomeBackground.dart';
import '../custom_componannt/common_views.dart';
import '../custom_componannt/form_inputs.dart';

class UpdateVendor extends StatefulWidget {
  const UpdateVendor({super.key});

  @override
  State<UpdateVendor> createState() => _UpdateVendorState();
}

class _UpdateVendorState extends State<UpdateVendor> {
  @override
  void initState() {
    controller.initDataSet();
    super.initState();
  }

  final controller = Get.put(UpdateVendorController());

  
 
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          getCommonToolbar("Update Vendor", () {
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
                          getTitle(Strings.vendor_name),
                          FadeInUp(
                              from: 30,
                              child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: Obx(() {
                                    return getReactiveFormField(
                                      node: controller.VendornameNode,
                                      controller:
                                          controller.fullName.value.toString(),
                                      hintLabel: 'Enter Name',
                                      onChanged: (val) {
                                        controller.validateVendorname(val);
                                        setState(() {});
                                      },
                                      errorText: controller
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
                                      node: controller.CompanynameNode,
                                      controller: controller.companyctr,
                                      hintLabel: Strings.enter_company_name,
                                      onChanged: (val) {
                                        controller.validateCompanyname(val);
                                        setState(() {});
                                      },
                                      errorText:
                                          controller.companyModel.value.error,
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
                                      node: controller.CompanyAddressNode,
                                      controller: controller.addressctr,
                                      hintLabel: Strings.company_address_hint,
                                      isExpand: true,
                                      onChanged: (val) {
                                        controller.validateAddressname(val);
                                        setState(() {});
                                      },
                                      errorText:
                                          controller.addressModel.value.error,
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
                                      node: controller.EmailNode,
                                      controller: controller.emailctr,
                                      hintLabel: Strings.emailId_hint,
                                      onChanged: (val) {
                                        controller.validateEmail(val);
                                        setState(() {});
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
                                      node: controller.PassNode,
                                      controller: controller.passctr,
                                      hintLabel: Strings.pass_hint,
                                      onChanged: (val) {
                                        controller.validatePass(val);
                                        setState(() {});
                                      },
                                      wantSuffix: true,
                                      isPassword: true,
                                      fromObsecureText: "UPDATE VENDOR",
                                      errorText:
                                          controller.passModel.value.error,
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
                                      node: controller.Contact_oneNode,
                                      controller: controller.contact_onectr,
                                      formType: FieldType.Mobile,
                                      hintLabel: Strings.contact_no_hint,
                                      onChanged: (val) {
                                        controller.validatePhone1(val);
                                        setState(() {});
                                      },
                                      errorText: controller
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
                                      node: controller.Contact_twoNode,
                                      controller: controller.contact_twoctr,
                                      formType: FieldType.Mobile,
                                      hintLabel: Strings.contact_no_hint,
                                      onChanged: (val) {
                                        controller.validatePhone2(val);
                                        setState(() {});
                                      },
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.allow(
                                      //       RegExp("[0-9,+,' ']")),
                                      //   // MaskedTextInputFormatter(
                                      //   //   mask: 'xxxx xxxx xx',
                                      //   //   separator: ' ',
                                      //   // ),
                                      // ],
                                      errorText: controller
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
                                      node: controller.WhatsappNode,
                                      controller: controller.whatsappctr,
                                      formType: FieldType.Mobile,
                                      hintLabel: Strings.contact_no_hint,
                                      onChanged: (val) {
                                        controller.validatePhone3(val);
                                        setState(() {});
                                      },
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.allow(
                                      //       RegExp("[0-9,+,' ']")),
                                      //   // MaskedTextInputFormatter(
                                      //   //   mask: 'xxxx xxxx xx',
                                      //   //   separator: ' ',
                                      //   // ),
                                      // ],
                                      errorText:
                                          controller.whatsappModel.value.error,
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
                                      node: controller.LogoNode,
                                      controller: controller.logoctr,
                                      hintLabel: Strings.logo_hint,
                                      wantSuffix: true,
                                      onChanged: (val) {
                                        controller.validateLogo(val);
                                        setState(() {});
                                      },
                                      onTap: () async {
                                        await controller
                                            .actionClickUploadImage(context);
                                      },
                                      errorText:
                                          controller.logoModel.value.error,
                                      inputType: TextInputType.none,
                                    );
                                  }))),
                          getTitle(Strings.breachers),
                          FadeInUp(
                              from: 30,
                              child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: Obx(() {
                                    return getReactiveFormField(
                                      node: controller.BreachersNode,
                                      controller: controller.breacherctr,
                                      hintLabel: Strings.breachers_hint,
                                      wantSuffix: true,
                                      onChanged: (val) {
                                        controller.validateBreacher(val);
                                        setState(() {});
                                      },
                                      onTap: () async {
                                        await controller
                                            .actionClickUploadBreachers(
                                                context);
                                      },
                                      errorText:
                                          controller.breacherModel.value.error,
                                      inputType: TextInputType.none,
                                    );
                                  }))),
                          getTitle(Strings.profile),
                          FadeInUp(
                              from: 30,
                              child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: Obx(() {
                                    return getReactiveFormField(
                                      node: controller.ProfileNode,
                                      controller: controller.profilectr,
                                      hintLabel: Strings.profile_hint,
                                      wantSuffix: true,
                                      onChanged: (val) {
                                        controller.validateProfile(val);
                                        setState(() {});
                                      },
                                      onTap: () async {
                                        await controller
                                            .actionClickUploadProfile(context);
                                      },
                                      errorText:
                                          controller.profileModel.value.error,
                                      inputType: TextInputType.none,
                                    );
                                  }))),
                          getTitle(Strings.property),
                          FadeInUp(
                              from: 30,
                              child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: Obx(() {
                                    return getReactiveFormField(
                                      node: controller.PropertyNode,
                                      controller: controller.propertyctr,
                                      hintLabel: Strings.property_hint,
                                      wantSuffix: true,
                                      onChanged: (val) {
                                        controller.validateProperty(val);
                                        setState(() {});
                                      },
                                      onTap: () async {
                                        await controller
                                            .actionClickUploadProperty(context);
                                      },
                                      errorText:
                                          controller.propertyModel.value.error,
                                      inputType: TextInputType.none,
                                    );
                                  }))),
                          Container(
                              margin: EdgeInsets.only(top: 5.h),
                              width: double.infinity,
                              height: 6.h,
                              child: getButton(() {
                                if (controller.isFormInvalidate.value) {
                                  // Get.to(Signup2());
                                }
                              })),
                        ],
                      )),
                ),
              )
            ],
          ))
        ],
      ),
    );

    // Scaffold(
    //     resizeToAvoidBottomInset: false,
    //     extendBody: true,
    //     backgroundColor: Colors.white,
    //     body: SafeArea(
    //       minimum: EdgeInsets.only(top: 1.h),
    //       child: Stack(children: [
    //         SizedBox(
    //           height: double.infinity,
    //           width: double.infinity,
    //           child: isDarkMode()
    //               ? SvgPicture.asset(
    //                   Asset.dark_bg,
    //                   fit: BoxFit.cover,
    //                 )
    //               : SvgPicture.asset(
    //                   Asset.bg,
    //                   fit: BoxFit.cover,
    //                 ),
    //         ),
    //         SizedBox(
    //           height: 0.5.h,
    //         ),
    //         Center(
    //             child: Column(children: [
    //           getToolbar("Update Vendor", showBackButton: true, callback: () {
    //             Get.back();
    //           })
    //           // HomeAppBar(
    //           //   title: Strings.update_vendor,
    //           //   leading: Asset.backbutton,
    //           //   isfilter: false,
    //           //   icon: Asset.filter,
    //           //   isBack: true,
    //           //   onClick: () {
    //           //     Get.back();
    //           //   },
    //           // ),
    //         ])),
    //         SingleChildScrollView(
    //           child:
    //         ),
    //       ]),
    //     ));
  }
}
