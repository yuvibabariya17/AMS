import 'package:animate_do/animate_do.dart';
import 'package:booking_app/controllers/AddPackageController.dart';
import 'package:booking_app/custom_componannt/customeBackground.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../core/Common/toolbar.dart';
import '../../core/constants/strings.dart';
import '../../custom_componannt/common_views.dart';
import '../../custom_componannt/form_inputs.dart';

class AddPackageScreen extends StatefulWidget {
  const AddPackageScreen({super.key});

  @override
  State<AddPackageScreen> createState() => _AddPackageScreenState();
}

class _AddPackageScreenState extends State<AddPackageScreen> {
  final controller = Get.put(AddPackageController());
  
  late TimeOfDay selectedTime;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          getCommonToolbar("Add Package", () {
            Get.back();
          }),
          Container(
            margin: EdgeInsets.only(left: 1.0.w, right: 1.0.w),
            padding: EdgeInsets.only(
                left: 7.0.w, right: 7.0.w, top: 2.h, bottom: 1.h),
            child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTitle("Package Name"),
                    FadeInUp(
                        from: 30,
                        child: AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            child: Obx(() {
                              return getReactiveFormField(
                                node: controller.nameNode,
                                controller: controller.nameCtr,
                                hintLabel: "Enter Package Name",
                                onChanged: (val) {
                                  controller.validateName(val);
                                },
                                errorText: controller.NameModel.value.error,
                                inputType: TextInputType.text,
                              );
                            }))),
                    getTitle("Actual Fees"),
                    FadeInUp(
                        from: 30,
                        child: AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            child: Obx(() {
                              return getReactiveFormField(
                                node: controller.actfeesNode,
                                controller: controller.actfeesCtr,
                                hintLabel: "Actual Fees",

                                onChanged: (val) {
                                  controller.validateActFees(val);
                                  setState(() {});
                                },
                                // onTap: () async {
                                //   DateTime? pickedDate = await showDatePicker(
                                //       context: context,
                                //       initialDate: controller.selectedDate,
                                //       firstDate: DateTime(1950),
                                //       lastDate: DateTime.now()
                                //           .add(const Duration(days: 0)));
                                //   if (pickedDate != null &&
                                //       pickedDate != controller.selectedDate) {
                                //     setState(() {
                                //       controller.selectedDate = pickedDate;
                                //     });
                                //   }
                                //   if (pickedDate != null) {
                                //     String formattedDate =
                                //         DateFormat(Strings.oldDateFormat)
                                //             .format(pickedDate);
                                //     controller.updateDate(formattedDate);
                                //     controller.validateDate(formattedDate);
                                //   }
                                // },
                                errorText: controller.ActfeesModel.value.error,
                                inputType: TextInputType.number,
                              );
                            }))),
                    getTitle("Package Fees"),
                    FadeInUp(
                        from: 30,
                        child: AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            child: Obx(() {
                              return getReactiveFormField(
                                node: controller.packFeesNode,
                                controller: controller.packFeesCtr,
                                hintLabel: "Package Fees",
                                onChanged: (val) {
                                  controller.validatePackFees(val);
                                  setState(() {});
                                },
                                errorText: controller.PackfeesModel.value.error,
                                inputType: TextInputType.number,
                              );
                            }))),
                      getTitle("Duration Start From"),
                              FadeInUp(
                                  from: 30,
                                  child: AnimatedSize(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Obx(() {
                                        return getReactiveFormField(
                                          node: controller.fromDurationNode,
                                          controller: controller.fromDurationCtr,
                                          hintLabel: Strings.dob_hint,
                                          wantSuffix: true,
                                          isCalender: true,
                                          onChanged: (val) {
                                            controller.validateFromDuration(val);
                                            setState(() {});
                                          },
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate:
                                                        controller.selectedDate,
                                                    firstDate: DateTime(1950),
                                                    lastDate: DateTime(2050));
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
                                                  .validateFromDuration(formattedDate);
                                            }
                                          },
                                          errorText:
                                              controller.FromDurationModel.value.error,
                                          inputType: TextInputType.text,
                                        );
                                      }))),
                              getTitle("Duration End to"),
                              FadeInUp(
                                  from: 30,
                                  child: AnimatedSize(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Obx(() {
                                        return getReactiveFormField(
                                          node: controller.toDurationNode,
                                          controller: controller.toDurationCtr,
                                          hintLabel: Strings.dob_hint,
                                          wantSuffix: true,
                                          isCalender: true,
                                          onChanged: (val) {
                                            controller.validateToDuration(val);
                                            setState(() {});
                                          },
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: controller
                                                        .selectedAnniversaryDate,
                                                    firstDate: DateTime(1950),
                                                    lastDate: DateTime(2050)
                                                      );
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
                                                  .validateToDuration(formattedDate);
                                            }
                                          },
                                          errorText:
                                              controller.ToDurationModel.value.error,
                                          inputType: TextInputType.text,
                                        );
                                      }))),




                    //         FadeInUp(
                    //     from: 30,
                    //     child: AnimatedSize(
                    //         duration: const Duration(milliseconds: 300),
                    //         child: Obx(() {
                    //           return getReactiveFormField(
                    //             node: controller.fromDurationNode,
                    //             controller: controller.fromDurationCtr,
                    //             hintLabel: "Duration Start From",
                    //             wantSuffix: true,
                    //             time: true,
                    //             onChanged: (val) {
                    //               controller.validateFromDuration(val);
                    //             },
                    //             isReadOnly: true,
                    //             onTap: () async {
                    //               final TimeOfDay? pickedTime =
                    //                   await showTimePicker(
                    //                 context: context,
                    //                 initialTime: TimeOfDay.now(),
                    //               );

                    //               if (pickedTime != null) {
                    //                 final DateTime currentDate = DateTime.now();
                    //                 final DateTime combinedDateTime = DateTime(
                    //                   currentDate.year,
                    //                   currentDate.month,
                    //                   currentDate.day,
                    //                   pickedTime.hour,
                    //                   pickedTime.minute,
                    //                   0,
                    //                   704,
                    //                 );

                    //                 final formattedDateTime =
                    //                     "${pickedTime.format(context)}";

                    //                 //For All Format
                    //                 controller.startTime =
                    //                     "${DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(combinedDateTime)}Z";

                    //                 controller
                    //                     .updateStartTime(formattedDateTime);
                    //                 controller.validateFromDuration(
                    //                     formattedDateTime);
                    //                 setState(() {
                    //                   selectedTime = pickedTime;
                    //                   print(
                    //                       "Selected Time: $formattedDateTime");
                    //                 });
                    //               }
                    //             },
                    //             errorText:
                    //                 controller.FromDurationModel.value.error,
                    //             inputType: TextInputType.none,
                    //           );
                    //         }))),

                    // getTitle("Duration to"),
                    // FadeInUp(
                    //     from: 30,
                    //     child: AnimatedSize(
                    //         duration: const Duration(milliseconds: 300),
                    //         child: Obx(() {
                    //           return getReactiveFormField(
                    //             node: controller.toDurationNode,
                    //             controller: controller.toDurationCtr,
                    //             hintLabel: "Duration to",
                    //             wantSuffix: true,
                    //             time: true,
                    //             onChanged: (val) {
                    //               controller.validateToDuration(val);
                    //             },
                    //             isReadOnly: true,
                    //             onTap: () async {
                    //               final TimeOfDay? pickedTime =
                    //                   await showTimePicker(
                    //                 context: context,
                    //                 initialTime: TimeOfDay.now(),
                    //               );

                    //               if (pickedTime != null) {
                    //                 final DateTime currentDate = DateTime.now();
                    //                 final DateTime combinedDateTime = DateTime(
                    //                   currentDate.year,
                    //                   currentDate.month,
                    //                   currentDate.day,
                    //                   pickedTime.hour,
                    //                   pickedTime.minute,
                    //                   0,
                    //                   704,
                    //                 );

                    //                 final formattedDateTime =
                    //                     "${pickedTime.format(context)}";

                    //                 //For All Format
                    //                 controller.startTime =
                    //                     "${DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(combinedDateTime)}Z";

                    //                 controller.updateEndTime(formattedDateTime);
                    //                 controller
                    //                     .validateToDuration(formattedDateTime);
                    //                 setState(() {
                    //                   selectedTime = pickedTime;
                    //                   print(
                    //                       "Selected Time: $formattedDateTime");
                    //                 });
                    //               }
                    //             },
                    //             errorText:
                    //                 controller.ToDurationModel.value.error,
                    //             inputType: TextInputType.none,
                    //           );
                    //         }))),
                    getTitle("Other Notes"),
                    FadeInUp(
                        from: 30,
                        child: AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            child: Obx(() {
                              return getReactiveFormField(
                                node: controller.NoteNode,
                                controller: controller.noteCtr,
                                hintLabel: "Other Notes",
                                isExpand: true,
                                onChanged: (val) {
                                  controller.validateNote(val);
                                  setState(() {});
                                },
                                errorText: controller.NoteModel.value.error,
                                inputType: TextInputType.text,
                              );
                            }))),
                    // getTitle("Duration From"),
                    // FadeInUp(
                    //     from: 30,
                    //     child: AnimatedSize(
                    //         duration: const Duration(milliseconds: 300),
                    //         child: Obx(() {
                    //           return getReactiveFormField(
                    //             node: controller.fromDurationNode,
                    //             controller: controller.fromDurationCtr,
                    //             hintLabel: "Duration Start From",
                    //             onChanged: (val) {
                    //               controller.validateFromDuration(val);
                    //               setState(() {});
                    //             },
                    //             errorText:
                    //                 controller.FromDurationModel.value.error,
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
                            if (controller.isFormInvalidate.value == true) {
                               controller.AddPackageApi(context);
                            }
                          }, CommonConstant.submit,
                              validate: controller.isFormInvalidate.value);
                        }))
                  ],
                )),
          ),
        ],
      ),
    ));

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
    //         getCommonToolbar(ScreenTitle.reportBug, () {
    //           Get.back();
    //         }),
    //         SingleChildScrollView(
    //           child: Container(
    //             margin: EdgeInsets.only(top: 6.h, left: 1.0.w, right: 1.0.w),
    //             padding: EdgeInsets.only(
    //                 left: 7.0.w, right: 7.0.w, top: 2.h, bottom: 1.h),
    //             child: Form(
    //                 key: controller.formKey,
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     getTitle(ReportBugConstant.selectvendor),
    //                     FadeInUp(
    //                         from: 30,
    //                         child: AnimatedSize(
    //                             duration: const Duration(milliseconds: 300),
    //                             child: Obx(() {
    //                               return getReactiveFormField(
    //                                 node: controller.SelectvendorNode,
    //                                 controller: controller.selectvendorctr,
    //                                 hintLabel: ReportBugConstant.vendor_hint,
    //                                 wantSuffix: true,
    //                                 isdown: true,
    //                                 onChanged: (val) {
    //                                   controller.validateFieldname(val);
    //                                 },
    //                                 errorText: controller
    //                                     .SelectvendorModel.value.error,
    //                                 inputType: TextInputType.text,
    //                               );
    //                             }))),
    //                     getTitle(Strings.dob),
    //                     FadeInUp(
    //                         from: 30,
    //                         child: AnimatedSize(
    //                             duration: const Duration(milliseconds: 300),
    //                             child: Obx(() {
    //                               return getReactiveFormField(
    //                                 node: controller.dateNode,
    //                                 controller: controller.datectr,
    //                                 hintLabel: Strings.dob_hint,
    //                                 wantSuffix: true,
    //                                 isCalender: true,
    //                                 onChanged: (val) {
    //                                   controller.validateDate(val);
    //                                   setState(() {});
    //                                 },
    //                                 onTap: () async {
    //                                   DateTime? pickedDate =
    //                                       await showDatePicker(
    //                                           context: context,
    //                                           initialDate:
    //                                               controller.selectedDate,
    //                                           firstDate: DateTime(1950),
    //                                           lastDate: DateTime.now().add(
    //                                               const Duration(days: 0)));
    //                                   if (pickedDate != null &&
    //                                       pickedDate !=
    //                                           controller.selectedDate) {
    //                                     setState(() {
    //                                       controller.selectedDate = pickedDate;
    //                                     });
    //                                   }
    //                                   if (pickedDate != null) {
    //                                     String formattedDate =
    //                                         DateFormat(Strings.oldDateFormat)
    //                                             .format(pickedDate);
    //                                     controller.updateDate(formattedDate);
    //                                     controller.validateDate(formattedDate);
    //                                   }
    //                                 },
    //                                 errorText: controller.DateModel.value.error,
    //                                 inputType: TextInputType.text,
    //                               );
    //                             }))),
    //                     getTitle(ReportBugConstant.upload),
    //                     FadeInUp(
    //                         from: 30,
    //                         child: AnimatedSize(
    //                             duration: const Duration(milliseconds: 300),
    //                             child: Obx(() {
    //                               return getReactiveFormField(
    //                                 node: controller.ImageNode,
    //                                 controller: controller.imgctr,
    //                                 hintLabel: ReportBugConstant.upload_hint,
    //                                 wantSuffix: true,
    //                                 onChanged: (val) {
    //                                   controller.validateImage(val);
    //                                   setState(() {});
    //                                 },
    //                                 onTap: () async {
    //                                   await controller
    //                                       .actionClickUploadImage(context);
    //                                 },
    //                                 errorText:
    //                                     controller.ImageModel.value.error,
    //                                 inputType: TextInputType.text,
    //                               );
    //                             }))),
    //                     getTitle(ReportBugConstant.upload_videoo),
    //                     FadeInUp(
    //                         from: 30,
    //                         child: AnimatedSize(
    //                             duration: const Duration(milliseconds: 300),
    //                             child: Obx(() {
    //                               return getReactiveFormField(
    //                                 node: controller.VideoNode,
    //                                 controller: controller.videoctr,
    //                                 hintLabel:
    //                                     ReportBugConstant.upload_video_hint,
    //                                 wantSuffix: true,
    //                                 onChanged: (val) {
    //                                   controller.validateVideo(val);
    //                                   setState(() {});
    //                                 },
    //                                 onTap: () async {
    //                                   await controller
    //                                       .actionClickUploadVideo(context);
    //                                 },
    //                                 errorText:
    //                                     controller.VideoModel.value.error,
    //                                 inputType: TextInputType.text,
    //                               );
    //                             }))),
    //                     getTitle(ReportBugConstant.notes),
    //                     FadeInUp(
    //                         from: 30,
    //                         child: AnimatedSize(
    //                             duration: const Duration(milliseconds: 300),
    //                             child: Obx(() {
    //                               return getReactiveFormField(
    //                                 node: controller.NoteNode,
    //                                 controller: controller.notesctr,
    //                                 hintLabel: ReportBugConstant.notes_hint,
    //                                 onChanged: (val) {
    //                                   controller.validateNotes(val);
    //                                   setState(() {});
    //                                 },
    //                                 isExpand: true,
    //                                 errorText: controller.NoteModel.value.error,
    //                                 inputType: TextInputType.text,
    //                               );
    //                             }))),
    //                     SizedBox(
    //                       height: 4.h,
    //                     ),
    //                     FadeInUp(
    //                         from: 50,
    //                         child: Obx(() {
    //                           return getFormButton(() {
    //                             if (controller.isFormInvalidate.value == true) {
    //                               //  controller.AddCourseApi(context);
    //                             }
    //                           }, CommonConstant.submit,
    //                               validate: controller.isFormInvalidate.value);
    //                         }))
    //                   ],
    //                 )),
    //           ),
    //         ),
    //       ]),
    //     ));
  }
}
