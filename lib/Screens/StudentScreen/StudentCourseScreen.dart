import 'package:animate_do/animate_do.dart';
import 'package:booking_app/controllers/StudentCourseController.dart';
import 'package:booking_app/core/Common/toolbar.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:booking_app/custom_componannt/common_views.dart';
import 'package:booking_app/custom_componannt/form_inputs.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class StudentCourseScreen extends StatefulWidget {
  const StudentCourseScreen({super.key});

  @override
  State<StudentCourseScreen> createState() => _StudentCourseScreenState();
}

class _StudentCourseScreenState extends State<StudentCourseScreen> {
  final controller = Get.put(StudentCourseController());

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
            getCommonToolbar("Student Course", () {
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
                                getTitle("Student"),
                                FadeInUp(
                                    from: 30,
                                    child: AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Obx(() {
                                          return getReactiveFormField(
                                            node: controller.studentNode,
                                            controller: controller.studentctr,
                                            hintLabel: "Select Student",
                                            wantSuffix: true,
                                            isdown: true,
                                            onChanged: (val) {
                                              controller.validateStudent(val);
                                            },
                                            errorText: controller
                                                .StudentModel.value.error,
                                            inputType: TextInputType.none,
                                          );
                                        }))),
                                getTitle("Course"),
                                FadeInUp(
                                    from: 30,
                                    child: AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Obx(() {
                                          return getReactiveFormField(
                                            node: controller.courseNode,
                                            controller: controller.coursectr,
                                            hintLabel: "Select Course",
                                            wantSuffix: true,
                                            isdown: true,
                                            onChanged: (val) {
                                              controller.validateCourse(val);
                                              setState(() {});
                                            },
                                            errorText: controller
                                                .CourseModel.value.error,
                                            inputType: TextInputType.none,
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
                                            node: controller.startNode,
                                            controller: controller.startDatectr,
                                            hintLabel: "Start Date",
                                            wantSuffix: true,
                                            isCalender: true,
                                            onChanged: (val) {
                                              controller.validateStartDate(val);
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
                                                              days: 0)));
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
                                                controller
                                                    .updateDate(formattedDate);
                                                controller.validateStartDate(
                                                    formattedDate);
                                              }
                                            },
                                            errorText: controller
                                                .StartModel.value.error,
                                            inputType: TextInputType.text,
                                          );
                                        }))),
                                getTitle("Fees"),
                                FadeInUp(
                                    from: 30,
                                    child: AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Obx(() {
                                          return getReactiveFormField(
                                            node: controller.feesNode,
                                            controller: controller.Feesctr,
                                            hintLabel: "Fees",
                                            isExpand: true,
                                            onChanged: (val) {
                                              controller.validateFees(val);
                                              setState(() {});
                                            },
                                            errorText: controller
                                                .FeesModel.value.error,
                                            inputType: TextInputType.number,
                                          );
                                        }))),
                                getTitle("Id Proof"),
                                FadeInUp(
                                    from: 30,
                                    child: AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Obx(() {
                                          return getReactiveFormField(
                                            node: controller.imageNode,
                                            controller: controller.imgctr,
                                            hintLabel: "Select Id Proof",
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
                                getTitle("Other Notes"),
                                FadeInUp(
                                    from: 30,
                                    child: AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Obx(() {
                                          return getReactiveFormField(
                                            node: controller.notesNode,
                                            controller: controller.notesctr,
                                            hintLabel: "Enter Notes",
                                            onChanged: (val) {
                                              controller.validateNotes(val);
                                              setState(() {});
                                            },
                                            errorText: controller
                                                .NotesModel.value.error,
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
