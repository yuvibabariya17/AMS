// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Models/StudentModel.dart';
import 'package:booking_app/controllers/AddStudentScreenController.dart';
import 'package:booking_app/core/Common/toolbar.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:booking_app/custom_componannt/common_views.dart';
import 'package:booking_app/custom_componannt/form_inputs.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

class AddStudentScreen extends StatefulWidget {
  AddStudentScreen({super.key, this.isEdit, this.editStudent});
  bool? isEdit;
  StudentList? editStudent;

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final controller = Get.put(AddStudentController());

  void validateFields() {
    // Validate all fields here
    controller.validateName(controller.namectr.text);
    controller.validateEmail(controller.emailctr.text);
    controller.validateAddress(controller.addressctr.text);
    controller.validateImage(controller.imgctr.text);
    controller.validateId(controller.idctr.text);
    controller.validateContact(controller.contactctr.text);

    // Add validation for other fields as needed
  }

  @override
  void initState() {
    if (widget.isEdit == true && widget.editStudent != null) {
      controller.namectr.text = widget.editStudent!.name;
      controller.emailctr.text = widget.editStudent!.email.toString();
      controller.addressctr.text = widget.editStudent!.address.toString();
      controller.imgctr.text = widget.editStudent!.photoUrl.toString();
      controller.idctr.text = widget.editStudent!.idProofUrl.toString();
      controller.contactctr.text = widget.editStudent!.contact.toString();
      // Set other fields as well
    }
    if (widget.isEdit == true) {
      validateFields();
    }

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
                widget.isEdit == true ? "Update Student" : "Add Student", () {
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
                                getTitle("Name"),
                                FadeInUp(
                                    from: 30,
                                    child: AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Obx(() {
                                          return getReactiveFormField(
                                            node: controller.nameNode,
                                            controller: controller.namectr,
                                            hintLabel: "Enter Name",
                                            onChanged: (val) {
                                              controller.validateName(val);
                                            },
                                            errorText: controller
                                                .NameModel.value.error,
                                            inputType: TextInputType.text,
                                          );
                                        }))),
                                getTitle("Email"),
                                FadeInUp(
                                    from: 30,
                                    child: AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Obx(() {
                                          return getReactiveFormField(
                                            node: controller.emailNode,
                                            controller: controller.emailctr,
                                            hintLabel: "Enter Email",
                                            onChanged: (val) {
                                              controller.validateEmail(val);
                                              setState(() {});
                                            },
                                            errorText: controller
                                                .EmailModel.value.error,
                                            inputType: TextInputType.text,
                                          );
                                        }))),
                                getTitle("Address"),
                                FadeInUp(
                                    from: 30,
                                    child: AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Obx(() {
                                          return getReactiveFormField(
                                            node: controller.addressNode,
                                            controller: controller.addressctr,
                                            hintLabel: "Enter Address",
                                            isExpand: true,
                                            onChanged: (val) {
                                              controller.validateAddress(val);
                                              setState(() {});
                                            },
                                            errorText: controller
                                                .AddressModel.value.error,
                                            inputType: TextInputType.text,
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
                                            node: controller.imageNode,
                                            controller: controller.imgctr,
                                            hintLabel: "Upload Photo",
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
                                                );
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
                                getTitle("Id Proof"),
                                FadeInUp(
                                    from: 30,
                                    child: AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Obx(() {
                                          return getReactiveFormField(
                                            node: controller.idNode,
                                            controller: controller.idctr,
                                            hintLabel: "Upload Image",
                                            wantSuffix: true,
                                            onChanged: (val) {
                                              controller.validateId(val);
                                              setState(() {});
                                            },
                                            isReadOnly: true,
                                            onTap: () async {
                                              selectImageFromCameraOrGallery(
                                                  context, cameraClick: () {
                                                controller
                                                    .actionClickUploadIdProof(
                                                        context,
                                                        isCamera: true);
                                              }, galleryClick: () {
                                                controller
                                                    .actionClickUploadIdProof(
                                                  context,
                                                );
                                              });
                                              // await controller.PopupDialogs(context);
                                              setState(() {});
                                            },
                                            // onTap: () async {
                                            //   await controller
                                            //       .actionClickUploadProfile(context);
                                            // },
                                            errorText:
                                                controller.IdModel.value.error,
                                            inputType: TextInputType.none,
                                          );
                                        }))),
                                getTitle("Contact No."),
                                FadeInUp(
                                    from: 30,
                                    child: AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Obx(() {
                                          return getReactiveFormField(
                                            node: controller.contactNode,
                                            controller: controller.contactctr,
                                            hintLabel: "Enter Contact No.",
                                            onChanged: (val) {
                                              controller.validateContact(val);
                                              setState(() {});
                                            },
                                            errorText: controller
                                                .ContactModel.value.error,
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
                                          controller.AddStudent(context);
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
