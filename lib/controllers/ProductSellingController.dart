import 'dart:convert';
import 'dart:io';
import 'package:booking_app/Config/apicall_constant.dart';
import 'package:booking_app/Models/BrandCategoryModel.dart';
import 'package:booking_app/Models/CommonModel.dart';
import 'package:booking_app/Models/CustomerListModel.dart';
import 'package:booking_app/Models/ProductCatListModel.dart';
import 'package:booking_app/Models/ProductListModel.dart';
import 'package:booking_app/Models/ProductSellListModel.dart';
import 'package:booking_app/Models/sign_in_form_validation.dart';
import 'package:booking_app/api_handle/Repository.dart';
import 'package:booking_app/controllers/home_screen_controller.dart';
import 'package:booking_app/controllers/internet_controller.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:booking_app/dialogs/loading_indicator.dart';
import 'package:booking_app/preference/UserPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProductSellingController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  late FocusNode studentNode,
      courseNode,
      emailNode,
      notesNode,
      imageNode,
      orderNode,
      productCatNode,
      brandNode,
      productNameNode,
      productNode,
      qtyNode,
      priceNode,
      customerNode,
      feesNode;

  Rx<File?> avatarFile = null.obs;
  Rx<File?> videoFile = null.obs;
  RxString message = "".obs;
  Rx<ScreenState> state = ScreenState.apiLoading.obs;

  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  late TextEditingController studentctr,
      coursectr,
      emailctr,
      notesctr,
      imgctr,
      Feesctr,
      orderDatectr,
      productCatctr,
      brandctr,
      productNamectr,
      productctr,
      qtyctr,
      customerctr,
      pricectr;
  // endTimectr

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    studentNode = FocusNode();
    imageNode = FocusNode();
    courseNode = FocusNode();
    emailNode = FocusNode();
    notesNode = FocusNode();
    feesNode = FocusNode();
    orderNode = FocusNode();
    productCatNode = FocusNode();
    brandNode = FocusNode();
    productNameNode = FocusNode();
    customerNode = FocusNode();
    productNode = FocusNode();
    qtyNode = FocusNode();
    priceNode = FocusNode();

    studentctr = TextEditingController();
    imgctr = TextEditingController();
    coursectr = TextEditingController();
    emailctr = TextEditingController();
    notesctr = TextEditingController();
    Feesctr = TextEditingController();
    orderDatectr = TextEditingController();
    pricectr = TextEditingController();
    qtyctr = TextEditingController();
    productNamectr = TextEditingController();
    productctr = TextEditingController();
    brandctr = TextEditingController();
    productCatctr = TextEditingController();
    customerctr = TextEditingController();
    enableSignUpButton();
    super.onInit();
  }

  void updateDate(date) {
    orderDatectr.text = date;
    update();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var ProductModel = ValidationModel(null, null, isValidate: false).obs;
  var ProductSelectModel = ValidationModel(null, null, isValidate: false).obs;
  var OrderDateModel = ValidationModel(null, null, isValidate: false).obs;
  var ProductcatModel = ValidationModel(null, null, isValidate: false).obs;
  var BrandModel = ValidationModel(null, null, isValidate: false).obs;
  var NameModel = ValidationModel(null, null, isValidate: false).obs;
  var QtyModel = ValidationModel(null, null, isValidate: false).obs;
  var PriceModel = ValidationModel(null, null, isValidate: false).obs;
  var CustomerModel = ValidationModel(null, null, isValidate: false).obs;

  void clearFields(BuildContext context) {
    productCatctr.text = '';
    productCategoryId.value = '';
    brandctr.text = '';
    brandCategoryId.value = '';
    productNamectr.text = '';
    qtyctr.text = '';
    pricectr.text = '';
    productctr.text = '';
    ProductcatModel.value.isValidate = false;
    BrandModel.value.isValidate = false;
    ProductModel.value.isValidate = false;
    QtyModel.value.isValidate = false;
    PriceModel.value.isValidate = false;
    isFormInvalidate.value = false;
    hideKeyboard(context);
  }

  void enableSignUpButton() {
    if (OrderDateModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (CustomerModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (ProductcatModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (BrandModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (ProductModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (QtyModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else {
      isFormInvalidate.value = true;
    }
  }

  void validateCustomer(String? val) {
    CustomerModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Customer";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateProduct(String? val) {
    ProductModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Product";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateProductCategory(String? val) {
    ProductcatModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Product Category";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateBrand(String? val) {
    BrandModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Brand";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateName(String? val) {
    NameModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Product Name";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateQty(String? val) {
    QtyModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Quantity";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validatePrice(String? val) {
    PriceModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Product Price";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateProductDate(String? val) {
    OrderDateModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Date";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void productSellApi(context, List<Map<String, dynamic>> productList) async {
    var loadingIndicator = LoadingProgressDialog();
    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      loadingIndicator.show(context, '');
      var retrievedObject = await UserPreferences().getSignInInfo();

      logcat("RequestParam", {
        "date_of_sale": orderDatectr.text.toString().trim(),
        "customer_id": customerId.value.toString().trim(),
        "vendor_id": retrievedObject!.id.toString().trim(),
        "product_details": productList
      });

      var response = await Repository.post({
        "date_of_sale": orderDatectr.text.toString().trim(),
        "customer_id": customerId.value.toString().trim(),
        "vendor_id": retrievedObject.id.toString().trim(),
        "product_details": productList
      }, ApiUrl.addProductSale, allowHeader: true);

      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("RESPOSNE", data);
      if (response.statusCode == 200) {
        var responseDetail = CommonModel.fromJson(data);
        if (responseDetail.status == 1) {
          clearFields(context);
          showDialogForScreen(context, responseDetail.message.toString(),
              callback: () {
            Get.back(result: true);
          });
        } else {
          showDialogForScreen(context, responseDetail.message.toString(),
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, data['message'].toString(),
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context, Connection.servererror, callback: () {});
      loadingIndicator.hide(context);
    }
  }

  RxList productList = [].obs;
  void getProductSellApi(context) async {
    state.value = ScreenState.apiLoading;
    //try {
    if (networkManager.connectionType == 0) {
      showDialogForScreen(context, Connection.noConnection, callback: () {
        Get.back();
      });
      return;
    }
    var response = await Repository.post({
      "search": {
        // "startAt": "2023-06-06T00:00:00.704Z",
        // "endAt": "2023-06-06T00:00:00.704Z",
        // "customer_id": "647ec6b6dabca620c249cc04",
        //"vendor_id": "647ec6b6dabca620c249cc04",
        //"product_category_id": "647ec6b6dabca620c249cc04"
      }
    }, ApiUrl.getProductSale, allowHeader: true);

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (data['status'] == 1) {
        state.value = ScreenState.apiSuccess;
        var responseDetail = ProductSellListModel.fromJson(data);
        productList.clear();
        for (int i = 0; i < responseDetail.data.length; i++) {
          productList.addAll(responseDetail.data[i].productSaleInfo);
        }
        update();
        logcat("responseDetailsssss", jsonEncode(productList));
      } else {
        showDialogForScreen(context, data['message'].toString(),
            callback: () {});
      }
    } else {
      state.value = ScreenState.apiError;
      showDialogForScreen(context, data['message'].toString(), callback: () {});
    }
  }
  // catch (e) {
  //   logcat("Exception", e);
  //   showDialogForScreen(context, Connection.servererror, callback: () {});
  //   loadingIndicator.hide(context);
  // }
  //}

  RxBool isFormInvalidate = false.obs;
  RxString uploadImageId = ''.obs;
  RxString uploadBreacherId = ''.obs;

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  RxBool isProductTypeApiList = false.obs;
  RxList<ListofProduct> productObjectList = <ListofProduct>[].obs;
  RxString productId = "".obs;

  void getProductList(
      context, bool isFirst, String categoryId, String brandId) async {
    var loadingIndicator = LoadingProgressDialogs();

    isProductTypeApiList.value = true;
    try {
      if (networkManager.connectionType == 0) {
        if (isFirst == false) {
          loadingIndicator.hide(context);
        }
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.post({
        "search": {
          "product_category_id": categoryId,
          "brand_category_id": brandId
        }
      }, ApiUrl.productList, allowHeader: true);
      if (isFirst == false) {
        loadingIndicator.hide(context);
      }
      isProductTypeApiList.value = false;
      var responseData = jsonDecode(response.body);
      logcat(" PRODUCT RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = ProductListModel.fromJson(responseData);
        if (data.status == 1) {
          state.value = ScreenState.apiSuccess;
          productObjectList.clear();
          productObjectList.addAll(data.data);

          logcat("PRODUCT RESPONSE", jsonEncode(productObjectList));
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isProductTypeApiList.value = false;
    }
  }

  Widget setProductList() {
    return Obx(() {
      if (isProductTypeApiList.value == true)
        return setDropDownContent([].obs, Text("Loading"),
            isApiIsLoading: isProductTypeApiList.value);

      return setDropDownTestContent(
        productObjectList,
        ListView.builder(
          shrinkWrap: true,
          itemCount: productObjectList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              dense: true,
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
              horizontalTitleGap: null,
              minLeadingWidth: 5,
              onTap: () {
                Get.back();
                productId.value = productObjectList[index].id.toString();
                productNamectr.text =
                    productObjectList[index].name.capitalize.toString();
                pricectr.text = productObjectList[index].amount.toString();
                validateProduct(productNamectr.text);
              },
              title: Text(
                productObjectList[index].name.toString(),
                style: TextStyle(
                    fontFamily: fontRegular,
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 13.5.sp
                        : 11.sp,
                    color: isDarkMode() ? white : black),
              ),
            );
          },
        ),
      );
    });
  }

  RxBool isCustomerTypeApiList = false.obs;
  RxList<ListofCustomer> customerObjectList = <ListofCustomer>[].obs;
  RxString customerId = "".obs;

  void getCustomerList(context) async {
    isCustomerTypeApiList.value = true;
    try {
      if (networkManager.connectionType == 0) {
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response =
          await Repository.post({}, ApiUrl.customerList, allowHeader: true);
      isCustomerTypeApiList.value = false;
      var responseData = jsonDecode(response.body);
      logcat("CUSTOMER_RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = CustomerListModel.fromJson(responseData);
        if (data.status == 1) {
          state.value = ScreenState.apiSuccess;
          customerObjectList.clear();
          customerObjectList.addAll(data.data);
          logcat("CUSTOMER RESPONSE", jsonEncode(customerObjectList));
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
    }
  }

  Widget setCustomerList() {
    return Obx(() {
      if (isCustomerTypeApiList.value == true)
        return setDropDownContent([].obs, Text("Loading"),
            isApiIsLoading: isCustomerTypeApiList.value);

      return setDropDownTestContent(
        customerObjectList,
        ListView.builder(
          shrinkWrap: true,
          itemCount: customerObjectList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              dense: true,
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
              horizontalTitleGap: null,
              minLeadingWidth: 5,
              onTap: () {
                Get.back();
                logcat("ONTAP", "SACHIN");
                customerId.value = customerObjectList[index].id.toString();
                customerctr.text =
                    customerObjectList[index].name.capitalize.toString();
                validateCustomer(customerctr.text);
              },
              title: Text(
                customerObjectList[index].name.toString(),
                style: TextStyle(
                    fontFamily: fontRegular,
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 13.5.sp
                        : 11.sp,
                    color: isDarkMode() ? white : black),
              ),
            );
          },
        ),
      );
    });
  }

  RxBool isProductCategoryList = false.obs;
  RxList<ListProductCategory> productCategoryObjectList =
      <ListProductCategory>[].obs;
  RxString productCategoryId = "".obs;

  void getProductCategoryList(
    context,
  ) async {
    var loadingIndicator = LoadingProgressDialogs();
    //loadingIndicator.show(context, "");
    isProductCategoryList.value = true;
    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.post({}, ApiUrl.productCategoryList,
          allowHeader: true);
      //loadingIndicator.hide(context);
      isProductCategoryList.value = false;
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseData['status'] == 1) {
          var data = ProductCategoryListModel.fromJson(responseData);
          logcat("getProductCategoryList", 'DONE');
          brandctr.text = '';
          productNamectr.text = '';
          state.value = ScreenState.apiSuccess;
          productCategoryObjectList.clear();
          productCategoryObjectList.addAll(data.data);
          update();
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isProductCategoryList.value = false;
    }
  }

  Widget setProductCategoryList() {
    return Obx(() {
      if (isProductCategoryList.value == true)
        return setDropDownContent([].obs, Text("Loading"),
            isApiIsLoading: isProductCategoryList.value);
      return setDropDownTestContent(
        productCategoryObjectList,
        ListView.builder(
          shrinkWrap: true,
          itemCount: productCategoryObjectList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              dense: true,
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
              horizontalTitleGap: null,
              minLeadingWidth: 5,
              onTap: () {
                Get.back();
                productCategoryId.value =
                    productCategoryObjectList[index].id.toString();
                productCatctr.text =
                    productCategoryObjectList[index].name.capitalize.toString();
                getBrandCategoryList(
                    context, productCategoryId.value.toString());
                validateProductCategory(productCatctr.text);
              },
              title: Text(
                productCategoryObjectList[index].name.toString(),
                style: TextStyle(
                    fontFamily: fontRegular,
                    fontSize: 13.5.sp,
                    color: isDarkMode() ? white : black),
              ),
            );
          },
        ),
      );
    });
  }

  RxBool isBrandCategoryList = false.obs;
  RxList<BrandCatList> BrnadCategoryObjectList = <BrandCatList>[].obs;
  RxString brandCategoryId = "".obs;

  void getBrandCategoryList(context, String categoryId) async {
    var loadingIndicator = LoadingProgressDialogs();
    loadingIndicator.show(context, '');
    isBrandCategoryList.value = true;
    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.post({
        "search": {"product_category_id": categoryId},
      }, ApiUrl.brandCategoryList, allowHeader: true);
      loadingIndicator.hide(context);
      isBrandCategoryList.value = false;
      var responseData = jsonDecode(response.body);
      logcat("SERVICE_RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        if (responseData['status'] == 1) {
          var data = BrandCategoryModel.fromJson(responseData);
          state.value = ScreenState.apiSuccess;
          brandctr.text = '';
          productNamectr.text = '';
          BrnadCategoryObjectList.clear();
          BrnadCategoryObjectList.addAll(data.data);
          // getProductList(context, false, productCategoryId.value.toString(),
          //     brandCategoryId.value.toString());
          logcat("SERVICE RESPONSE", jsonEncode(BrnadCategoryObjectList));
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isBrandCategoryList.value = false;
    }
  }

  Widget setBrand() {
    return Obx(() {
      if (isBrandCategoryList.value == true)
        return setDropDownContent([].obs, Text("Loading"),
            isApiIsLoading: isBrandCategoryList.value);
      return setDropDownTestContent(
        BrnadCategoryObjectList,
        ListView.builder(
          shrinkWrap: true,
          itemCount: BrnadCategoryObjectList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              dense: true,
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
              horizontalTitleGap: null,
              minLeadingWidth: 5,
              onTap: () {
                Get.back();
                brandCategoryId.value =
                    BrnadCategoryObjectList[index].id.toString();
                brandctr.text =
                    BrnadCategoryObjectList[index].name.capitalize.toString();
                validateBrand(brandctr.text);
                getProductList(context, true, productCategoryId.value,
                    brandCategoryId.value);
              },
              title: Text(
                BrnadCategoryObjectList[index].name.toString(),
                style: TextStyle(
                    fontFamily: fontRegular,
                    fontSize: 13.5.sp,
                    color: isDarkMode() ? white : black),
              ),
            );
          },
        ),
      );
    });
  }

  Future<Object?> PopupDialogs(
      BuildContext context, String title, String subtext) {
    return showGeneralDialog(
        barrierColor: black.withOpacity(0.6),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: CupertinoAlertDialog(
                  title: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      color: isDarkMode() ? white : black,
                      fontFamily: fontBold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Text(
                    subtext,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDarkMode() ? white : black,
                      fontFamily: fontMedium,
                    ),
                  ),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      isDefaultAction: true,
                      isDestructiveAction: true,
                      child: Text("Continue",
                          style: TextStyle(
                            fontSize: 15,
                            color: isDarkMode() ? white : black,
                            fontFamily: fontBold,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    // The "No" button
                  ],
                )),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }

  showDialogForScreen(context, String message, {Function? callback}) {
    showMessage(
        context: context,
        callback: () {
          if (callback != null) {
            callback();
          }
          return true;
        },
        message: message,
        title: "Product Sale",
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }

}
