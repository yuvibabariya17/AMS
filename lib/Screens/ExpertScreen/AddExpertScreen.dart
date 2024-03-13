import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Models/ExpertModel.dart';
import 'package:booking_app/controllers/AddExpert_controller.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../core/Common/toolbar.dart';
import '../../core/constants/strings.dart';
import '../../custom_componannt/common_views.dart';
import '../../custom_componannt/form_inputs.dart';

class AddExpertScreen extends StatefulWidget {
  AddExpertScreen({super.key, this.isEdit, this.editExpert});
  bool? isEdit;
  ExpertList? editExpert;

  @override
  State<AddExpertScreen> createState() => _AddExpertScreenState();
}

class _AddExpertScreenState extends State<AddExpertScreen> {
  final controller = Get.put(AddexpertController());
  late TimeOfDay selectedTime;

  @override
  void initState() {
    if (widget.isEdit == true && widget.editExpert != null) {
      controller.Servicectr.text =
          widget.editExpert!.serviceInfo.name.toString();
      controller.Expertctr.text = widget.editExpert!.name.toString().trim();
      controller.Profilectr.text = widget.editExpert!.upload_info.image;
      controller.Startctr.text = widget.editExpert!.startTime.toString();
      controller.Endctr.text = widget.editExpert!.endTime.toString();
      controller.Pricectr.text = widget.editExpert!.amount.toString();
      controller.startTime =
          widget.editExpert!.startTime.toIso8601String().toString().trim();
      controller.endTime =
          widget.editExpert!.endTime.toIso8601String().toString().trim();
      controller.uploadImageId.value =
          widget.editExpert!.upload_id.toString().trim();

      controller.ServiceId.value =
          widget.editExpert!.serviceId.toString().trim();

      if (widget.isEdit == true) {
        validateFields();
      }

      // Set other fields as well
    }
    controller.getServiceList(context);
    super.initState();
  }

  @override
  void dispose() {
    controller.Servicectr.text = "";
    controller.Expertctr.text = "";
    controller.Pricectr.text = "";

    super.dispose();
  }

  void validateFields() {
    // Validate all fields here
    controller.validateExpertname(controller.Servicectr.text);
    controller.validateProfile(controller.Profilectr.text);
    controller.validateStartTime(controller.Startctr.text);
    controller.validateEndTime(controller.Endctr.text);
    controller.validatePrice(controller.Pricectr.text);
    controller.validateServicename(controller.Servicectr.text);

    // Add validation for other fields as needed
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.hideKeyboard(context);
      },
      child: CustomScaffold(
          body: Column(
        children: [
          getCommonToolbar(
              widget.isEdit == true ? "Update Expert" : ScreenTitle.addExpert,
              () {
            Get.back();
          }),
          Expanded(
              child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(
                    left: SizerUtil.deviceType == DeviceType.mobile
                        ? 1.0.w
                        : 0.5.w,
                    right: SizerUtil.deviceType == DeviceType.mobile
                        ? 1.0.w
                        : 0.5.w,
                  ),
                  padding: EdgeInsets.only(
                      left: SizerUtil.deviceType == DeviceType.mobile
                          ? 7.0.w
                          : 5.w,
                      right: SizerUtil.deviceType == DeviceType.mobile
                          ? 7.0.w
                          : 5.w,
                      top: 2.h,
                      bottom: 1.h),
                  child: Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getTitle(AddExpertConstant.expert),
                          FadeInUp(
                              from: 30,
                              child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: Obx(() {
                                    return getReactiveFormField(
                                      node: controller.ExpertNode,
                                      controller: controller.Expertctr,
                                      hintLabel: AddExpertConstant.expertHint,
                                      onChanged: (val) {
                                        controller.validateExpertname(val);
                                      },
                                      errorText:
                                          controller.ExpertModel.value.error,
                                      inputType: TextInputType.text,
                                    );
                                  }))),
                          getTitle(Strings.profile_photo),
                          FadeInUp(
                              from: 30,
                              child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
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
                                        selectImageFromCameraOrGallery(context,
                                            cameraClick: () {
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
                                      errorText:
                                          controller.ProfileModel.value.error,
                                      inputType: TextInputType.text,
                                    );
                                  }))),

                          getTitle("Service"),
                          FadeInUp(
                              from: 30,
                              child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: Obx(() {
                                    return getReactiveFormField(
                                      node: controller.ServiceNode,
                                      controller: controller.Servicectr,
                                      hintLabel: "Select Service",
                                      onChanged: (val) {
                                        controller.validateServicename(val);
                                        setState(() {});
                                      },
                                      isReadOnly: true,
                                      wantSuffix: true,
                                      isdown: true,
                                      onTap: () {
                                        controller.Servicectr.text = "";

                                        showDropDownDialog(
                                            context,
                                            controller.setServiceList(),
                                            "Service List");
                                        // showDropdownMessage(
                                        //     context,
                                        //     controller.setServiceList(),
                                        //     'Select Service');
                                      },
                                      errorText: controller.Model.value.error,
                                      inputType: TextInputType.text,
                                    );
                                  }))),
                          getTitle("Start Time"),
                          FadeInUp(
                              from: 30,
                              child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: Obx(() {
                                    return getReactiveFormField(
                                      node: controller.StartTimeNode,
                                      controller: controller.Startctr,
                                      hintLabel: "Select Start Time",
                                      wantSuffix: true,
                                      time: true,
                                      onChanged: (val) {
                                        controller.validateStartTime(val);
                                      },
                                      isReadOnly: true,
                                      onTap: () async {
                                        final TimeOfDay? pickedTime =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return Theme(
                                              data: isDarkMode()
                                                  ? ThemeData.dark().copyWith(
                                                      primaryColor:
                                                          primaryColor,
                                                      buttonTheme:
                                                          ButtonThemeData(
                                                        textTheme:
                                                            ButtonTextTheme
                                                                .primary,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  50), // Set your border radius
                                                        ),
                                                      ),
                                                      colorScheme: const ColorScheme
                                                              .dark(
                                                        primary: Colors
                                                            .teal, // Set your primary color
                                                      )
                                                          .copyWith(
                                                              secondary:
                                                                  secondaryColor)
                                                          .copyWith(
                                                              background:
                                                                  white),
                                                    )
                                                  : ThemeData.light().copyWith(
                                                      primaryColor:
                                                          primaryColor,
                                                      buttonTheme:
                                                          ButtonThemeData(
                                                        textTheme:
                                                            ButtonTextTheme
                                                                .primary,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  50), // Set your border radius
                                                        ),
                                                      ),
                                                      colorScheme: const ColorScheme
                                                              .light(
                                                        primary: Colors
                                                            .teal, // Set your primary color
                                                      )
                                                          .copyWith(
                                                              secondary:
                                                                  secondaryColor)
                                                          .copyWith(
                                                              background:
                                                                  white),
                                                    ),
                                              child: child!,
                                            );
                                          },
                                        );

                                        if (pickedTime != null) {
                                          final DateTime currentDate =
                                              DateTime.now();
                                          final DateTime combinedDateTime =
                                              DateTime(
                                            currentDate.year,
                                            currentDate.month,
                                            currentDate.day,
                                            pickedTime.hour,
                                            pickedTime.minute,
                                            0,
                                            704,
                                          );

                                          final formattedDateTime =
                                              "${pickedTime.format(context)}";

                                          //For All Format
                                          controller.startTime =
                                              "${DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(combinedDateTime)}Z";

                                          controller.updateStartTime(
                                              formattedDateTime);
                                          controller.validateStartTime(
                                              formattedDateTime);
                                          setState(() {
                                            selectedTime = pickedTime;
                                            print(
                                                "Selected Time: $formattedDateTime");
                                          });
                                        }
                                        // DateTime? pickedDate =
                                        //     await showDatePicker(
                                        //   context: context,
                                        //   initialDate: controller.selectedDate,
                                        //   firstDate: DateTime(1950),
                                        //   lastDate: DateTime(2050),
                                        //   // lastDate: DateTime.now().add(
                                        //   //     const Duration(days: 0))
                                        // );
                                        // if (pickedDate != null) {
                                        //   final TimeOfDay? pickedTime =
                                        //       await showTimePicker(
                                        //     context: context,
                                        //     initialTime: TimeOfDay.now(),
                                        //   );

                                        //   if (pickedTime != null) {
                                        //     DateTime? selectedDateTime;
                                        //     setState(() {
                                        //       selectedDateTime = DateTime(
                                        //         pickedDate.year,
                                        //         pickedDate.month,
                                        //         pickedDate.day,
                                        //         pickedTime.hour,
                                        //         pickedTime.minute,
                                        //       );
                                        //     });
                                        //     logcat(
                                        //         "FINALDATE",
                                        //         selectedDateTime!
                                        //             .toIso8601String());
                                        //   }
                                        // }

                                        // if (pickedDate != null &&
                                        //     pickedDate !=
                                        //         controller.selectedDate) {
                                        //   setState(() {
                                        //     controller.selectedDate = DateTime(
                                        //       pickedDate.year,
                                        //       pickedDate.month,
                                        //       pickedDate.day,
                                        //       controller.selectedDate.hour,
                                        //       controller.selectedDate.minute,
                                        //       controller.selectedDate.second,
                                        //     );
                                        //   });
                                        // }
                                        // if (pickedTime != null) {
                                        //   String formattedTime =
                                        //       DateFormat(Strings.oldDateFormat)
                                        //           .format(pickedTime as DateTime);
                                        //   controller
                                        //       .updateApproxtime(formattedTime);
                                        //   controller
                                        //       .validateApproxtime(formattedTime);
                                        // }
                                      },
                                      errorText:
                                          controller.StartTimeModel.value.error,
                                      inputType: TextInputType.none,
                                    );
                                  }))),
                          getTitle("End Time"),
                          FadeInUp(
                              from: 30,
                              child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: Obx(() {
                                    return getReactiveFormField(
                                      node: controller.EndTimeNode,
                                      controller: controller.Endctr,
                                      hintLabel: "Select End Time",
                                      onChanged: (val) {
                                        controller.validateEndTime(val);
                                      },
                                      isReadOnly: true,
                                      wantSuffix: true,
                                      time: true,
                                      onTap: () async {
                                        final TimeOfDay? pickedDuration =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return Theme(
                                              data: isDarkMode()
                                                  ? ThemeData.dark().copyWith(
                                                      primaryColor:
                                                          primaryColor,
                                                      buttonTheme:
                                                          ButtonThemeData(
                                                        textTheme:
                                                            ButtonTextTheme
                                                                .primary,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  50), // Set your border radius
                                                        ),
                                                      ),
                                                      colorScheme: const ColorScheme
                                                              .dark(
                                                        primary: Colors
                                                            .teal, // Set your primary color
                                                      )
                                                          .copyWith(
                                                              secondary:
                                                                  secondaryColor)
                                                          .copyWith(
                                                              background:
                                                                  white),
                                                    )
                                                  : ThemeData.light().copyWith(
                                                      primaryColor:
                                                          primaryColor,
                                                      buttonTheme:
                                                          ButtonThemeData(
                                                        textTheme:
                                                            ButtonTextTheme
                                                                .primary,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  50), // Set your border radius
                                                        ),
                                                      ),
                                                      colorScheme: const ColorScheme
                                                              .light(
                                                        primary: Colors
                                                            .teal, // Set your primary color
                                                      )
                                                          .copyWith(
                                                              secondary:
                                                                  secondaryColor)
                                                          .copyWith(
                                                              background:
                                                                  white),
                                                    ),
                                              child: child!,
                                            );
                                          },
                                        );

                                        if (pickedDuration != null) {
                                          final DateTime currentDate =
                                              DateTime.now();
                                          final DateTime combinedDateTime =
                                              DateTime(
                                            currentDate.year,
                                            currentDate.month,
                                            currentDate.day,
                                            pickedDuration.hour,
                                            pickedDuration.minute,
                                            0,
                                            704,
                                          );

                                          final SittingDurationTime =
                                              "${pickedDuration.format(context)}";
                                          //For All Format
                                          controller.endTime =
                                              "${DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(combinedDateTime)}Z";

                                          controller.updateEndTime(
                                              SittingDurationTime);
                                          controller.validateEndTime(
                                              SittingDurationTime);
                                          setState(() {
                                            selectedTime = pickedDuration;
                                            print(
                                                "Selected Time: $SittingDurationTime");
                                          });
                                        }

                                        // DateTime? pickedDate =
                                        //     await showDatePicker(
                                        //   context: context,
                                        //   initialDate: controller.durationDate,
                                        //   firstDate: DateTime(1950),
                                        //   lastDate: DateTime(2050),
                                        //   // lastDate: DateTime.now().add(
                                        //   //     const Duration(days: 0))
                                        // );
                                        // if (pickedDate != null &&
                                        //     pickedDate !=
                                        //         controller.durationDate) {
                                        //   setState(() {
                                        //     controller.durationDate = pickedDate;
                                        //     controller.durationDate = DateTime(
                                        //       pickedDate.year,
                                        //       pickedDate.month,
                                        //       pickedDate.day,
                                        //       controller.durationDate.hour,
                                        //       controller.durationDate.minute,
                                        //       controller.durationDate.second,
                                        //     );
                                        //   });
                                        // }
                                        // if (pickedDate != null) {
                                        //   String formattedDate =
                                        //       DateFormat(Strings.oldDateFormat)
                                        //           .format(pickedDate);
                                        //   controller.updateSittingDuration(
                                        //       formattedDate);
                                        //   controller
                                        //       .validateDuration(formattedDate);
                                        // }
                                      },
                                      errorText:
                                          controller.EndTimeModel.value.error,
                                      inputType: TextInputType.none,
                                    );
                                  }))),

                          getTitle(AddExpertConstant.price),
                          FadeInUp(
                              from: 30,
                              child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: Obx(() {
                                    return getReactiveFormField(
                                      node: controller.PriceNode,
                                      controller: controller.Pricectr,
                                      hintLabel: AddExpertConstant.priceHint,
                                      onChanged: (val) {
                                        controller.validatePrice(val);
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
                                  if (controller.isFormInvalidate.value ==
                                      true) {
                                    if (widget.isEdit == true) {
                                      // Call updateCourse API
                                      controller.UpdateExpert(
                                          context,
                                          widget.editExpert!.serviceId,
                                          widget.editExpert!.id);
                                    } else {
                                      controller.addExpertApi(context);
                                    }
                                  }
                                }, CommonConstant.submit,
                                    validate:
                                        controller.isFormInvalidate.value);
                              })),
                          SizedBox(
                            height: SizerUtil.deviceType == DeviceType.mobile
                                ? null
                                : 2.h,
                          ),

                          // FadeInUp(
                          //     from: 50,
                          //     child: Obx(() {
                          //       return getFormButton(() {
                          //         if (controller.isFormInvalidate.value ==
                          //             true) {
                          //           controller.addExpertApi(context);
                          //         }
                          //       }, CommonConstant.submit,
                          //           validate:
                          //               controller.isFormInvalidate.value);
                          //     }))

                          // FadeInUp(
                          //     from: 50,
                          //     child: Obx(() {
                          //       return getFormButton(() {
                          //         if (controller.isFormInvalidate.value ==
                          //             true) {
                          //           controller.addExpertApi(context);
                          //         }

                          //         // if (widget.isEdit == true) {
                          //         //   // Call updateCourse API
                          //         //   controller.UpdateExpert(context, widget.editExpert!.id );
                          //         // } else {
                          //         //   // Call AddCourseApi API
                          //         //   controller.addExpertApi(context);
                          //         // }
                          //       }, CommonConstant.submit,
                          //           validate:
                          //               controller.isFormInvalidate.value);
                          //     }))
                          // FadeInUp(
                          //     from: 50,
                          //     child: Obx(() {
                          //       return getFormButton(() {
                          //         if (controller.isFormInvalidate.value ==
                          //             true) {
                          //           controller.addExpertApi(context);
                          //         }
                          //       }, CommonConstant.submit,
                          //           validate:
                          //               controller.isFormInvalidate.value);
                          //     }))
                        ],
                      )),
                ),
              )
            ],
          ))
        ],
      )),
    );
  }
}
