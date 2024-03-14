import 'package:animate_do/animate_do.dart';
import 'package:booking_app/controllers/ProductSellingController.dart';
import 'package:booking_app/core/Common/toolbar.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:booking_app/custom_componannt/common_views.dart';
import 'package:booking_app/custom_componannt/form_inputs.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ProductSellingScreen extends StatefulWidget {
  const ProductSellingScreen({super.key});

  @override
  State<ProductSellingScreen> createState() => _ProductSellingScreenState();
}

class _ProductSellingScreenState extends State<ProductSellingScreen> {
  final controller = Get.put(ProductSellingController());

  @override
  void initState() {
    controller.getCustomerList(context);
    controller.getProductCategoryList(context, true);
    controller.getBrandCategoryList(context, true);

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
            getCommonToolbar("Product Sale", () {
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
                                getTitle("Sale Date"),
                                FadeInUp(
                                    from: 30,
                                    child: AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Obx(() {
                                          return getReactiveFormField(
                                            node: controller.orderNode,
                                            controller: controller.orderDatectr,
                                            hintLabel: "Select Sale Date",
                                            wantSuffix: true,
                                            isCalender: true,
                                            onChanged: (val) {
                                              controller
                                                  .validateProductDate(val);
                                              setState(() {});
                                            },
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate: controller
                                                          .selectedStartDate,
                                                      firstDate: DateTime.now(),
                                                      lastDate: DateTime(2050)

                                                      // .add(const Duration(
                                                      //     days: 0))

                                                      );
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
                                                controller.validateProductDate(
                                                    formattedDate);
                                              }
                                            },
                                            errorText: controller
                                                .OrderDateModel.value.error,
                                            inputType: TextInputType.text,
                                          );
                                        }))),
                                getTitle("Customer"),
                                FadeInUp(
                                    from: 30,
                                    child: AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Obx(() {
                                          return getReactiveFormField(
                                            node: controller.customerNode,
                                            controller: controller.customerctr,
                                            hintLabel: "Select Customer",
                                            wantSuffix: true,
                                            isdown: true,
                                            onChanged: (val) {
                                              controller.validateCustomer(val);
                                              setState(() {});
                                            },
                                            onTap: () {
                                              controller.customerctr.text = "";

                                              showDropDownDialog(
                                                  context,
                                                  controller.setCustomerList(),
                                                  "Customer List");
                                            },
                                            errorText: controller
                                                .ProductModel.value.error,
                                            inputType: TextInputType.none,
                                          );
                                        }))),
                                getTitle("Product"),
                                FadeInUp(
                                    from: 30,
                                    child: AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Obx(() {
                                          return getReactiveFormField(
                                            node: controller.productCatNode,
                                            controller:
                                                controller.productCatctr,
                                            hintLabel: "Select Product",
                                            wantSuffix: true,
                                            isReadOnly: true,
                                            isdown: true,
                                            onChanged: (val) {
                                              controller.validateProduct(val);
                                              setState(() {});
                                            },
                                            onTap: () async {
                                              addProduct(
                                                context,
                                              );
                                            },
                                            //  isReadOnly: true,
                                            errorText: controller
                                                .ProductModel.value.error,
                                            inputType: TextInputType.none,
                                          );
                                        }))),

                                // getTitle("Other Notes"),
                                // FadeInUp(
                                //     from: 30,
                                //     child: AnimatedSize(
                                //         duration:
                                //             const Duration(milliseconds: 300),
                                //         child: Obx(() {
                                //           return getReactiveFormField(
                                //             node: controller.notesNode,
                                //             controller: controller.notesctr,
                                //             hintLabel: "Enter Notes",
                                //             onChanged: (val) {
                                //               controller.validateNotes(val);
                                //               setState(() {});
                                //             },
                                //             errorText: controller
                                //                 .NotesModel.value.error,
                                //             inputType: TextInputType.text,
                                //           );
                                //         }))),
                                SizedBox(
                                  height: 4.h,
                                ),
                                FadeInUp(
                                    from: 50,
                                    child: Obx(() {
                                      return getFormButton(() {
                                        if (controller.isFormInvalidate.value ==
                                            true) {
                                          controller.productSellApi(context);
                                        }
                                      }, CommonConstant.submit,
                                          validate: controller
                                              .isFormInvalidate.value);
                                    })),
                                SizedBox(
                                  height: 5.h,
                                ),
                              ],
                            )),
                      ),
                    ),
                  ]),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 7.h, left: 7.w),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: DataTable(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: isDarkMode()
                            ? white
                            : black), // Adjust color as needed
                  ),
                  columns: [
                    DataColumn(label: Text('No.')),
                    DataColumn(label: Text('Category')),
                    DataColumn(label: Text('Brand')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Qty')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Hair')),
                      DataCell(Text('Loreal Paris')),
                      DataCell(Text('Hair Serum')),
                      DataCell(Text('5')),
                      DataCell(
                        PopupMenuButton(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            onSelected: (value) {
                              // if (value == "delete") {
                              //   logcat("REPORT_ID",
                              //       uploadList.reportId);
                              //   controller.deleteUploadReport(
                              //       context,
                              //       uploadList.reportId,
                              //       controller
                              //           .customerId.value
                              //           .toString());
                              // } else if (value == "update") {
                              //   controller.addUpload(
                              //       context,
                              //       false,
                              //       uploadList.reportId,
                              //       prescriptionName:
                              //           uploadList.fullName,
                              //       reportType:
                              //           uploadList.reportType,
                              //       updateReportTypeId:
                              //           uploadList
                              //               .reportTypeID,
                              //       reportImage: uploadList
                              //           .reportImage,
                              //       prescriptionId: uploadList
                              //           .prescriptionId);
                              // } else {
                              //   // shareImage(
                              //   //   context,
                              //   //   uploadList.reportImage,
                              //   //   DateFormat(Date.dateFormat).format(
                              //   //       DateTime.parse(uploadList
                              //   //           .prescriptionDate
                              //   //           .toString())),
                              //   //   uploadList.doctorName,
                              //   //   uploadList.complaint,
                              //   //   uploadList.reportType,
                              //   // );
                              // }
                            },
                            itemBuilder: (BuildContext bc) {
                              return [
                                setPopupMenuItem('Edit', "Edit", Icons.add),
                                setPopupMenuItem(
                                    'delete', "Delete", Icons.delete),
                              ];
                            }),
                      ),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('2')),
                      DataCell(Text('Hair')),
                      DataCell(Text('Loreal Paris')),
                      DataCell(Text('Hair Serum')),
                      DataCell(Text('5')),
                      DataCell(
                        PopupMenuButton(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            onSelected: (value) {
                              // if (value == "delete") {
                              //   logcat("REPORT_ID",
                              //       uploadList.reportId);
                              //   controller.deleteUploadReport(
                              //       context,
                              //       uploadList.reportId,
                              //       controller
                              //           .customerId.value
                              //           .toString());
                              // } else if (value == "update") {
                              //   controller.addUpload(
                              //       context,
                              //       false,
                              //       uploadList.reportId,
                              //       prescriptionName:
                              //           uploadList.fullName,
                              //       reportType:
                              //           uploadList.reportType,
                              //       updateReportTypeId:
                              //           uploadList
                              //               .reportTypeID,
                              //       reportImage: uploadList
                              //           .reportImage,
                              //       prescriptionId: uploadList
                              //           .prescriptionId);
                              // } else {
                              //   // shareImage(
                              //   //   context,
                              //   //   uploadList.reportImage,
                              //   //   DateFormat(Date.dateFormat).format(
                              //   //       DateTime.parse(uploadList
                              //   //           .prescriptionDate
                              //   //           .toString())),
                              //   //   uploadList.doctorName,
                              //   //   uploadList.complaint,
                              //   //   uploadList.reportType,
                              //   // );
                              // }
                            },
                            itemBuilder: (BuildContext bc) {
                              return [
                                setPopupMenuItem('Edit', "Edit", Icons.add),
                                setPopupMenuItem(
                                    'delete', "Delete", Icons.delete),
                              ];
                            }),
                      ),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('3')),
                      DataCell(Text('Hair')),
                      DataCell(Text('Loreal Paris')),
                      DataCell(Text('Hair Serum')),
                      DataCell(Text('5')),
                      DataCell(
                        PopupMenuButton(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            onSelected: (value) {
                              // if (value == "delete") {
                              //   logcat("REPORT_ID",
                              //       uploadList.reportId);
                              //   controller.deleteUploadReport(
                              //       context,
                              //       uploadList.reportId,
                              //       controller
                              //           .customerId.value
                              //           .toString());
                              // } else if (value == "update") {
                              //   controller.addUpload(
                              //       context,
                              //       false,
                              //       uploadList.reportId,
                              //       prescriptionName:
                              //           uploadList.fullName,
                              //       reportType:
                              //           uploadList.reportType,
                              //       updateReportTypeId:
                              //           uploadList
                              //               .reportTypeID,
                              //       reportImage: uploadList
                              //           .reportImage,
                              //       prescriptionId: uploadList
                              //           .prescriptionId);
                              // } else {
                              //   // shareImage(
                              //   //   context,
                              //   //   uploadList.reportImage,
                              //   //   DateFormat(Date.dateFormat).format(
                              //   //       DateTime.parse(uploadList
                              //   //           .prescriptionDate
                              //   //           .toString())),
                              //   //   uploadList.doctorName,
                              //   //   uploadList.complaint,
                              //   //   uploadList.reportType,
                              //   // );
                              // }
                            },
                            itemBuilder: (BuildContext bc) {
                              return [
                                setPopupMenuItem('Edit', "Edit", Icons.add),
                                setPopupMenuItem(
                                    'delete', "Delete", Icons.delete),
                              ];
                            }),
                      ),
                    ]),
                    // Add more DataRow entries as needed
                  ],
                ),
              ),
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

  Future<Future> addProduct(
    context,
  ) async {
    // controller.addCityctr.text = "";
    // controller.stateController.text = "";
    // controller.addHospitalctr.text = "";
    // controller.addDoctorctr.text = "";
    // controller.cityctr.text = "";

    return showModalBottomSheet(
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
                                    hintLabel: "Product Category",
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
                                    hintLabel: "Brand",
                                    onChanged: (val) {
                                      // controller.validateState(val);
                                    },
                                    onTap: () {
                                      showDropDownDialog(context,
                                          controller.setBrand(), "Brand List");
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
                                    hintLabel: "Product Name",
                                    onChanged: (val) {
                                      // controller.validateState(val);
                                    },
                                    onTap: () {},
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
                                  hintLabel: 'Qty',
                                  onChanged: (value) {
                                    // Your onChanged logic for Text Field 2
                                  },
                                  onTap: () {
                                    // Your onTap logic for Text Field 2
                                  },
                                  inputType: TextInputType.number,
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: getReactiveFormField(
                                  node: controller.priceNode,
                                  controller: controller.pricectr,
                                  hintLabel: "Price",
                                  onChanged: (value) {},
                                  onTap: () {},
                                  inputType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                          Column(children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info,
                                  color: black,
                                  size: 3.h,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 1.w),
                                  child: Text(
                                    "Product is Out of Stock",
                                    style: TextStyle(
                                        fontFamily: fontRegular,
                                        fontSize: 13.5.sp),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ]),
                      ),
                      FadeInUp(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 2.h),
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 13.w,
                              alignment: Alignment.center,
                              width: SizerUtil.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.w),
                                color: black,
                                boxShadow: [
                                  BoxShadow(
                                      color: primaryColor.withOpacity(0.3),
                                      blurRadius: 10.0,
                                      offset: const Offset(0, 1),
                                      spreadRadius: 3.0)
                                ],
                              ),
                              child: Text(
                                textAlign: TextAlign.center,
                                "Submit",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: fontBold,
                                    fontSize: 14.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
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
  }
}
