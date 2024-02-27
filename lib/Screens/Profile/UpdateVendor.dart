import 'package:animate_do/animate_do.dart';
import 'package:booking_app/controllers/UpdateVendor_controller.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:booking_app/models/SignInModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/Common/toolbar.dart';
import '../../core/constants/strings.dart';
import '../../core/utils/log.dart';
import '../../custom_componannt/CustomeBackground.dart';
import '../../custom_componannt/common_views.dart';
import '../../custom_componannt/form_inputs.dart';
import '../../preference/UserPreference.dart';

class UpdateVendor extends StatefulWidget {
  UpdateVendor({
    super.key,
  });

  @override
  State<UpdateVendor> createState() => _UpdateVendorState();
}

class _UpdateVendorState extends State<UpdateVendor> {
  @override
  void initState() {
    initDataSet(context);
    super.initState();
  }

  final controller = Get.put(UpdateVendorController());

  void initDataSet(BuildContext context) async {
    SignInData? retrievedObject = await UserPreferences().getSignInInfo();
    logcat("USERNAME", retrievedObject!.userName.toString());
    logcat("COMPANY", retrievedObject.companyName.toString());

    controller.Vendornamectr.text = retrievedObject!.userName.toString();
    controller.companyctr.text = retrievedObject.companyName.toString();
    controller.addressctr.text = retrievedObject.companyAddress.toString();
    //controller.statectr.text = retrievedObject.stateId.toString();
    //controller.cityctr.text = retrievedObject.cityId.toString();
    controller.emailctr.text = retrievedObject.emailId.toString();
    controller.contact_onectr.text = retrievedObject.contactNo1.toString();
    controller.contact_twoctr.text = retrievedObject.contactNo2.toString();
    controller.whatsappctr.text = retrievedObject.whatsappNo.toString();

    setState(() {});
  }

  void validateFields() {
    // Validate all fields here
    controller.validateVendorname(controller.Vendornamectr.text);
    controller.validateAddressname(controller.addressctr.text);
    controller.validateBreacher(controller.breacherctr.text);
    controller.validateCompanyname(controller.companyctr.text);
    controller.validateLogo(controller.logoctr.text);
    controller.validatePass(controller.passctr.text);
    controller.validatePhone1(controller.contact_onectr.text);
    controller.validateEmail(controller.emailctr.text);
    controller.validatePhone2(controller.contact_twoctr.text);
    controller.validatePhone3(controller.whatsappctr.text);

    controller.validateProfile(controller.profilectr.text);
    controller.validateProperty(controller.propertyctr.text);

    // Add validation for other fields as needed
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          getCommonToolbar(ScreenTitle.updateVendor, () {
            Get.back();
          }),
          Expanded(
              child: CustomScrollView(
            physics: BouncingScrollPhysics(),
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
                          getTitle(CommonConstant.vendor_name),
                          FadeInUp(
                              from: 30,
                              child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: Obx(() {
                                    return getReactiveFormField(
                                      node: controller.VendornameNode,
                                      controller: controller.Vendornamectr,
                                      hintLabel: 'Enter Name',
                                      onChanged: (val) {
                                       // controller.validateVendorname(val);
                                        setState(() {});
                                      },
                                      errorText: controller
                                          .vendornameModel.value.error,
                                      inputType: TextInputType.text,
                                    );
                                  }))),
                          getTitle(CommonConstant.company_title),
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
                                        //controller.validateCompanyname(val);
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
                                       // controller.validateAddressname(val);
                                        setState(() {});
                                      },
                                      errorText:
                                          controller.addressModel.value.error,
                                      inputType: TextInputType.text,
                                    );
                                  }))),
                          getTitle(CommonConstant.emailId),
                          FadeInUp(
                              from: 30,
                              child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: Obx(() {
                                    return getReactiveFormField(
                                      node: controller.EmailNode,
                                      controller: controller.emailctr,
                                      hintLabel: CommonConstant.emailId_hint,
                                      onChanged: (val) {
                                       // controller.validateEmail(val);
                                        setState(() {});
                                      },
                                      errorText:
                                          controller.emailModel.value.error,
                                      inputType: TextInputType.text,
                                    );
                                  }))),
                          getTitle(CommonConstant.password),
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
                                        //controller.validatePass(val);
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
                                      //formType: FieldType.Mobile,
                                      hintLabel: Strings.contact_no_hint,
                                      onChanged: (val) {
                                       // controller.validatePhone1(val);
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
                                      //formType: FieldType.Mobile,
                                      hintLabel: Strings.contact_no_hint,
                                      onChanged: (val) {
                                        //controller.validatePhone2(val);
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
                          getTitle(CommonConstant.whatsapp_no),
                          FadeInUp(
                              from: 30,
                              child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: Obx(() {
                                    return getReactiveFormField(
                                      node: controller.WhatsappNode,
                                      controller: controller.whatsappctr,
                                      // formType: FieldType.Mobile,
                                      hintLabel: Strings.contact_no_hint,
                                      onChanged: (val) {
                                        //controller.validatePhone3(val);
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
                                        //controller.validateLogo(val);
                                        setState(() {});
                                      },
                                      isReadOnly: true,
                                      onTap: () async {
                                        selectImageFromCameraOrGallery(context,
                                            cameraClick: () {
                                          controller
                                              .actionClickUploadImageForLogo(
                                                  context,
                                                  isCamera: true);
                                        }, galleryClick: () {
                                          controller
                                              .actionClickUploadImageForLogo(
                                                  context,
                                                  isCamera: false);
                                        });
                                        // await controller.PopupDialogs(context);
                                        setState(() {});
                                      },
                                      // onTap: () async {
                                      //   await controller
                                      //       .actionClickUploadImage(context);
                                      // },
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
                                      isReadOnly: true,
                                      onTap: () async {
                                        selectImageFromCameraOrGallery(context,
                                            cameraClick: () {
                                          controller
                                              .actionClickUploadImageForBreachers(
                                                  context,
                                                  isCamera: true);
                                        }, galleryClick: () {
                                          controller
                                              .actionClickUploadImageForBreachers(
                                                  context,
                                                  isCamera: false);
                                        });
                                        // await controller.PopupDialogs(context);
                                        setState(() {});
                                      },
                                      // onTap: () async {
                                      //   await controller
                                      //       .actionClickUploadBreachers(
                                      //           context);
                                      // },
                                      errorText:
                                          controller.breacherModel.value.error,
                                      inputType: TextInputType.none,
                                    );
                                  }))),
                          getTitle(UpdateVendorConstant.profile),
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
                                      isReadOnly: true,
                                      onTap: () async {
                                        selectImageFromCameraOrGallery(context,
                                            cameraClick: () {
                                          controller
                                              .actionClickUploadImageForProfile(
                                                  context,
                                                  isCamera: true);
                                        }, galleryClick: () {
                                          controller
                                              .actionClickUploadImageForProfile(
                                                  context,
                                                  isCamera: false);
                                        });
                                        // await controller.PopupDialogs(context);
                                        setState(() {});
                                      },
                                      // onTap: () async {
                                      //   await controller
                                      //       .actionClickUploadProfile(context);
                                      // },
                                      errorText:
                                          controller.profileModel.value.error,
                                      inputType: TextInputType.none,
                                    );
                                  }))),
                          // getTitle(Strings.property),
                          // FadeInUp(
                          //     from: 30,
                          //     child: AnimatedSize(
                          //         duration: const Duration(milliseconds: 300),
                          //         child: Obx(() {
                          //           return getReactiveFormField(
                          //             node: controller.PropertyNode,
                          //             controller: controller.propertyctr,
                          //             hintLabel: Strings.property_hint,
                          //             wantSuffix: true,
                          //             onChanged: (val) {
                          //               controller.validateProperty(val);
                          //               setState(() {});
                          //             },
                          //             isReadOnly: true,
                          //             onTap: () async {
                          //               selectImageFromCameraOrGallery(context,
                          //                   cameraClick: () {
                          //                 controller
                          //                     .actionClickUploadImageFromCamera(
                          //                         context, true,
                          //                         multipleImage: true,
                          //                         isCamera: true);
                          //               }, galleryClick: () {
                          //                 controller
                          //                     .actionClickUploadImageFromCamera(
                          //                         context, true,
                          //                         multipleImage: true,
                          //                         isCamera: false);
                          //               });
                          //               // await controller.PopupDialogs(context);
                          //               setState(() {});
                          //             },
                          //             // onTap: () async {
                          //             //   await controller
                          //             //       .actionClickUploadProperty(context);
                          //             // },
                          //             errorText:
                          //                 controller.propertyModel.value.error,
                          //             inputType: TextInputType.none,
                          //           );
                          //         }))),
                        
                          SizedBox(
                            height: 3.h,
                          ),
                          FadeInUp(
                              from: 50,
                              child: Obx(() {
                                return getFormButton(() {
                                  if (controller.isFormInvalidate.value ==
                                      true) {
                                    controller.UpdateVendorApi(context);
                                  }
                                }, CommonConstant.submit,
                                    validate:
                                        controller.isFormInvalidate.value);
                              }))
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
