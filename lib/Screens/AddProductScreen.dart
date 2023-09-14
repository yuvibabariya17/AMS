import 'package:animate_do/animate_do.dart';
import 'package:booking_app/controllers/AddProduct_controller.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../core/Common/toolbar.dart';
import '../core/constants/assets.dart';
import '../core/constants/strings.dart';
import '../core/utils/log.dart';
import '../custom_componannt/common_views.dart';
import '../custom_componannt/form_inputs.dart';
import '../dialogs/dialogs.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final controller = Get.put(addProductController());

  @override
  void initState() {
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
            Center(
                child: Column(children: [
              getToolbar("Add Product", showBackButton: true, callback: () {
                Get.back();
              })
              // HomeAppBar(
              //   title: Strings.add_product,
              //   leading: Asset.backbutton,
              //   isfilter: false,
              //   icon: Asset.filter,
              //   isBack: true,
              //   onClick: () {
              //     Get.back();
              //   },
              // ),
            ])),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 6.h, left: 1.0.w, right: 1.0.w),
                padding: EdgeInsets.only(
                    left: 7.0.w, right: 7.0.w, top: 2.h, bottom: 1.h),
                child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getTitle(Strings.Name),
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node: controller.NameNode,
                                    controller: controller.NameCtr,
                                    hintLabel: Strings.name_hint,
                                    onChanged: (val) {
                                      controller.validatename(val);
                                    },
                                    errorText: controller.NameModel.value.error,
                                    inputType: TextInputType.text,
                                  );
                                }))),
                        getTitle(Strings.product_img),
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node: controller.productimgNode,
                                    controller: controller.productimgCtr,
                                    hintLabel: Strings.product_img_hint,
                                    wantSuffix: true,
                                    onChanged: (val) {
                                      controller.validateProductimg(val);
                                      setState(() {});
                                    },
                                    onTap: () async {
                                      await controller
                                          .actionClickUploadImage(context);
                                    },
                                    errorText:
                                        controller.productimgModel.value.error,
                                    inputType: TextInputType.text,
                                  );
                                }))),
                        getTitle(Strings.description),
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node: controller.descriptionNode,
                                    controller: controller.descriptionCtr,
                                    hintLabel: Strings.description_hint,
                                    onChanged: (val) {
                                      controller.validateDescription(val);
                                      setState(() {});
                                    },
                                    isExpand: true,
                                    errorText:
                                        controller.descriptionModel.value.error,
                                    inputType: TextInputType.text,
                                  );
                                }))),
                        getTitle(Strings.category),
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node: controller.categoryNode,
                                    controller: controller.categroryCtr,
                                    hintLabel: Strings.category_hint,
                                    wantSuffix: true,
                                    isdown: true,
                                    onChanged: (val) {
                                      controller.validateCategory(val);
                                      setState(() {});
                                    },
                                    onTap: () {
                                      controller.categroryCtr.text = "";
                                      showDropdownMessage(
                                          context,
                                          controller.setCategoryList(),
                                          'Select Category');
                                    },
                                    errorText:
                                        controller.categroryModel.value.error,
                                    inputType: TextInputType.text,
                                  );
                                }))),
                        getTitle(Strings.amount),
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node: controller.amountNode,
                                    controller: controller.amountCtr,
                                    hintLabel: Strings.amount_hint,
                                    onChanged: (val) {
                                      controller.validateAmount(val);
                                      setState(() {});
                                    },
                                    errorText:
                                        controller.amountModel.value.error,
                                    inputType: TextInputType.number,
                                  );
                                }))),
                        getTitle(Strings.quantity),
                        FadeInUp(
                            from: 30,
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                    node: controller.quantitynode,
                                    controller: controller.quantityCtr,
                                    hintLabel: Strings.quantity_hint,
                                    onChanged: (val) {
                                      controller.validateQuantity(val);
                                      setState(() {});
                                    },
                                    errorText:
                                        controller.quantityModel.value.error,
                                    inputType: TextInputType.number,
                                  );
                                }))),
                        FadeInUp(
                          from: 50,
                          child: Obx(() {
                            return getFormButton(() {
                              if (controller.isFormInvalidate.value == true) {
                                controller.addProductApi(context);
                              }
                            }, Strings.done,
                                validate: controller.isFormInvalidate.value);
                          }),
                        ),
                        // Container(
                        //     margin: EdgeInsets.only(top: 5.h),
                        //     width: double.infinity,
                        //     height: 6.h,
                        //     child: getButton(() {
                        //       if (controller.isFormInvalidate.value) {
                        //         controller.add
                        //       }
                        //     })),
                      ],
                    )),
              ),
            ),
          ]),
        ));
  }
}
