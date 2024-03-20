import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Models/StudentCourseListModel.dart';
import 'package:booking_app/Screens/CourseScreen/AddCourseScreen.dart';
import 'package:booking_app/Screens/StudentScreen/AddStudentScreen.dart';
import 'package:booking_app/controllers/AddStudent_courseController.dart';
import 'package:booking_app/core/Common/toolbar.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:booking_app/custom_componannt/common_views.dart';
import 'package:booking_app/custom_componannt/form_inputs.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class AddStudentCourseScreen extends StatefulWidget {
  AddStudentCourseScreen({super.key, this.isEdit, this.editStudentCourse});
  bool? isEdit;
  ListofStudentCourse? editStudentCourse;

  @override
  State<AddStudentCourseScreen> createState() => _AddStudentCourseScreenState();
}

class _AddStudentCourseScreenState extends State<AddStudentCourseScreen> {
  final controller = Get.put(AddStudentCourseController());

  void validateFields() {
    // Validate all fields here
    controller.validateStudent(controller.studentctr.text);
    controller.validateCourse(controller.coursectr.text);
    controller.validateStartDate(controller.startDatectr.text);
    controller.validateFees(controller.Feesctr.text);
    controller.validateImage(controller.imgctr.text);
    controller.validateNotes(controller.notesctr.text);

    // Add validation for other fields as needed
  }

  @override
  void initState() {
    if (widget.isEdit == true && widget.editStudentCourse != null) {
      controller.studentctr.text =
          widget.editStudentCourse!.studentInfo.name.toString();
      controller.coursectr.text =
          widget.editStudentCourse!.courseInfo.name.toString();
      controller.startDatectr.text = DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(widget.editStudentCourse!.startingFrom));
      controller.Feesctr.text = widget.editStudentCourse!.fees.toString();
      controller.imgctr.text =
          widget.editStudentCourse!.idProofUrlInfo.image.toString();
      controller.notesctr.text =
          widget.editStudentCourse!.otherNotes.toString();

      controller.uploadId.value =
          widget.editStudentCourse!.idProofUrl.toString();

      controller.studentId.value =
          widget.editStudentCourse!.studentId.toString();

      controller.studentCourseId.value =
          widget.editStudentCourse!.courseId.toString();
      // Set other fields as well
    }
    if (widget.isEdit == true) {
      validateFields();
    }
    controller.getCourseList(context);
    controller.getStudentList(context);

    super.initState();
  }

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
            getCommonToolbar(
                widget.isEdit == true
                    ? "Update Student Course"
                    : "Add Student Course", () {
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
                                            isDropdown: true,
                                            isReadOnly: true,
                                            isAdd: true,
                                            onChanged: (val) {
                                              controller.validateStudent(val);
                                            },
                                            onTap: () {
                                              //  controller.studentctr.text = "";
                                              showDropDownDialog(
                                                  context,
                                                  controller.setStudentList(),
                                                  "Student List");
                                            },
                                            onAddBtn: () {
                                              Get.to(AddStudentScreen())
                                                  ?.then((value) {
                                                if (value == true) {
                                                  logcat("ISDONE", "DONE");
                                                  controller.getStudentList(
                                                    context,
                                                  );
                                                }
                                              });
                                            },
                                            errorText: controller
                                                .StudentNameModel.value.error,
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
                                            isDropdown: true,
                                            isReadOnly: true,
                                            isAdd: true,
                                            onChanged: (val) {
                                              controller.validateCourse(val);
                                              setState(() {});
                                            },
                                            onAddBtn: () {
                                              Get.to(AddCourseScreen())
                                                  ?.then((value) {
                                                if (value == true) {
                                                  logcat("ISDONE", "DONE");
                                                  controller.getCourseList(
                                                    context,
                                                  );
                                                }
                                              });
                                            },
                                            onTap: () {
                                              //  controller.coursectr.text = "";
                                              showDropDownDialog(
                                                  context,
                                                  controller.setCourseList(),
                                                  "Course List");
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
                                            hintLabel: "Select Date",
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
                                                      builder:
                                                          (BuildContext context,
                                                              Widget? child) {
                                                        return Theme(
                                                          data: isDarkMode()
                                                              ? ThemeData.dark()
                                                                  .copyWith(
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
                                                              : ThemeData
                                                                      .light()
                                                                  .copyWith(
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
                                                      firstDate: DateTime.now(),
                                                      lastDate: DateTime(2100));
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
                                            hintLabel: "Enter Fee",
                                            onChanged: (val) {
                                              controller.validateFees(val);
                                              setState(() {});
                                            },
                                            errorText: controller
                                                .FeesModel.value.error,
                                            inputType: TextInputType.number,
                                          );
                                        }))),

                                // ID PROOF FIELD

                                // getTitle("Id Proof"),
                                // FadeInUp(
                                //     from: 30,
                                //     child: AnimatedSize(
                                //         duration:
                                //             const Duration(milliseconds: 300),
                                //         child: Obx(() {
                                //           return getReactiveFormField(
                                //             node: controller.imageNode,
                                //             controller: controller.imgctr,
                                //             hintLabel: "Select Id Proof",
                                //             wantSuffix: true,
                                //             onChanged: (val) {
                                //               controller.validateImage(val);
                                //               setState(() {});
                                //             },
                                //             isReadOnly: true,
                                //             onTap: () async {
                                //               selectImageFromCameraOrGallery(
                                //                   context, cameraClick: () {
                                //                 controller
                                //                     .actionClickUploadIdProof(
                                //                         context,
                                //                         isCamera: true);
                                //               }, galleryClick: () {
                                //                 controller
                                //                     .actionClickUploadIdProof(
                                //                         context,
                                //                         isCamera: false);
                                //               });
                                //               // await controller.PopupDialogs(context);
                                //               setState(() {});
                                //             },
                                //             // onTap: () async {
                                //             //   await controller
                                //             //       .actionClickUploadImage(context);
                                //             // },
                                //             errorText: controller
                                //                 .ImageModel.value.error,
                                //             inputType: TextInputType.number,
                                //           );
                                //         }))),
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
                                            isExpand: true,
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
                                          if (widget.isEdit == true) {
                                            // Call updateCourse API
                                            controller.UpdateStudentCourseApi(
                                                context,
                                                widget.editStudentCourse!.id);
                                          } else {
                                            // Call AddCourseApi API
                                            controller.AddStudentCourseApi(
                                                context);
                                          }
                                        }
                                      }, CommonConstant.submit,
                                          validate: controller
                                              .isFormInvalidate.value);
                                    })),
                                SizedBox(
                                  height:
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? 0.h
                                          : 4.h,
                                ),
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
