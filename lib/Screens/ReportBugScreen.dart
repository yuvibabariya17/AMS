import 'package:animate_do/animate_do.dart';
import 'package:booking_app/custom_componannt/customeBackground.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../controllers/ReportBug_controller.dart';
import '../core/Common/toolbar.dart';
import '../core/constants/strings.dart';
import '../custom_componannt/common_views.dart';
import '../custom_componannt/form_inputs.dart';

class ReportBugScreen extends StatefulWidget {
  const ReportBugScreen({super.key});

  @override
  State<ReportBugScreen> createState() => _ReportBugScreenState();
}

class _ReportBugScreenState extends State<ReportBugScreen> {
  final controller = Get.put(ReportBugController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Container(
      child: Column(
        children: [
          getCommonToolbar(ScreenTitle.reportBug, () {
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
                    getTitle(ReportBugConstant.selectvendor),
                    FadeInUp(
                        from: 30,
                        child: AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            child: Obx(() {
                              return getReactiveFormField(
                                node: controller.SelectvendorNode,
                                controller: controller.selectvendorctr,
                                hintLabel: ReportBugConstant.vendor_hint,
                                wantSuffix: true,
                                isdown: true,
                                onChanged: (val) {
                                  controller.validateFieldname(val);
                                },
                                errorText:
                                    controller.SelectvendorModel.value.error,
                                inputType: TextInputType.text,
                              );
                            }))),
                    getTitle(Strings.dob),
                    FadeInUp(
                        from: 30,
                        child: AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            child: Obx(() {
                              return getReactiveFormField(
                                node: controller.dateNode,
                                controller: controller.datectr,
                                hintLabel: Strings.dob_hint,
                                wantSuffix: true,
                                isCalender: true,
                                onChanged: (val) {
                                  controller.validateDate(val);
                                  setState(() {});
                                },
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: controller.selectedDate,
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 0)));
                                  if (pickedDate != null &&
                                      pickedDate != controller.selectedDate) {
                                    setState(() {
                                      controller.selectedDate = pickedDate;
                                    });
                                  }
                                  if (pickedDate != null) {
                                    String formattedDate =
                                        DateFormat(Strings.oldDateFormat)
                                            .format(pickedDate);
                                    controller.updateDate(formattedDate);
                                    controller.validateDate(formattedDate);
                                  }
                                },
                                errorText: controller.DateModel.value.error,
                                inputType: TextInputType.none,
                              );
                            }))),
                    getTitle(ReportBugConstant.upload),
                    FadeInUp(
                        from: 30,
                        child: AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            child: Obx(() {
                              return getReactiveFormField(
                                node: controller.ImageNode,
                                controller: controller.imgctr,
                                hintLabel: ReportBugConstant.upload_hint,
                                wantSuffix: true,
                                onChanged: (val) {
                                  controller.validateImage(val);
                                  setState(() {});
                                },
                                onTap: () async {
                                  selectImageFromCameraOrGallery(context,
                                      cameraClick: () {
                                    controller.actionClickUploadImage(context,
                                        isCamera: true);
                                  }, galleryClick: () {
                                    controller.actionClickUploadImage(context,
                                        isCamera: false);
                                  });
                                  // await controller.PopupDialogs(context);
                                  setState(() {});
                                },
                                // onTap: () async {
                                //   await controller
                                //       .actionClickUploadImage(context);
                                // },
                                errorText: controller.ImageModel.value.error,
                                inputType: TextInputType.none,
                              );
                            }))),
                    getTitle(ReportBugConstant.upload_videoo),
                    FadeInUp(
                        from: 30,
                        child: AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            child: Obx(() {
                              return getReactiveFormField(
                                node: controller.VideoNode,
                                controller: controller.videoctr,
                                hintLabel: ReportBugConstant.upload_video_hint,
                                wantSuffix: true,
                                onChanged: (val) {
                                  controller.validateVideo(val);
                                  setState(() {});
                                },
                                onTap: () async {
                                  selectImageFromCameraOrGallery(context,
                                      cameraClick: () {
                                    controller.actionClickUploadVideo(context,
                                        isCamera: true);
                                  }, galleryClick: () {
                                    controller.actionClickUploadVideo(context,
                                        isCamera: false);
                                  });
                                  // await controller.PopupDialogs(context);
                                  setState(() {});
                                },
                                // onTap: () async {
                                //   await controller
                                //       .actionClickUploadVideo(context);
                                // },
                                errorText: controller.VideoModel.value.error,
                                inputType: TextInputType.text,
                              );
                            }))),
                    getTitle(ReportBugConstant.notes),
                    FadeInUp(
                        from: 30,
                        child: AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            child: Obx(() {
                              return getReactiveFormField(
                                node: controller.NoteNode,
                                controller: controller.notesctr,
                                hintLabel: ReportBugConstant.notes_hint,
                                onChanged: (val) {
                                  controller.validateNotes(val);
                                  setState(() {});
                                },
                                isExpand: true,
                                errorText: controller.NoteModel.value.error,
                                inputType: TextInputType.text,
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
                              //  controller.AddCourseApi(context);
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
