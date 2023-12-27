import 'package:animate_do/animate_do.dart';
import 'package:booking_app/controllers/AddCustomer_controller.dart';
import 'package:booking_app/custom_componannt/customeBackground.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../core/Common/toolbar.dart';
import '../core/constants/strings.dart';
import '../custom_componannt/common_views.dart';
import '../custom_componannt/form_inputs.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final controller = Get.put(AddCustomerController());

  @override
  void dispose() {
    controller.Customerctr.text = "";
    controller.Profilectr.text = "";
    controller.Dobctr.text = "";
    controller.Doactr.text = "";
    controller.Addressctr.text = "";
    controller.Contact1ctr.text = "";
    controller.Contact2ctr.text = "";
    controller.Whatsappctr.text = "";
    controller.Emailctr.text = "";

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.hideKeyboard(context);
      },
      child: CustomScaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getCommonToolbar(ScreenTitle.addCustomer, () {
              Get.back();
            }),
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(left: 1.0.w, right: 1.0.w),
                      padding: EdgeInsets.only(
                          left: 7.0.w, right: 7.0.w, top: 1.h, bottom: 5.h),
                      child: Form(
                          key: controller.formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getTitle(CommonConstant.customer),
                              FadeInUp(
                                  from: 30,
                                  child: AnimatedSize(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Obx(() {
                                        return getReactiveFormField(
                                          node: controller.CustomerNode,
                                          controller: controller.Customerctr,
                                          hintLabel:
                                              AddCustomerConstant.enter_name,
                                          onChanged: (val) {
                                            controller
                                                .validateCustomerName(val);
                                          },
                                          errorText: controller
                                              .customerModel.value.error,
                                          inputType: TextInputType.text,
                                        );
                                      }))),
                              getTitle(Strings.profile_photo),
                              FadeInUp(
                                  from: 30,
                                  child: AnimatedSize(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Obx(() {
                                        return getReactiveFormField(
                                          node: controller.ProfileNode,
                                          controller: controller.Profilectr,
                                          hintLabel: Strings.profile_photo_hint,
                                          wantSuffix: true,
                                          onChanged: (val) {
                                            controller.validateProfile(val);
                                          },
                                          isReadOnly: true,
                                          onTap: () async {
                                            selectImageFromCameraOrGallery(
                                                context, cameraClick: () {
                                              controller
                                                  .actionClickUploadImageFromCamera(
                                                      context,
                                                      isCamera: true);
                                            }, galleryClick: () {
                                              controller
                                                  .actionClickUploadImageFromCamera(
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
                                          errorText: controller
                                              .profileModel.value.error,
                                          inputType: TextInputType.text,
                                        );
                                      }))),
                              getTitle(Strings.dob),
                              FadeInUp(
                                  from: 30,
                                  child: AnimatedSize(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Obx(() {
                                        return getReactiveFormField(
                                          node: controller.DobNode,
                                          controller: controller.Dobctr,
                                          hintLabel: Strings.dob_hint,
                                          wantSuffix: true,
                                          isCalender: true,
                                          onChanged: (val) {
                                            controller.validateDob(val);
                                            setState(() {});
                                          },
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate:
                                                        controller.selectedDate,
                                                    firstDate: DateTime(1950),
                                                    lastDate: DateTime.now()
                                                        .add(const Duration(
                                                            days: 0)));
                                            if (pickedDate != null &&
                                                pickedDate !=
                                                    controller.selectedDate) {
                                              setState(() {
                                                controller.selectedDate =
                                                    pickedDate;
                                              });
                                            }
                                            if (pickedDate != null) {
                                              String formattedDate = DateFormat(
                                                      Strings.oldDateFormat)
                                                  .format(pickedDate);
                                              controller
                                                  .updateDate(formattedDate);
                                              controller
                                                  .validateDob(formattedDate);
                                            }
                                          },
                                          errorText:
                                              controller.dobModel.value.error,
                                          inputType: TextInputType.text,
                                        );
                                      }))),
                              getTitle(Strings.doa),
                              FadeInUp(
                                  from: 30,
                                  child: AnimatedSize(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Obx(() {
                                        return getReactiveFormField(
                                          node: controller.DoaNode,
                                          controller: controller.Doactr,
                                          hintLabel: Strings.dob_hint,
                                          wantSuffix: true,
                                          isCalender: true,
                                          onChanged: (val) {
                                            controller.validateDoa(val);
                                            setState(() {});
                                          },
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: controller
                                                        .selectedAnniversaryDate,
                                                    firstDate: DateTime(1950),
                                                    lastDate: DateTime.now()
                                                        .add(const Duration(
                                                            days: 0)));
                                            if (pickedDate != null &&
                                                pickedDate !=
                                                    controller
                                                        .selectedAnniversaryDate) {
                                              setState(() {
                                                controller
                                                        .selectedAnniversaryDate =
                                                    pickedDate;
                                              });
                                            }
                                            if (pickedDate != null) {
                                              String formattedDate = DateFormat(
                                                      Strings.oldDateFormat)
                                                  .format(pickedDate);
                                              controller.updateAnniversaryDate(
                                                  formattedDate);
                                              controller
                                                  .validateDoa(formattedDate);
                                            }
                                          },
                                          errorText:
                                              controller.doaModel.value.error,
                                          inputType: TextInputType.text,
                                        );
                                      }))),
                              getTitle(Strings.address),
                              FadeInUp(
                                  from: 30,
                                  child: AnimatedSize(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Obx(() {
                                        return getReactiveFormField(
                                          node: controller.AddressNode,
                                          controller: controller.Addressctr,
                                          hintLabel: Strings.enteraddress,
                                          onChanged: (val) {
                                            controller.validateAddree(val);
                                            setState(() {});
                                          },
                                          isExpand: true,
                                          errorText: controller
                                              .addressModel.value.error,
                                          inputType: TextInputType.text,
                                        );
                                      }))),
                              getTitle(Strings.contact_no_one),
                              FadeInUp(
                                  from: 30,
                                  child: AnimatedSize(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Obx(() {
                                        return getReactiveFormField(
                                          node: controller.Contact1Node,
                                          controller: controller.Contact1ctr,
                                          hintLabel: Strings.contact_no_hint,
                                          onChanged: (val) {
                                            controller.validateContact1(val);
                                            setState(() {});
                                          },
                                          errorText: controller
                                              .contact1Model.value.error,
                                          inputType: TextInputType.number,
                                        );
                                      }))),
                              // getTitle(Strings.contact_no_two),
                              // FadeInUp(
                              //     from: 30,
                              //     child: AnimatedSize(
                              //         duration:
                              //             const Duration(milliseconds: 300),
                              //         child: Obx(() {
                              //           return getReactiveFormField(
                              //             node: controller.Contact2Node,
                              //             controller:
                              //                 controller.Contact2ctr,
                              //             hintLabel:
                              //                 Strings.contact_no_hint,
                              //             onChanged: (val) {
                              //               controller
                              //                   .validateContact2(val);
                              //               setState(() {});
                              //             },
                              //             errorText: controller
                              //                 .contact2Model.value.error,
                              //             inputType: TextInputType.text,
                              //           );
                              //         }))),
                              getTitle(CommonConstant.whatsapp_no),
                              FadeInUp(
                                  from: 30,
                                  child: AnimatedSize(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Obx(() {
                                        return getReactiveFormField(
                                          node: controller.WhatsappNode,
                                          controller: controller.Whatsappctr,
                                          hintLabel: Strings.whatsapp_hint,
                                          onChanged: (val) {
                                            controller.validateWhatsapp(val);
                                            setState(() {});
                                          },
                                          errorText: controller
                                              .whatsappModel.value.error,
                                          inputType: TextInputType.number,
                                        );
                                      }))),
                              getTitle(CommonConstant.emailId),
                              FadeInUp(
                                  from: 30,
                                  child: AnimatedSize(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Obx(() {
                                        return getReactiveFormField(
                                          node: controller.EmailNode,
                                          controller: controller.Emailctr,
                                          hintLabel:
                                              CommonConstant.emailId_hint,
                                          onChanged: (val) {
                                            controller.validateEmail(val);
                                            setState(() {});
                                          },
                                          errorText:
                                              controller.emailModel.value.error,
                                          inputType: TextInputType.text,
                                        );
                                      }))),
                              SizedBox(
                                height: 5.h,
                              ),
                              FadeInUp(
                                  from: 50,
                                  child: Obx(() {
                                    return getFormButton(() {
                                      if (controller.isFormInvalidate.value ==
                                          true) {
                                        controller.addcustomerApi(context);
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
