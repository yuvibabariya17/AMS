import 'dart:convert';
import 'dart:io';
import 'package:booking_app/Config/apicall_constant.dart';
import 'package:booking_app/Models/BrandCategoryModel.dart';
import 'package:booking_app/Models/CommonModel.dart';
import 'package:booking_app/Models/CustomerListModel.dart';
import 'package:booking_app/Models/ProductCatListModel.dart';
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
      qtyNode,
      priceNode,
      customerNode,
      feesNode;

  Rx<File?> avatarFile = null.obs;
  Rx<File?> videoFile = null.obs;
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
    brandctr = TextEditingController();
    productCatctr = TextEditingController();
    customerctr = TextEditingController();

    // endTimectr = TextEditingController();

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
  var OrderDateModel = ValidationModel(null, null, isValidate: false).obs;
  var ProductcatModel = ValidationModel(null, null, isValidate: false).obs;
  var BrandModel = ValidationModel(null, null, isValidate: false).obs;
  var NameModel = ValidationModel(null, null, isValidate: false).obs;
  var QtyModel = ValidationModel(null, null, isValidate: false).obs;
  var PriceModel = ValidationModel(null, null, isValidate: false).obs;
  var CustomerModel = ValidationModel(null, null, isValidate: false).obs;

  void enableSignUpButton() {
    if (OrderDateModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (CustomerModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (ProductModel.value.isValidate == false) {
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
    ProductModel.update((model) {
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
    ProductModel.update((model) {
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
    ProductModel.update((model) {
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
    ProductModel.update((model) {
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
    ProductModel.update((model) {
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

  void productSellApi(context) async {
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
      logcat("Passing_data::", {
        "date_of_sale": orderDatectr.value.toString(),
        "vendor_id": retrievedObject!.id.toString().trim(),
        "product_category_id": productCategoryId.value.toString()
      });

      var response = await Repository.post({
        "date_of_sale": orderDatectr.value.toString(),
        "vendor_id": retrievedObject!.id.toString().trim(),
        "product_category_id": productCategoryId.value.toString()
      }, ApiUrl.addProductSale, allowHeader: true);

      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("RESPOSNE", data);
      if (response.statusCode == 200) {
        var responseDetail = CommonModel.fromJson(data);
        if (responseDetail.status == 1) {
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

  void sellingDetails(context) async {
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
      //   var retrievedObject = await UserPreferences().getSignInInfo();
      logcat("Passing_data::", {
        "product_sale_id": "6501b02a3c7d91c34dbaca17",
        "product_id": "64991ce8f9f9493f9fa96c38",
        "qty": 2
      });

      var response = await Repository.post({
        "product_sale_id": "6501b02a3c7d91c34dbaca17",
        "product_id": "64991ce8f9f9493f9fa96c38",
        "qty": 2
      }, ApiUrl.addproductSaleDetails, allowHeader: true);

      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("RESPOSNE", data);
      if (response.statusCode == 200) {
        var responseDetail = CommonModel.fromJson(data);
        if (responseDetail.status == 1) {
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

  RxBool isFormInvalidate = false.obs;
  RxString uploadImageId = ''.obs;
  RxString uploadBreacherId = ''.obs;

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  RxBool isCustomerTypeApiList = false.obs;
  RxList<ListofCustomer> customerObjectList = <ListofCustomer>[].obs;
  RxString customerId = "".obs;

  void getCustomerList(context) async {
    state.value = ScreenState.apiLoading;
    isCustomerTypeApiList.value = true;
    // try {
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
    logcat(" CUSTOMER RESPONSE", jsonEncode(responseData));

    if (response.statusCode == 200) {
      var data = CustomerListModel.fromJson(responseData);
      if (data.status == 1) {
        state.value = ScreenState.apiSuccess;
        customerObjectList.clear();
        customerObjectList.addAll(data.data);
        logcat("CUSTOMER RESPONSE", jsonEncode(customerObjectList));
      } else {
        showDialogForScreen(context, responseData['message'], callback: () {});
      }
    } else {
      showDialogForScreen(context, Connection.servererror, callback: () {});
    }
    // } catch (e) {
    //   logcat('Exception', e);
    //   isCourseTypeApiList.value = false;
    // }
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
              },
              title: Text(
                customerObjectList[index].name.toString(),
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

  RxBool isProductCategoryList = false.obs;
  RxList<ListProductCategory> productCategoryObjectList =
      <ListProductCategory>[].obs;
  RxString productCategoryId = "".obs;

  void getProductCategoryList(context, bool isFirst) async {
    var loadingIndicator = LoadingProgressDialogs();
    if (isFirst == true) {
      state.value = ScreenState.apiLoading;
    } else {
      loadingIndicator.show(context, "");
    }

    isProductCategoryList.value = true;
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
      var response = await Repository.post({}, ApiUrl.productCategoryList,
          allowHeader: true);
      if (isFirst == false) {
        loadingIndicator.hide(context);
      }
      isProductCategoryList.value = false;
      var responseData = jsonDecode(response.body);
      logcat(" SERVICE RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        if (responseData['status'] == 1) {
          var data = ProductCategoryListModel.fromJson(responseData);

          state.value = ScreenState.apiSuccess;
          productCategoryObjectList.clear();
          productCategoryObjectList.addAll(data.data);
          logcat("SERVICE RESPONSE", jsonEncode(productCategoryObjectList));
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
                logcat("ONTAP", "SACHIN");
                productCategoryId.value =
                    productCategoryObjectList[index].id.toString();
                productCatctr.text =
                    productCategoryObjectList[index].name.capitalize.toString();
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

  void getBrandCategoryList(context, bool isFirst) async {
    var loadingIndicator = LoadingProgressDialogs();
    if (isFirst == true) {
      state.value = ScreenState.apiLoading;
    } else {
      loadingIndicator.show(context, '');
    }

    isBrandCategoryList.value = true;
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
      var response = await Repository.post({}, ApiUrl.brandCategoryList,
          allowHeader: true);
      if (isFirst == false) {
        loadingIndicator.hide(context);
      }
      isBrandCategoryList.value = false;
      var responseData = jsonDecode(response.body);
      logcat(" SERVICE RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        if (responseData['status'] == 1) {
          var data = BrandCategoryModel.fromJson(responseData);

          state.value = ScreenState.apiSuccess;
          BrnadCategoryObjectList.clear();
          BrnadCategoryObjectList.addAll(data.data);
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
                logcat("ONTAP", "SACHIN");
                brandCategoryId.value =
                    BrnadCategoryObjectList[index].id.toString();
                brandctr.text =
                    BrnadCategoryObjectList[index].name.capitalize.toString();
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
        title: ScreenTitle.reportBug,
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }
}
