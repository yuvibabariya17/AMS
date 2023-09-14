import 'dart:convert';
import 'dart:io';
import 'package:booking_app/Models/CategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../Config/apicall_constant.dart';
import '../Models/sign_in_form_validation.dart';
import '../Screens/DashboardScreen.dart';
import '../api_handle/Repository.dart';
import '../core/constants/strings.dart';
import '../core/themes/font_constant.dart';
import '../core/utils/log.dart';
import '../dialogs/loading_indicator.dart';
import '../preference/UserPreference.dart';
import 'Appointment_screen_controller.dart';
import 'internet_controller.dart';
import 'package:http/http.dart' as http;
import 'package:booking_app/dialogs/dialogs.dart';

class addProductController extends GetxController {
  late final GetStorage _getStorage;
  final InternetController networkManager = Get.find<InternetController>();
  Rx<File?> avatarFile = null.obs;

  Rx<ScreenState> state = ScreenState.apiLoading.obs;

  late FocusNode NameNode,
      productimgNode,
      descriptionNode,
      categoryNode,
      amountNode,
      quantitynode;

  late TextEditingController NameCtr,
      productimgCtr,
      descriptionCtr,
      categroryCtr,
      amountCtr,
      quantityCtr;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    _getStorage = GetStorage();

    NameNode = FocusNode();
    productimgNode = FocusNode();
    descriptionNode = FocusNode();
    categoryNode = FocusNode();
    amountNode = FocusNode();
    quantitynode = FocusNode();

    NameCtr = TextEditingController();
    productimgCtr = TextEditingController();
    descriptionCtr = TextEditingController();
    categroryCtr = TextEditingController();
    amountCtr = TextEditingController();
    quantityCtr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var NameModel = ValidationModel(null, null, isValidate: false).obs;
  var productimgModel = ValidationModel(null, null, isValidate: false).obs;
  var descriptionModel = ValidationModel(null, null, isValidate: false).obs;
  var categroryModel = ValidationModel(null, null, isValidate: false).obs;
  var amountModel = ValidationModel(null, null, isValidate: false).obs;
  var quantityModel = ValidationModel(null, null, isValidate: false).obs;

  void validatename(String? val) {
    NameModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Name";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });
    enableSignUpButton();
  }

  void validateProductimg(String? val) {
    productimgModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Product";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateDescription(String? val) {
    descriptionModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Description";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateCategory(String? val) {
    categroryModel.update((model) {
      if (val == null || val.isEmpty) {
        model!.error = "Enter Category";
        model.isValidate = false;
      } else if (!GetUtils.isEmail(val)) {
        model!.error = "Enter Category";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });
    enableSignUpButton();
  }

  void validateAmount(String? val) {
    amountModel.update((model) {
      if (val == null || val.isEmpty) {
        model!.error = "Enter Amount";
        model.isValidate = false;
      } else if (val.replaceAll(' ', '').length < 10) {
        model!.error = "Enter Amount";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateQuantity(String? val) {
    quantityModel.update((model) {
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

  void enableSignUpButton() {
    if (NameModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (productimgModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (descriptionModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (categroryModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (amountModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else {
      isFormInvalidate.value = true;
    }
  }

  RxBool isFormInvalidate = false.obs;

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void addProductApi(context) async {
    var loadingIndicator = LoadingProgressDialog();
    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context,  Strings.noInternetConnection, callback: () {
          Get.back();
        });
        return;
      }
      loadingIndicator.show(context, '');
      var retrievedObject = await UserPreferences().getSignInInfo();

      var response = await Repository.multiPartPost({
        "name": NameCtr.text.toString().trim(),
        "product_category_id": categoryId.value,
        "description": descriptionCtr.text.toString().trim(),
        "amount": amountCtr.toString().trim(),
        "qty": quantityCtr.text.toString().trim(),
      }, ApiUrl.addProduct,
          multiPart: avatarFile.value != null
              ? http.MultipartFile(
                  'image_id',
                  avatarFile.value!.readAsBytes().asStream(),
                  avatarFile.value!.lengthSync(),
                  filename: avatarFile.value!.path.split('/').last,
                )
              : null,
          allowHeader: true);
      var responseData = await response.stream.toBytes();
      loadingIndicator.hide(context);

      var result = String.fromCharCodes(responseData);
      var json = jsonDecode(result);

      if (response.statusCode == 200) {
        if (json['status'] == 1) {
          Get.to(const dashboard());
        } else {
          showDialogForScreen(context, json['message'].toString(),
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, json['message'].toString(),
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context,  Strings.servererror,
          callback: () {});
      loadingIndicator.hide(context);
    }
  }

  Widget setCategoryList() {
    return Obx(() {
      if (isCategoryTypeApiCall.value == true)
        return setDropDownContent([].obs, Text("Loading"),
            isApiIsLoading: isCategoryTypeApiCall.value);

      return setDropDownTestContent(
        categoryObjectList,
        ListView.builder(
          shrinkWrap: true,
          itemCount: categoryObjectList.length,
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
                categoryId.value = categoryObjectList[index].name.toString();
                categroryCtr.text =
                    categoryObjectList[index].name.capitalize.toString();

                validateCategory(categroryCtr.text);
              },
              title: Text(
                categoryObjectList[index].name.capitalize.toString(),
                style: TextStyle(fontFamily: fontRegular, fontSize: 13.5.sp),
              ),
            );
          },
        ),
      );
    });
  }

  RxBool isCategoryTypeApiCall = false.obs;
  RxList<ProductCategoryList> categoryObjectList = <ProductCategoryList>[].obs;
  RxString categoryId = "".obs;

  void getProductCategory(context) async {
    isCategoryTypeApiCall.value = true;
    try {
      if (networkManager.connectionType == 0) {
        showDialogForScreen(context, Strings.noInternetConnection,
            callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.post({}, ApiUrl.productCategoryList,
          allowHeader: true);
      isCategoryTypeApiCall.value = false;
      var responseData = jsonDecode(response.body);
      logcat("RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = CategoryModel.fromJson(responseData);
        if (data.status == 1) {
          categoryObjectList.clear();
          categoryObjectList.addAll(data.data);
          logcat("RESPONSE", jsonEncode(categoryObjectList));
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Strings.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isCategoryTypeApiCall.value = false;
    }
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
        title: "Add Customer",
        negativeButton: '',
        positiveButton: "Continue");
  }

  Rx<File?> uploadReportFile = null.obs;

  actionClickUploadImage(context) async {
    await ImagePicker()
        .pickImage(
            source: ImageSource.gallery,
            maxWidth: 1080,
            maxHeight: 1080,
            imageQuality: 100)
        .then((file) async {
      if (file != null) {
        if (file != null) {
          uploadReportFile = File(file.path).obs;
          productimgCtr.text = file.name;
          validateProductimg(productimgCtr.text);
        }
      }
    });

    update();
  }

  void navigate() {
    // Get.to(const SignUpScreen(false));
  }
}
