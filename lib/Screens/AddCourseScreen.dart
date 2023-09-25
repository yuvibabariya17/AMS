import 'package:animate_do/animate_do.dart';
import 'package:booking_app/core/Common/toolbar.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/AddCourse_controller.dart';
import '../core/constants/assets.dart';
import '../core/constants/strings.dart';
import '../core/utils/log.dart';
import '../custom_componannt/common_views.dart';
import '../custom_componannt/form_inputs.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final controller = Get.put(AddCourseController());

  @override
  void initState() {
    getCourseApi(context);
    super.initState();
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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: Colors.white,
        body: SafeArea(
          minimum: EdgeInsets.only(top: 1.h),
          child: Stack(children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: isDarkMode()
                  ? SvgPicture.asset(
                      Asset.dark_bg,
                      fit: BoxFit.cover,
                    )
                  : SvgPicture.asset(
                      Asset.bg,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getCommonToolbar("Add Course", () {
                    Get.back();
                  }),
                  Expanded(
                    child: CustomScrollView(slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 1.h, left: 7.w, right: 7.w),
                            child: Form(
                                key: controller.formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getTitle(Strings.student),
                                    FadeInUp(
                                        from: 30,
                                        child: AnimatedSize(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            child: Obx(() {
                                              return getReactiveFormField(
                                                node: controller.StudentNode,
                                                controller:
                                                    controller.Studentctr,
                                                hintLabel: Strings.student_hint,
                                                wantSuffix: true,
                                                isdown: true,
                                                onChanged: (val) {},
                                                errorText: controller
                                                    .StudentModel.value.error,
                                                inputType: TextInputType.none,
                                              );
                                            }))),
                                    getTitle(Strings.course),
                                    FadeInUp(
                                        from: 30,
                                        child: AnimatedSize(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            child: Obx(() {
                                              return getReactiveFormField(
                                                node: controller.CourseNode,
                                                controller:
                                                    controller.Coursectr,
                                                hintLabel: Strings.course_hint,
                                                wantSuffix: true,
                                                isdown: true,
                                                onChanged: (val) {
                                                  // Product.validateCompanyname(val);
                                                  setState(() {});
                                                },
                                                onTap: () {
                                                  controller.Coursectr.text =
                                                      "";
                                                  showDropdownMessage(
                                                      context,
                                                      controller
                                                          .setCourseList(),
                                                      'Select Category');
                                                },
                                                errorText: controller
                                                    .CourseModel.value.error,
                                                inputType: TextInputType.none,
                                              );
                                            }))),
                                    getTitle(Strings.fees),
                                    FadeInUp(
                                        from: 30,
                                        child: AnimatedSize(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            child: Obx(() {
                                              return getReactiveFormField(
                                                node: controller.FeesNode,
                                                controller: controller.Feesctr,
                                                hintLabel: Strings.fees_hint,
                                                onChanged: (val) {
                                                  // Product.validateAddressname(val);
                                                  setState(() {});
                                                },
                                                errorText: controller
                                                    .FeesModel.value.error,
                                                inputType: TextInputType.number,
                                              );
                                            }))),
                                    getTitle(Strings.starting),
                                    FadeInUp(
                                        from: 30,
                                        child: AnimatedSize(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            child: Obx(() {
                                              return getReactiveFormField(
                                                node: controller.StartNode,
                                                controller: controller.Startctr,
                                                hintLabel:
                                                    Strings.starting_hint,
                                                onChanged: (val) {
                                                  // Product.validateEmail(val);
                                                  setState(() {});
                                                },
                                                wantSuffix: true,
                                                isStarting: true,
                                                errorText: controller
                                                    .StartModel.value.error,
                                                inputType: TextInputType.none,
                                              );
                                            }))),
                                    getTitle(Strings.description),
                                    FadeInUp(
                                        from: 30,
                                        child: AnimatedSize(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            child: Obx(() {
                                              return getReactiveFormField(
                                                node: controller.DescNode,
                                                controller: controller.Descctr,
                                                hintLabel:
                                                    Strings.description_hint,
                                                onChanged: (val) {
                                                  // Product.validateEmail(val);
                                                  setState(() {});
                                                },
                                                isExpand: true,
                                                errorText: controller
                                                    .DescModel.value.error,
                                                inputType: TextInputType.text,
                                              );
                                            }))),
                                    getTitle(Strings.notes),
                                    FadeInUp(
                                        from: 30,
                                        child: AnimatedSize(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            child: Obx(() {
                                              return getReactiveFormField(
                                                node: controller.NotesNode,
                                                controller: controller.Notesctr,
                                                hintLabel: Strings.notes_hint,
                                                onChanged: (val) {
                                                  // Product.validateEmail(val);
                                                  setState(() {});
                                                },
                                                isExpand: true,
                                                errorText: controller
                                                    .NotesModel.value.error,
                                                inputType: TextInputType.text,
                                              );
                                            }))),
                                    getTitle(Strings.id),
                                    FadeInUp(
                                        from: 30,
                                        child: AnimatedSize(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            child: Obx(() {
                                              return getReactiveFormField(
                                                node: controller.IdNode,
                                                controller: controller.Idctr,
                                                hintLabel: Strings.id_hint,
                                                wantSuffix: true,
                                                onChanged: (val) {
                                                  // Product.validateEmail(val);
                                                  setState(() {});
                                                },
                                                onTap: () async {
                                                  await controller
                                                      .actionClickUploadImage(
                                                          context);
                                                },
                                                errorText: controller
                                                    .IdModel.value.error,
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
                                            if (controller
                                                    .isFormInvalidate.value ==
                                                true) {
                                              controller.AddCourseApi(context);
                                            }
                                          }, Strings.submit,
                                              validate: controller
                                                  .isFormInvalidate.value);
                                        }))
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ]),
                  )
                ]),
          ]),
        ));
  }
}
