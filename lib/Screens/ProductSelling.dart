import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Models/ProductSellListModel.dart';
import 'package:booking_app/Screens/CustomerScreen/AddCustomerScreen.dart';
import 'package:booking_app/controllers/ProductSellingController.dart';
import 'package:booking_app/core/Common/toolbar.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
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
import '../controllers/home_screen_controller.dart';

class ProductSellingScreen extends StatefulWidget {
  const ProductSellingScreen({super.key});

  @override
  State<ProductSellingScreen> createState() => _ProductSellingScreenState();
}

class _ProductSellingScreenState extends State<ProductSellingScreen> {
  final controller = Get.put(ProductSellingController());
  late List<DataColumn> columns = [];
  @override
  void initState() {
    controller.getCustomerList(context);
    controller.getProductCategoryList(context);
    controller.getProductSellApi(context);
    columns = [
      setColumn("No."),
      setColumn("Category"),
      setColumn('Brand'),
      setColumn('Product'),
      setColumn('Qty'),
      setColumn('Price'),
    ];
    super.initState();
  }

  DataColumn setColumn(title) {
    return DataColumn(
        label: Expanded(
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: fontMedium, fontSize: 2.h, color: white),
        ),
      ),
    ));
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
            getCommonToolbar("Product Sale", () {
              Get.back();
            }),
            Expanded(
              child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Obx(() {
                        switch (controller.state.value) {
                          case ScreenState.apiLoading:
                          case ScreenState.noNetwork:
                          case ScreenState.noDataFound:
                          case ScreenState.apiError:
                            return Container(
                              margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                              height: SizerUtil.height / 1.5,
                              child: apiOtherStates(controller.state.value),
                            );
                          case ScreenState.apiSuccess:
                            return Container(
                                margin: EdgeInsets.only(bottom: 3.h, top: 2.h),
                                child: apiSuccess(controller.state.value));
                          default:
                            Container();
                        }
                        return Container();
                      }),
                    ),
                  ]),
            ),
          ],
        ),
      )),
    );
  }

  PopupMenuItem<Object> setPopupMenuItem(value, title, icon) {
    return PopupMenuItem(
      value: value,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontFamily: fontMedium, fontSize: 2.0.h),
              ),
              Icon(
                icon,
                size: 2.6.h,
              )
            ],
          ),
        ],
      ),
    );
  }

  AnimationController? controllers;
  List<Map<String, dynamic>> productList = [];
  void addProduct(
    context,
  ) async {
    controller.clearFields(context);
    var result = await showModalBottomSheet(
        context: context,
        transitionAnimationController: controllers,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(13.w),
        )),
        isScrollControlled: true,
        constraints: BoxConstraints(
            maxWidth: SizerUtil.width // here increase or decrease in width
            ),
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  color: Colors.white,
                  child: Wrap(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.w),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: black,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.w),
                                  )),
                              padding: EdgeInsets.only(top: 2.5.h, bottom: 2.h),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Select Product",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontFamily: fontBold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            bottom: 0,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.close_rounded,
                                        color: Colors.white,
                                        size: SizerUtil.deviceType ==
                                                DeviceType.mobile
                                            ? 25
                                            : 50,
                                      ),
                                    ]),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 5.w, right: 5.w, top: 1.5.h),
                        child: Column(children: [
                          FadeInDown(
                            child: AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              child: Obx(() {
                                return getReactiveFormField(
                                    node: controller.productCatNode,
                                    controller: controller.productCatctr,
                                    hintLabel: "Select Product Category",
                                    onChanged: (val) {
                                      // controller.validateState(val);
                                    },
                                    onTap: () {
                                      showDropDownDialog(
                                          context,
                                          controller.setProductCategoryList(),
                                          "Product Category List");
                                    },
                                    isReadOnly: true,
                                    wantSuffix: true,
                                    isdown: true,
                                    isEnable: true,
                                    inputType: TextInputType.none,
                                    errorText:
                                        controller.ProductcatModel.value.error);
                              }),
                            ),
                          ),
                          FadeInDown(
                            child: AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              child: Obx(() {
                                return getReactiveFormField(
                                    node: controller.brandNode,
                                    controller: controller.brandctr,
                                    hintLabel: "Select Brand",
                                    onChanged: (val) {
                                      // controller.validateState(val);
                                    },
                                    onTap: () {
                                      if (controller
                                          .productCatctr.text.isEmpty) {
                                        // Show popup dialog if product category is not selected
                                        controller.PopupDialogs(
                                          context,
                                          "Product Sale",
                                          "Product Category Field is Required",
                                        );
                                      } else {
                                        // Open brand list dialog if product category is selected
                                        showDropDownDialog(
                                            context,
                                            controller.setBrand(),
                                            "Brand List");
                                      }
                                    },
                                    isReadOnly: true,
                                    wantSuffix: true,
                                    isdown: true,
                                    isEnable: true,
                                    inputType: TextInputType.none,
                                    errorText:
                                        controller.BrandModel.value.error);
                              }),
                            ),
                          ),
                          FadeInDown(
                            child: AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              child: Obx(() {
                                return getReactiveFormField(
                                    node: controller.productNameNode,
                                    controller: controller.productNamectr,
                                    hintLabel: "Select Product",
                                    onChanged: (val) {
                                      controller.validateProduct(val);
                                    },
                                    onTap: () {
                                      if (controller.brandctr.text.isEmpty &&
                                          controller
                                              .productCatctr.text.isEmpty) {
                                        controller.PopupDialogs(
                                          context,
                                          "Product Sale",
                                          "Product Category Field and Brand Field is Required",
                                        );
                                      } else if (controller
                                          .brandctr.text.isEmpty) {
                                        controller.PopupDialogs(
                                          context,
                                          "Product Sale",
                                          "Brand Field is Required",
                                        );
                                      } else {
                                        showDropDownDialog(
                                            context,
                                            controller.setProductList(),
                                            "Product List");
                                      }
                                    },
                                    isReadOnly: true,
                                    wantSuffix: true,
                                    isdown: true,
                                    isEnable: true,
                                    inputType: TextInputType.text,
                                    errorText:
                                        controller.BrandModel.value.error);
                              }),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: getReactiveFormField(
                                  node: controller.qtyNode,
                                  controller: controller.qtyctr,
                                  hintLabel: 'Enter Qty',
                                  onChanged: (value) {
                                    controller.validateQty(value);
                                  },
                                  onTap: () {},
                                  inputType: TextInputType.number,
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: getReactiveFormField(
                                  node: controller.priceNode,
                                  controller: controller.pricectr,
                                  hintLabel: "Enter Price",
                                  onChanged: (value) {
                                    controller.validatePrice(value);
                                  },
                                  isReadOnly: true,
                                  onTap: () {},
                                  inputType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                          Column(children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.info,
                                  color: black,
                                  size: 2.5.h,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 1.w),
                                  child: Text(
                                    "Product is Out of Stock",
                                    style: TextStyle(
                                        fontFamily: fontRegular,
                                        fontSize: 12.sp),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ]),
                      ),
                      Obx(() {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 40.w,
                              margin: EdgeInsets.only(top: 2.h),
                              child: getFormButton(() {
                                if (controller.isFormInvalidate.value == true) {
                                  productList.add({
                                    "product_category_id":
                                        controller.productCategoryId.value,
                                    "brand_category_id":
                                        controller.brandCategoryId.value,
                                    "product_id": controller.productId.value,
                                    "qty":
                                        int.tryParse(controller.qtyctr.text) ??
                                            0,
                                    // "price": double.tryParse(
                                    //         controller.pricectr.text) ??
                                    //     0.0,
                                  });
                                  controller.productctr.text =
                                      productList.length.toString() +
                                          ' Product Selected';
                                  logcat("productListssss:::",
                                      jsonEncode(productList));
                                  logcat("LENGTH:::",
                                      productList.length.toString());
                                  controller.productSellApi(
                                      context, productList);
                                }
                                logcat("FILTER_APPLY",
                                    controller.isFormInvalidate.value);
                              }, "Submit",
                                  validate: controller.isFormInvalidate.value),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Container(
                              width: 40.w,
                              margin: EdgeInsets.only(top: 2.h),
                              child: getFormButton(() {
                                productList.add({
                                  "product_category_id":
                                      controller.productCategoryId.value,
                                  "brand_category_id":
                                      controller.brandCategoryId.value,
                                  "product_id": controller.productId.value,
                                  "qty":
                                      int.tryParse(controller.qtyctr.text) ?? 0,
                                  // "price": double.tryParse(
                                  //         controller.pricectr.text) ??
                                  //     0.0,
                                });
                                controller.productctr.text =
                                    productList.length.toString() +
                                        ' Product Selected';
                                controller.clearFields(context);
                              }, "Add More",
                                  validate: controller.isFormInvalidate.value),
                            )
                          ],
                        );
                      }),
                      SizedBox(
                        height: 2.h,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
    // Check if the bottom sheet was dismissed by pressing submit button
    if (result != null && result == true) {
      controller.getProductSellApi(context);
    }
  }

  Widget apiSuccess(ScreenState state) {
    logcat("LENGTH", controller.productList.length.toString());
    if (state == ScreenState.apiSuccess && controller.productList.isNotEmpty) {
      return Column(
        children: [
          getProductList(),
          controller.productList.isNotEmpty
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                      padding:
                          EdgeInsets.only(left: 5.w, right: 5.w, bottom: 3.h),
                      child: Obx(
                        () {
                          List<DataRow> newDataList = [];
                          for (var i = 0;
                              i < controller.productList.length;
                              i++) {
                            int index = i + 1;
                            var uploadList =
                                controller.productList[i] as ProductSaleInfo;
                            newDataList.add(DataRow(
                              cells: [
                                DataCell(
                                  Center(
                                    child: Text(
                                      index.toString(),
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: fontMedium,
                                          fontSize: 1.8.h),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Center(
                                    child: Text(
                                      uploadList.productCategoryInfo.name
                                          .toString(),
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: fontMedium,
                                          fontSize: 1.8.h),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Center(
                                    child: Text(
                                      uploadList.brandCategoryInfo.name
                                          .toString(),
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: fontMedium,
                                        fontSize: 1.8.h,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Center(
                                    child: Text(
                                      uploadList.productInfo.name.toString(),
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: fontMedium,
                                        fontSize: 1.8.h,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Center(
                                    child: Text(
                                      uploadList.qty.toString(),
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: fontMedium,
                                        fontSize: 1.8.h,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Center(
                                    child: Text(
                                      uploadList.productInfo.amount.toString(),
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: fontMedium,
                                        fontSize: 1.8.h,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ));
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FadeInUp(
                                child: DataTable(
                                  dataTextStyle: TextStyle(
                                      fontFamily: fontMedium,
                                      fontSize: 2.h,
                                      color: black),
                                  columnSpacing: 13,
                                  horizontalMargin: 13,
                                  columns: columns,
                                  headingRowColor:
                                      MaterialStateProperty.all(primaryColor),
                                  headingTextStyle:
                                      const TextStyle(fontFamily: fontMedium),
                                  border: TableBorder.all(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(1.h),
                                          topRight: Radius.circular(1.h))),
                                  clipBehavior: Clip.antiAlias,
                                  showBottomBorder: true,
                                  // ignore: invalid_use_of_protected_member
                                  rows: newDataList,
                                ),
                              ),
                            ],
                          );
                        },
                      )),
                )
              : SizedBox(
                  height: SizerUtil.height / 1.32,
                  child: Center(
                    child: Text(
                      "Data Not Found",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: fontMedium, fontSize: 12.sp),
                    ),
                  ),
                ),
        ],
      );
    } else {
      return Container(
        height: SizerUtil.height / 1.3,
        child: Center(
          child: Container(
            child: Text(
              CommonConstant.noDataFound,
              style: TextStyle(
                  fontFamily: fontMedium,
                  fontSize: 12.sp,
                  color: isDarkMode() ? white : black),
            ),
          ),
        ),
      );
    }
  }

  getProductList() {
    return Container(
      margin: EdgeInsets.only(left: 1.0.w, right: 1.0.w),
      padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w, bottom: 1.h),
      child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getTitle("Sale Date"),
              FadeInUp(
                  from: 30,
                  child: AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      child: Obx(() {
                        return getReactiveFormField(
                          node: controller.orderNode,
                          controller: controller.orderDatectr,
                          hintLabel: "Select Sale Date",
                          wantSuffix: true,
                          isCalender: true,
                          onChanged: (val) {
                            controller.validateProductDate(val);
                            setState(() {});
                          },
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: controller.selectedStartDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050)

                                // .add(const Duration(
                                //     days: 0))

                                );
                            if (pickedDate != null &&
                                pickedDate != controller.selectedStartDate) {
                              setState(() {
                                controller.selectedStartDate = pickedDate;
                              });
                            }
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat(Strings.oldDateFormat)
                                      .format(pickedDate);
                              controller.updateDate(formattedDate);
                              controller.validateProductDate(formattedDate);
                            }
                          },
                          errorText: controller.OrderDateModel.value.error,
                          inputType: TextInputType.text,
                        );
                      }))),
              getTitle("Customer"),
              FadeInUp(
                  from: 30,
                  child: AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      child: Obx(() {
                        return getReactiveFormField(
                          node: controller.customerNode,
                          controller: controller.customerctr,
                          hintLabel: "Select Customer",
                          wantSuffix: true,
                          //  isdown: true,
                          isAdd: true,
                          isDropdown: true,
                          onChanged: (val) {
                            controller.validateCustomer(val);
                            setState(() {});
                          },
                          onAddBtn: () {
                            Get.to(AddCustomerScreen())?.then((value) {
                              if (value == true) {
                                logcat("ISDONE", "DONE");
                                controller.getCustomerList(
                                  context,
                                );
                              }
                            });
                          },
                          onTap: () {
                            showDropDownDialog(context,
                                controller.setCustomerList(), "Customer List");

                            // controller.customerctr.text = "";
                          },
                          errorText: controller.ProductModel.value.error,
                          inputType: TextInputType.none,
                        );
                      }))),
              getTitle("Product"),
              FadeInUp(
                  from: 30,
                  child: AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      child: Obx(() {
                        return getReactiveFormField(
                          node: controller.productNode,
                          controller: controller.productctr,
                          hintLabel: "Select Product",
                          wantSuffix: true,
                          isReadOnly: true,
                          isdown: true,
                          onChanged: (val) {
                            controller.validateName(val);
                            setState(() {});
                          },
                          onTap: () async {
                            if (controller.orderDatectr.text.isEmpty &&
                                controller.customerctr.text.isEmpty) {
                              controller.PopupDialogs(
                                context,
                                "Product Sale",
                                "Sale Date and Customer Field is Required",
                              );
                            } else if (controller.customerctr.text.isEmpty) {
                              controller.PopupDialogs(
                                context,
                                "Product Sale",
                                "Customer Field is Required",
                              );
                            } else if (controller.orderDatectr.text.isEmpty &&
                                controller.customerctr.text.isNotEmpty) {
                              controller.PopupDialogs(
                                context,
                                "Product Sale",
                                "Sale Date Field is Required",
                              );
                            } else {
                              addProduct(
                                context,
                              );
                            }
                          },
                          errorText: controller.ProductSelectModel.value.error,
                          inputType: TextInputType.none,
                        );
                      }))),
            ],
          )),
    );
  }

  Widget apiOtherStates(state) {
    if (state == ScreenState.apiLoading) {
      return Center(
          child: ClipOval(
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: isDarkMode() ? black : white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Image.asset(
            "assets/gif/apiloader.gif",
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ));
    }

    Widget? button;
    if (state == ScreenState.noDataFound) {
      button = getMiniButton(() {
        Get.back();
      }, "Back");
    }
    if (state == ScreenState.noNetwork) {
      button = getMiniButton(() {}, "Try Again");
    }

    if (state == ScreenState.apiError) {
      button = getMiniButton(() {
        Get.back();
      }, "Back");
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            controller.message.value,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: fontMedium, fontSize: 12.sp),
          ),
        ),
      ],
    );
  }
}
