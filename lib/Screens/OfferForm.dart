import 'package:animate_do/animate_do.dart';
import 'package:booking_app/controllers/OfferFormController.dart';
import 'package:booking_app/core/Common/toolbar.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:booking_app/custom_componannt/common_views.dart';
import 'package:booking_app/custom_componannt/form_inputs.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class OfferFormScreen extends StatefulWidget {
  const OfferFormScreen({super.key});

  @override
  State<OfferFormScreen> createState() => _OfferFormScreenState();
}

class _OfferFormScreenState extends State<OfferFormScreen> {
  final controller = Get.put(OfferFormController());
  late TimeOfDay selectedTime;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        controller.hideKeyboard(context);
      },
      child: CustomScaffold(
          body: Container(
        child: Column(
          children: [
            getCommonToolbar("Offer", () {
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
                            left: 7.0.w, right: 7.0.w, top: 2.h, bottom: 1.h),
                        child: Form(
                            key: controller.formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getTitle("Title"),
                                FadeInUp(
                                    from: 30,
                                    child: AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Obx(() {
                                          return getReactiveFormField(
                                            node: controller.nameNode,
                                            controller: controller.namectr,
                                            hintLabel: "Enter Title",
                                            onChanged: (val) {
                                              controller.validateName(val);
                                            },
                                            errorText: controller
                                                .NameModel.value.error,
                                            inputType: TextInputType.text,
                                          );
                                        }))),
                                getTitle("Discount"),
                                FadeInUp(
                                    from: 30,
                                    child: AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Obx(() {
                                          return getReactiveFormField(
                                            node: controller.discountNode,
                                            controller: controller.discountctr,
                                            hintLabel: "Enter Discount",
                                            onChanged: (val) {
                                              controller.validateDiscount(val);
                                              setState(() {});
                                            },
                                            errorText: controller
                                                .DiscountModel.value.error,
                                            inputType: TextInputType.number,
                                          );
                                        }))),
                                getTitle("Photo"),
                                FadeInUp(
                                    from: 30,
                                    child: AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Obx(() {
                                          return getReactiveFormField(
                                            node: controller.ImageNode,
                                            controller: controller.imgctr,
                                            hintLabel:
                                                ReportBugConstant.upload_hint,
                                            wantSuffix: true,
                                            onChanged: (val) {
                                              controller.validateImage(val);
                                              setState(() {});
                                            },
                                            isReadOnly: true,
                                            onTap: () async {
                                              selectImageFromCameraOrGallery(
                                                  context, cameraClick: () {
                                                controller
                                                    .actionClickUploadImage(
                                                        context,
                                                        isCamera: true);
                                              }, galleryClick: () {
                                                controller
                                                    .actionClickUploadImage(
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
                                                .ImageModel.value.error,
                                            inputType: TextInputType.number,
                                          );
                                        }))),
                                getTitle("Start Date"),
                                FadeInUp(
                                    from: 30,
                                    child: AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Obx(() {
                                          return getReactiveFormField(
                                            node: controller.startDateNode,
                                            controller: controller.startTimectr,
                                            hintLabel: "Select Start Date",
                                            wantSuffix: true,
                                            isCalender: true,
                                            onChanged: (val) {
                                              controller.validateStartTime(val);
                                              setState(() {});
                                            },
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate: controller
                                                          .selectedStartDate,
                                                      firstDate: DateTime(1950),
                                                      lastDate: DateTime.now()
                                                          .add(const Duration(
                                                              days: 365)));
                                              if (pickedDate != null &&
                                                  pickedDate !=
                                                      controller
                                                          .selectedStartDate) {
                                                setState(() {
                                                  controller.selectedStartDate =
                                                      pickedDate;
                                                });
                                              }
                                              if (pickedDate != null) {
                                                String formattedDate =
                                                    DateFormat(Strings
                                                            .oldDateFormat)
                                                        .format(pickedDate);
                                                controller.updateStartDate(
                                                    formattedDate);
                                                controller.validateStartTime(
                                                    formattedDate);
                                              }
                                            },
                                            errorText: controller
                                                .StartTimeModel.value.error,
                                            inputType: TextInputType.text,
                                          );
                                        }))),
                                getTitle("End Date"),
                                FadeInUp(
                                    from: 30,
                                    child: AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Obx(() {
                                          return getReactiveFormField(
                                            node: controller.endDateNode,
                                            controller: controller.endTimectr,
                                            hintLabel: "Select End Date",
                                            wantSuffix: true,
                                            isCalender: true,
                                            onChanged: (val) {
                                              controller.validateEndTime(val);
                                              setState(() {});
                                            },
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate: controller
                                                          .selectedEndDate,
                                                      firstDate: DateTime(1950),
                                                      lastDate: DateTime.now()
                                                          .add(const Duration(
                                                              days: 365)));
                                              if (pickedDate != null &&
                                                  pickedDate !=
                                                      controller
                                                          .selectedEndDate) {
                                                setState(() {
                                                  controller.selectedEndDate =
                                                      pickedDate;
                                                });
                                              }
                                              if (pickedDate != null) {
                                                String formattedDate =
                                                    DateFormat(Strings
                                                            .oldDateFormat)
                                                        .format(pickedDate);
                                                controller.updateEndDate(
                                                    formattedDate);
                                                controller.validateEndTime(
                                                    formattedDate);
                                              }
                                            },
                                            errorText: controller
                                                .EndTimeModel.value.error,
                                            inputType: TextInputType.text,
                                          );
                                        }))),
                                // getTitle(ReportBugConstant.notes),
                                // FadeInUp(
                                //     from: 30,
                                //     child: AnimatedSize(
                                //         duration: const Duration(milliseconds: 300),
                                //         child: Obx(() {
                                //           return getReactiveFormField(
                                //             node: controller.NoteNode,
                                //             controller: controller.notesctr,
                                //             hintLabel: ReportBugConstant.notes_hint,
                                //             onChanged: (val) {
                                //               controller.validateNotes(val);
                                //               setState(() {});
                                //             },
                                //             isExpand: true,
                                //             errorText: controller.DiscountModel.value.error,
                                //             inputType: TextInputType.text,
                                //           );
                                //         }))),
                                SizedBox(
                                  height: 4.h,
                                ),
                                FadeInUp(
                                    from: 50,
                                    child: Obx(() {
                                      return getFormButton(() {
                                        if (controller.isFormInvalidate.value ==
                                            true) {
                                          //  controller.AddCourseApi(context);
                                        }
                                      }, CommonConstant.submit,
                                          validate: controller
                                              .isFormInvalidate.value);
                                    }))
                              ],
                            )),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      )),
    );
  
  
  }
}
