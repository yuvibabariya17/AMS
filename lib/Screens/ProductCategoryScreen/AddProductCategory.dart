import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Models/ProductCatListModel.dart';
import 'package:booking_app/controllers/AddProductCategoryController.dart';
import 'package:booking_app/core/Common/toolbar.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:booking_app/custom_componannt/common_views.dart';
import 'package:booking_app/custom_componannt/form_inputs.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class AddProductCategoryScreen extends StatefulWidget {
  AddProductCategoryScreen({super.key, this.isEdit, this.editProductCategory});
  bool? isEdit;
  ListProductCategory? editProductCategory;

  @override
  State<AddProductCategoryScreen> createState() =>
      _AddProductCategoryScreenState();
}

class _AddProductCategoryScreenState extends State<AddProductCategoryScreen> {
  final controller = Get.put(AddProductCategoryController());

  void validateFields() {
    // Validate all fields here
    controller.validateName(controller.namectr.text);
    controller.validateImage(controller.imgctr.text);
    controller.validateDescription(controller.descCtr.text);
  }

  @override
  void initState() {
    if (widget.isEdit == true && widget.editProductCategory != null) {
      controller.namectr.text = widget.editProductCategory!.name;
      controller.imgctr.text =
          widget.editProductCategory!.uploadInfo.image.toString();
      controller.descCtr.text =
          widget.editProductCategory!.description.toString();

      controller.uploadImageId.value =
          widget.editProductCategory!.uploadId.toString();

      if (widget.isEdit == true) {
        validateFields();
      }

      // Set other fields as well
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
                widget.isEdit == true
                    ? "Update Product Category"
                    : "Add Product Category", () {
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
                                            hintLabel: "Select Photo",
                                            wantSuffix: true,
                                            isPhoto: true,
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
                                getTitle("Description"),
                                FadeInUp(
                                    from: 30,
                                    child: AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Obx(() {
                                          return getReactiveFormField(
                                            node: controller.descNode,
                                            controller: controller.descCtr,
                                            hintLabel: "Enter Description",
                                            isExpand: true,
                                            onChanged: (val) {
                                              controller
                                                  .validateDescription(val);
                                              setState(() {});
                                            },
                                            errorText: controller
                                                .DescriptionModel.value.error,
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
                                            controller.UpdateProductCategory(
                                                context,
                                                widget.editProductCategory!.id);
                                          } else {
                                            controller.AddProductCategory(
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
                                          : 2.h,
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
