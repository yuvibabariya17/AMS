import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Models/VendorServiceModel.dart';
import 'package:booking_app/controllers/AddService_controller.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../core/Common/toolbar.dart';
import '../../core/constants/strings.dart';
import '../../custom_componannt/common_views.dart';
import '../../custom_componannt/form_inputs.dart';

class AddServiceScreen extends StatefulWidget {
  AddServiceScreen({super.key, this.isEdit, this.editService});
  bool? isEdit;
  VendorServiceList? editService;

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final controller = Get.put(AddserviceController());
  late TimeOfDay selectedTime;

  @override
  void dispose() {
    controller.categoryctr.text = "";
    controller.subCategoryctr.text = "";
    controller.Servicectr.text = "";
    controller.Expertctr.text = "";
    controller.Pricectr.text = "";
    controller.approxtimectr.text = "";
    controller.sittingctr.text = "";
    controller.durationctr.text = "";
    controller.daysctr.text = "";
    controller.intervalctr.text = "";

    super.dispose();
  }

  void validateFields() {
    // Validate all fields here
    controller.validateCategory(controller.categoryctr.text);
    controller.validateSubCategory(controller.subCategoryctr.text);
    controller.validateServicename(controller.Servicectr.text);
    controller.validateApproxtime(controller.approxtimectr.text);
    controller.validateSitting(controller.sittingctr.text);
    controller.validateDuration(controller.durationctr.text);
    controller.validatePrice(controller.Pricectr.text);
    controller.validateDays(controller.daysctr.text);
    controller.validateIntervalDuration(controller.intervalctr.text);

    // Add validation for other fields as needed
  }

  @override
  void initState() {
    // FOR EDIT SERVICE
    if (widget.isEdit == true && widget.editService != null) {
      controller.categoryctr.text =
          widget.editService!.categoryInfo.name.toString();
      controller.subCategoryctr.text =
          widget.editService!.subCategoryInfo.name.toString();
      controller.Servicectr.text =
          widget.editService!.serviceInfo.name.toString();
      controller.approxtimectr.text = widget.editService!.oppoxTime.toString();
      controller.sittingctr.text = widget.editService!.oppoxSetting.toString();
      controller.intervalctr.text =
          widget.editService!.oppox_setting_days_inverval.toString();
      controller.durationctr.text =
          widget.editService!.oppoxSettingDuration.toString();
      controller.Pricectr.text = widget.editService!.fees.toString();
      controller.daysctr.text = widget.editService!.Total_days.toString();
      controller.sitingTime = widget.editService!.oppoxSettingDuration
          .toIso8601String()
          .toString()
          .trim();
      controller.approxTime =
          widget.editService!.oppoxTime.toIso8601String().toString().trim();
    }
    if (widget.isEdit == true) {
      validateFields();
    }
    controller.getServiceCategoryList(context);
    controller.getServiceList(context, true, "", "");
    super.initState();
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
              widget.isEdit == true ? "Update Service" : ScreenTitle.addService,
              () {
            Get.back();
          }),
          Expanded(
              child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
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
                            //  CATEGORY AND SUBCATEGORYYY

                            // getTitle("Service Category"),
                            // FadeInUp(
                            //     from: 30,
                            //     child: AnimatedSize(
                            //         duration: const Duration(milliseconds: 300),
                            //         child: Obx(() {
                            //           return getReactiveFormField(
                            //             node: controller.categoryNode,
                            //             controller: controller.categoryctr,
                            //             hintLabel: "Select Category",
                            //             // wantSuffix: true,
                            //             // isdown: true,
                            //             isReadOnly: true,

                            //             wantSuffix: true,
                            //             isdown: true,
                            //             // onAddBtn: () {
                            //             //   //Get.to(AddExpertScreen());
                            //             // },

                            //             onTap: () {
                            //               // controller.categoryctr.text = "";
                            //               showDropDownDialog(
                            //                   context,
                            //                   controller
                            //                       .setServiceCategoryList(),
                            //                   "Service Category");
                            //             },

                            //             onChanged: (val) {
                            //               controller.validateCategory(val);
                            //             },
                            //             errorText: controller
                            //                 .categoryModel.value.error,
                            //             inputType: TextInputType.name,
                            //           );
                            //         }))),
                            // getTitle("Service Sub Category"),
                            // FadeInUp(
                            //     from: 30,
                            //     child: AnimatedSize(
                            //         duration: const Duration(milliseconds: 300),
                            //         child: Obx(() {
                            //           return getReactiveFormField(
                            //             node: controller.subCategoryNode,
                            //             controller: controller.subCategoryctr,
                            //             hintLabel: "Select Sub Category",
                            //             isReadOnly: true,
                            //             wantSuffix: true,
                            //             isdown: true,
                            //             // onAddBtn: () {
                            //             //   //Get.to(AddExpertScreen());
                            //             // },

                            //             onTap: () {
                            //               controller.subCategoryctr.text = "";

                            //               if (controller
                            //                   .categoryctr.text.isEmpty) {
                            //                 return PopupDialogs(
                            //                   context,
                            //                   "Service",
                            //                   "Category Field is Required",
                            //                 );
                            //               }

                            //               showDropDownDialog(
                            //                   context,
                            //                   controller.setSubCategoryList(),
                            //                   "Service Sub Category");
                            //             },

                            //             onChanged: (val) {
                            //               controller.validateSubCategory(val);
                            //             },
                            //             errorText: controller
                            //                 .subCategoryModel.value.error,
                            //             inputType: TextInputType.name,
                            //           );
                            //         }))),
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
                                        isReadOnly: true,
                                        wantSuffix: true,
                                        isdown: true,
                                        //     isDropdown: true,
                                        // onAddBtn: () {
                                        //   //Get.to(AddExpertScreen());
                                        // },
                                        //  isAdd: true,
                                        onTap: () {
                                          controller.Servicectr.text = "";
                                          // if (controller
                                          //     .subCategoryctr.text.isEmpty) {
                                          //   return PopupDialogs(
                                          //     context,
                                          //     "Service",
                                          //     "Category Field and Sub Category Field is Required",
                                          //   );
                                          // }

                                          showDropDownDialog(
                                              context,
                                              controller.setServiceList(),
                                              "Service List");
                                        },

                                        onChanged: (val) {
                                          controller.validateServicename(val);
                                        },
                                        errorText:
                                            controller.serviceModel.value.error,
                                        inputType: TextInputType.name,
                                      );
                                    }))),
                            getTitle(AddServiceConstant.approxTime),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.approxtimeNode,
                                        controller: controller.approxtimectr,
                                        hintLabel:
                                            AddServiceConstant.approxTimeHint,
                                        wantSuffix: true,
                                        time: true,
                                        isReadOnly: true,
                                        onChanged: (val) {
                                          controller.validateApproxtime(val);
                                        },
                                        onTap: () async {
                                          final TimeOfDay? pickedTime =
                                              await showTimePicker(
                                            context: context,
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return Theme(
                                                data: isDarkMode()
                                                    ? ThemeData.dark().copyWith(
                                                        primaryColor: black,
                                                        backgroundColor: white,
                                                        buttonTheme:
                                                            ButtonThemeData(
                                                          textTheme:
                                                              ButtonTextTheme
                                                                  .primary,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50), // Set your border radius
                                                          ),
                                                        ),
                                                        useMaterial3: true,
                                                        colorScheme:
                                                            const ColorScheme
                                                                .dark(
                                                          primary: Colors
                                                              .teal, // Set your primary color
                                                        ).copyWith(
                                                                secondary:
                                                                    secondaryColor),
                                                      )
                                                    : ThemeData.light()
                                                        .copyWith(
                                                        primaryColor: white,
                                                        backgroundColor: white,
                                                        buttonTheme:
                                                            ButtonThemeData(
                                                          textTheme:
                                                              ButtonTextTheme
                                                                  .primary,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50), // Set your border radius
                                                          ),
                                                        ),
                                                        useMaterial3: true,
                                                        colorScheme:
                                                            const ColorScheme
                                                                .light(
                                                          primary: Colors
                                                              .teal, // Set your primary color
                                                        ).copyWith(
                                                                secondary:
                                                                    secondaryColor),
                                                      ),
                                                child: child!,
                                              );
                                            },
                                            initialTime: TimeOfDay.now(),
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
                                            controller.approxTime =
                                                "${DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(combinedDateTime)}Z";

                                            controller.updateApproxtime(
                                                formattedDateTime);
                                            controller.validateApproxtime(
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
                                        errorText: controller
                                            .approxtimeModel.value.error,
                                        inputType: TextInputType.none,
                                      );
                                    }))),
                            // getTitle(Strings.expert),
                            // FadeInUp(
                            //     from: 30,
                            //     child: AnimatedSize(
                            //         duration: const Duration(milliseconds: 300),
                            //         child: Obx(() {
                            //           return getReactiveFormField(
                            //             node: controller.ExpertNode,
                            //             controller: controller.Expertctr,
                            //             hintLabel: Strings.expert_hint,
                            //             onChanged: (val) {
                            //               controller.validateExpertname(val);
                            //               setState(() {});
                            //             },
                            //             errorText:
                            //                 controller.ExpertModel.value.error,
                            //             inputType: TextInputType.text,
                            //           );
                            //         }))),
                            getTitle(AddServiceConstant.sitting),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.sittingNode,
                                        controller: controller.sittingctr,
                                        hintLabel:
                                            AddServiceConstant.sittingHint,
                                        onChanged: (val) {
                                          controller.validateSitting(val);
                                        },
                                        errorText:
                                            controller.sittingModel.value.error,
                                        inputType: TextInputType.number,
                                      );
                                    }))),
                            getTitle(AddServiceConstant.sittingDuration),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.durationNode,
                                        controller: controller.durationctr,
                                        hintLabel: AddServiceConstant
                                            .sittingDurationHint,
                                        onChanged: (val) {
                                          controller.validateDuration(val);
                                        },
                                        isReadOnly: true,
                                        wantSuffix: true,
                                        time: true,
                                        onTap: () async {
                                          final TimeOfDay? pickedDuration =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                            builder: (context, child) {
                                              return Theme(
                                                data: isDarkMode()
                                                    ? ThemeData.dark().copyWith(
                                                        primaryColor:
                                                            primaryColor,
                                                        backgroundColor: white,
                                                        buttonTheme:
                                                            ButtonThemeData(
                                                          textTheme:
                                                              ButtonTextTheme
                                                                  .primary,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50), // Set your border radius
                                                          ),
                                                        ),
                                                        useMaterial3: true,
                                                        colorScheme:
                                                            const ColorScheme
                                                                .dark(
                                                          primary: Colors
                                                              .teal, // Set your primary color
                                                        ).copyWith(
                                                                secondary:
                                                                    secondaryColor),
                                                      )
                                                    : ThemeData.light()
                                                        .copyWith(
                                                        primaryColor:
                                                            primaryColor,
                                                        backgroundColor: white,
                                                        buttonTheme:
                                                            ButtonThemeData(
                                                          textTheme:
                                                              ButtonTextTheme
                                                                  .primary,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50), // Set your border radius
                                                          ),
                                                        ),
                                                        useMaterial3: true,
                                                        colorScheme:
                                                            const ColorScheme
                                                                .light(
                                                          primary: Colors
                                                              .teal, // Set your primary color
                                                        ).copyWith(
                                                                secondary:
                                                                    secondaryColor),
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
                                            print(
                                                "Selected Time: $pickedDuration");

                                            final SittingDurationTime =
                                                "${pickedDuration.format(context)}";
                                            //For All Format
                                            controller.sitingTime =
                                                "${DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(combinedDateTime)}Z";

                                            // print(
                                            //     "Controller Sitting Time: ${controller.sitingTime}");

                                            controller.updateSittingDuration(
                                                SittingDurationTime);
                                            controller.validateDuration(
                                                SittingDurationTime);

                                            print(
                                                "Controller Sitting Time: ${controller.sitingTime}");
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
                                        errorText: controller
                                            .durationModel.value.error,
                                        inputType: TextInputType.none,
                                      );
                                    }))),
                            getTitle("Sitting Days Interval"),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.intervalNode,
                                        controller: controller.intervalctr,
                                        hintLabel:
                                            "Enter Sitting Days Interval",
                                        onChanged: (val) {
                                          controller
                                              .validateIntervalDuration(val);
                                        },
                                        errorText: controller
                                            .intervalModel.value.error,
                                        inputType: TextInputType.number,
                                      );
                                    }))),
                            getTitle(AddServiceConstant.days),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.daysNode,
                                        controller: controller.daysctr,
                                        hintLabel: AddServiceConstant.daysHint,
                                        onChanged: (val) {
                                          controller.validateDays(val);
                                        },
                                        errorText:
                                            controller.daysModel.value.error,
                                        inputType: TextInputType.number,
                                      );
                                    }))),
                            getTitle(AddServiceConstant.price),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.PriceNode,
                                        controller: controller.Pricectr,
                                        hintLabel: AddServiceConstant.priceHint,
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
                                    if (widget.isEdit == true) {
                                      // Call updateCourse API
                                      logcat("IDD",
                                          widget.editService!.id.toString());
                                      controller.UpdateVendorServiceApi(
                                          context, widget.editService!.id);
                                    } else {
                                      // Call AddCourseApi API
                                      controller.addVendorService(context);
                                    }
                                  }, CommonConstant.submit,
                                      validate:
                                          controller.isFormInvalidate.value);
                                }))

                            // FadeInUp(
                            //     from: 50,
                            //     child: Obx(() {
                            //       return getFormButton(() {
                            //         if (controller.isFormInvalidate.value ==
                            //             true) {
                            //           controller.addVendorService(context);
                            //         }
                            //       }, CommonConstant.submit,
                            //           validate:
                            //               controller.isFormInvalidate.value);
                            //     }))
                          ],
                        )),
                  ),
                ),
              )
            ],
          ))
        ],
      )),
    );
  }

  static Future<Object?> PopupDialogs(
      BuildContext context, String title, String subtext) {
    return showGeneralDialog(
        barrierColor: black.withOpacity(0.6),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: CupertinoAlertDialog(
                  title: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      color: isDarkMode() ? white : black,
                      fontFamily: fontBold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Text(
                    subtext,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDarkMode() ? white : black,
                      fontFamily: fontMedium,
                    ),
                  ),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      isDefaultAction: true,
                      isDestructiveAction: true,
                      child: Text("Continue",
                          style: TextStyle(
                            fontSize: 15,
                            color: isDarkMode() ? white : black,
                            fontFamily: fontBold,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    // The "No" button
                  ],
                )),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }
}
