import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Models/ProductListModel.dart';
import 'package:booking_app/controllers/AddProduct_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/Common/toolbar.dart';
import '../../core/constants/strings.dart';
import '../../core/utils/log.dart';
import '../../custom_componannt/CustomeBackground.dart';
import '../../custom_componannt/common_views.dart';
import '../../custom_componannt/form_inputs.dart';
import '../../dialogs/dialogs.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({super.key, this.isEdit, this.editProduct});
  bool? isEdit;
  ListofProduct? editProduct;
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final controller = Get.put(addProductController());

  @override
  void dispose() {
    controller.NameCtr.text = "";
    controller.productimgCtr.text = "";
    controller.descriptionCtr.text = "";
    controller.categroryCtr.text = "";
    controller.amountCtr.text = "";
    controller.quantityCtr.text = "";



    super.dispose();
  }
  void validateFields() {
    // Validate all fields here
    controller.validatename(controller.NameCtr.text);
    controller.validateProductimg(controller.productimgCtr.text);
    controller.validateDescription(controller.descriptionCtr.text);
    controller.validateCategory(controller.categroryCtr.text);
    controller.validateAmount(controller.amountCtr.text);
    controller.validateQuantity(controller.quantityCtr.text);
   
    
    // Add validation for other fields as needed
  }

  @override
  void initState() {
    if (widget.isEdit == true && widget.editProduct != null) {
      controller.NameCtr.text = widget.editProduct!.name;
      controller.productimgCtr.text =
          widget.editProduct!.uploadInfo.image.toString();
      controller.descriptionCtr.text =
          widget.editProduct!.description.toString();
      controller.categroryCtr.text =
          widget.editProduct!.productCategoryInfo.name.toString();
      controller.amountCtr.text = widget.editProduct!.amount.toString();
      controller.quantityCtr.text = widget.editProduct!.qty.toString();
      if(widget.isEdit == true ){
        validateFields();
      }

      // Set other fields as well
    }

    getProductCategoryAPI(context);
    super.initState();
  }

  void getProductCategoryAPI(BuildContext context) async {
    try {
      if (mounted) {
        await Future.delayed(const Duration(seconds: 1)).then((value) {
          controller.getProductCategory(context);
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
        getCommonToolbar(ScreenTitle.addProduct, () {
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
                            getTitle(CommonConstant.Name),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.NameNode,
                                        controller: controller.NameCtr,
                                        hintLabel: CommonConstant.name_hint,
                                        onChanged: (val) {
                                          controller.validatename(val);
                                        },
                                        errorText:
                                            controller.NameModel.value.error,
                                        inputType: TextInputType.text,
                                      );
                                    }))),
                            getTitle(AddProductConstant.product_img),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.productimgNode,
                                        controller: controller.productimgCtr,
                                        hintLabel:
                                            AddProductConstant.product_img_hint,
                                        wantSuffix: true,
                                        onChanged: (val) {
                                          controller.validateProductimg(val);
                                          setState(() {});
                                        },
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
                                        isReadOnly: true,
                                        // onTap: () async {
                                        //   await controller
                                        //       .actionClickUploadImage(context);
                                        // },
                                        errorText: controller
                                            .productimgModel.value.error,
                                        inputType: TextInputType.text,
                                      );
                                    }))),
                            getTitle(CommonConstant.description),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.descriptionNode,
                                        controller: controller.descriptionCtr,
                                        hintLabel:
                                            CommonConstant.description_hint,
                                        onChanged: (val) {
                                          controller.validateDescription(val);
                                          setState(() {});
                                        },
                                        isExpand: true,
                                        errorText: controller
                                            .descriptionModel.value.error,
                                        inputType: TextInputType.text,
                                      );
                                    }))),
                            getTitle(AddProductConstant.category),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.categoryNode,
                                        controller: controller.categroryCtr,
                                        hintLabel:
                                            AddProductConstant.category_hint,
                                        wantSuffix: true,
                                        isdown: true,
                                        onChanged: (val) {
                                          controller.validateCategory(val);
                                          setState(() {});
                                        },
                                        isReadOnly: true,
                                        onTap: () {
                                          controller.categroryCtr.text = "";

                                          showDropDownDialog(
                                              context,
                                              controller.setCategoryList(),
                                              "Select Category");
                                          // showDropdownMessage(
                                          //     context,
                                          //     controller.setCategoryList(),
                                          //     'Select Category');
                                        },
                                        errorText: controller
                                            .categroryModel.value.error,
                                        inputType: TextInputType.none,
                                      );
                                    }))),
                            getTitle(CommonConstant.amount),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.amountNode,
                                        controller: controller.amountCtr,
                                        hintLabel: CommonConstant.amount_hint,
                                        onChanged: (val) {
                                          controller.validateAmount(val);
                                          setState(() {});
                                        },
                                        errorText:
                                            controller.amountModel.value.error,
                                        inputType: TextInputType.number,
                                      );
                                    }))),
                            getTitle(AddProductConstant.quantity),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.quantitynode,
                                        controller: controller.quantityCtr,
                                        hintLabel:
                                            AddProductConstant.quantity_hint,
                                        onChanged: (val) {
                                          controller.validateQuantity(val);
                                          setState(() {});
                                        },
                                        errorText: controller
                                            .quantityModel.value.error,
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
                                  // controller.addProductApi(context);
                                  if (controller.isFormInvalidate.value ==
                                      true) {
                                    controller.addProductApi(context);
                                  }
                                }, CommonConstant.done,
                                    validate:
                                        controller.isFormInvalidate.value);
                              }),
                            ),
                          ],
                        )),
                  ),
                )
              ]),
        )
      ])),
    );
  }
}
