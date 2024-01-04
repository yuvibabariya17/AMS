import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Models/CourseModel.dart';
import 'package:booking_app/core/Common/toolbar.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/AddCourse_controller.dart';
import '../../core/constants/strings.dart';
import '../../core/utils/log.dart';
import '../../custom_componannt/CustomeBackground.dart';
import '../../custom_componannt/common_views.dart';
import '../../custom_componannt/form_inputs.dart';

class AddCourseScreen extends StatefulWidget {
  AddCourseScreen({super.key, this.isEdit, this.editCourse});

  bool? isEdit;
  ListofCourse? editCourse;

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final controller = Get.put(AddCourseController());
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    if (widget.isEdit == true && widget.editCourse != null) {
      controller.Studentctr.text = widget.editCourse!.name;
      controller.Feesctr.text = widget.editCourse!.fees.toString();
      controller.Durationctr.text = widget.editCourse!.duration.toString();
      controller.Descctr.text = widget.editCourse!.description;
      controller.Notesctr.text = widget.editCourse!.vendorInfo.toString();
      controller.Idctr.text =
          widget.editCourse!.thumbnailUrlInfo.image.toString();
      // Set other fields as well
    }
    getCourseApi(context);
    super.initState();
  }

  @override
  void dispose() {
    controller.Studentctr.text = "";
    controller.Feesctr.text = "";
    controller.Durationctr.text = "";
    controller.Descctr.text = "";
    controller.Notesctr.text = "";
    controller.Idctr.text = "";

    super.dispose();
  }

  void getCourseApi(BuildContext context) async {
    try {
      if (mounted) {
        await Future.delayed(const Duration(seconds: 1)).then((value) {
          controller.getCourseApi(context);
        });
      }
    } catch (e) {
      logcat("ERROR", e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.hideKeyboard(context);
      },
      child: CustomScaffold(
          body: Column(children: [
        widget.isEdit == true
            ? getCommonToolbar("Update Course", () {
                Get.back();
              })
            : getCommonToolbar(ScreenTitle.addCourse, () {
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
                      margin: EdgeInsets.only(
                          top: 1.h, left: 7.w, right: 7.w, bottom: 1.h),
                      child: Form(
                          key: controller.formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getTitle(AddCourseConstant.course),
                              FadeInUp(
                                  from: 30,
                                  child: AnimatedSize(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Obx(() {
                                        return getReactiveFormField(
                                          node: controller.StudentNode,
                                          controller: controller.Studentctr,
                                          hintLabel: "Enter Course Name",
                                          // isReadOnly: true,
                                          onChanged: (val) {
                                            controller.validateStudent(val);
                                          },
                                          errorText: controller
                                              .StudentModel.value.error,
                                          inputType: TextInputType.name,
                                        );
                                      }))),
                              // getTitle(AddCourseConstant.course),
                              // FadeInUp(
                              //     from: 30,
                              //     child: AnimatedSize(
                              //         duration:
                              //             const Duration(milliseconds: 300),
                              //         child: Obx(() {
                              //           return getReactiveFormField(
                              //             node: controller.CourseNode,
                              //             controller: controller.Coursectr,
                              //             hintLabel:
                              //                 AddCourseConstant.course_hint,
                              //             wantSuffix: true,
                              //             isdown: true,
                              //             onChanged: (val) {
                              //               controller.validateCourse(val);
                              //             },
                              //             isReadOnly: true,
                              //             onTap: () {
                              //               controller.Coursectr.text = "";
                              //               showDropdownMessage(
                              //                   context,
                              //                   controller.setCourseList(),
                              //                   AlertDialogConstant
                              //                       .selectCourse);
                              //             },
                              //             errorText: controller
                              //                 .CourseModel.value.error,
                              //             inputType: TextInputType.none,
                              //           );
                              //         }))),
                              getTitle(AddCourseConstant.fees),
                              FadeInUp(
                                  from: 30,
                                  child: AnimatedSize(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Obx(() {
                                        return getReactiveFormField(
                                          node: controller.FeesNode,
                                          controller: controller.Feesctr,
                                          hintLabel:
                                              AddCourseConstant.priceHint,
                                          onChanged: (val) {
                                            controller.validateFee(val);
                                          },
                                          errorText:
                                              controller.FeesModel.value.error,
                                          inputType: TextInputType.number,
                                        );
                                      }))),
                              getTitle(AddCourseConstant.duration),

                              // FadeInUp(
                              //     from: 30,
                              //     child: AnimatedSize(
                              //         duration:
                              //             const Duration(milliseconds: 300),
                              //         child: Obx(() {
                              //           return getReactiveFormField(
                              //             node: controller.StartNode,
                              //             controller: controller.Startctr,
                              //             hintLabel:
                              //                 AddCourseConstant.startingHint,
                              //             onChanged: (val) {
                              //               controller.validateStartDate(val);
                              //             },
                              //             wantSuffix: true,
                              //             isCalender: true,
                              //             onTap: () async {
                              //               DateTime? pickedDate =
                              //                   await showDatePicker(
                              //                       context: context,
                              //                       initialDate: selectedDate,
                              //                       firstDate: DateTime(1950),
                              //                       lastDate: DateTime(2050));
                              //               if (pickedDate != null &&
                              //                   pickedDate != selectedDate) {
                              //                 setState(() {
                              //                   selectedDate = pickedDate;
                              //                 });
                              //               }
                              //               if (pickedDate != null) {
                              //                 String formattedDate =
                              //                     DateFormat(Strings.dateFormat)
                              //                         .format(pickedDate);
                              //                 controller
                              //                     .updateDate(formattedDate);
                              //                 controller.validateStartDate(
                              //                     formattedDate);
                              //               }
                              //             },
                              //             errorText:
                              //                 controller.StartModel.value.error,
                              //             inputType: TextInputType.none,
                              //           );
                              //         }))),

                              FadeInDown(
                                child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: Obx(() {
                                    return getReactiveFormField(
                                        node: controller.DurationNode,
                                        controller: controller.Durationctr,
                                        hintLabel:
                                            AddCourseConstant.durationHint,
                                        // wantSuffix: true,
                                        // isCalender: true,
                                        // onTap: () async {
                                        //   DateTime? pickedDate =
                                        //       await showDatePicker(
                                        //     context: context,
                                        //     initialDate: selectedDate,
                                        //     firstDate: DateTime(1950),
                                        //     lastDate: DateTime(9999),
                                        //   );
                                        //   if (pickedDate != null &&
                                        //       pickedDate != selectedDate) {
                                        //     setState(() {
                                        //       selectedDate = pickedDate;
                                        //     });
                                        //   }
                                        //   if (pickedDate != null) {
                                        //     String formattedDate =
                                        //         DateFormat(Strings.dateFormat)
                                        //             .format(pickedDate);
                                        //     controller
                                        //         .updateDate(formattedDate);
                                        //     controller.validateStartDate(
                                        //         formattedDate);
                                        //   }
                                        // },
                                        onChanged: (val) {
                                          controller.validateStartDate(val);
                                        },
                                        inputType: TextInputType.number,
                                        errorText: controller
                                            .DurationModel.value.error);
                                  }),
                                ),
                              ),
                              getTitle(CommonConstant.description),
                              FadeInUp(
                                  from: 30,
                                  child: AnimatedSize(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Obx(() {
                                        return getReactiveFormField(
                                          node: controller.DescNode,
                                          controller: controller.Descctr,
                                          hintLabel:
                                              CommonConstant.description_hint,
                                          onChanged: (val) {
                                            controller.validateDescription(val);
                                          },
                                          isExpand: true,
                                          errorText:
                                              controller.DescModel.value.error,
                                          inputType: TextInputType.text,
                                        );
                                      }))),
                              getTitle(AddCourseConstant.notes),
                              FadeInUp(
                                  from: 30,
                                  child: AnimatedSize(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Obx(() {
                                        return getReactiveFormField(
                                          node: controller.NotesNode,
                                          controller: controller.Notesctr,
                                          hintLabel:
                                              AddCourseConstant.notesHint,
                                          onChanged: (val) {
                                            controller.validateNotes(val);
                                          },
                                          isExpand: true,
                                          errorText:
                                              controller.NotesModel.value.error,
                                          inputType: TextInputType.text,
                                        );
                                      }))),
                              getTitle(AddCourseConstant.id),
                              FadeInUp(
                                  from: 30,
                                  child: AnimatedSize(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Obx(() {
                                        return getReactiveFormField(
                                          node: controller.IdNode,
                                          controller: controller.Idctr,
                                          hintLabel: AddCourseConstant.idHint,
                                          wantSuffix: true,
                                          onChanged: (val) {
                                            controller.validateId(val);
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

                                          // () async {
                                          //   await controller
                                          //       .actionClickUploadImage(context);
                                          // },
                                          errorText:
                                              controller.IdModel.value.error,
                                          inputType: TextInputType.none,
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
                                        controller.AddCourseApi(context);
                                      }
                                    }, CommonConstant.submit,
                                        validate:
                                            controller.isFormInvalidate.value);
                                  }))
                            ],
                          )),
                    ),
                  ),
                ),
              ]),
        )
      ])),
    );
  }
}
