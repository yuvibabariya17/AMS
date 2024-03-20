import 'dart:convert';
import 'dart:io';
import 'package:booking_app/Models/ProductCatListModel.dart';
import 'package:booking_app/Models/UploadImageModel.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../Config/apicall_constant.dart';
import '../Models/sign_in_form_validation.dart';
import '../api_handle/Repository.dart';
import '../core/constants/strings.dart';
import '../core/themes/font_constant.dart';
import '../core/utils/log.dart';
import '../dialogs/loading_indicator.dart';
import 'Appointment_screen_controller.dart';
import 'internet_controller.dart';
import 'package:http/http.dart' as http;
import 'package:booking_app/dialogs/dialogs.dart';

class addProductController extends GetxController {
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
    } else if (quantityModel.value.isValidate == false) {
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
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      logcat("PRODUCTTTTTT", {
        "name": NameCtr.text.toString().trim(),
        "description": descriptionCtr.text.toString().trim(),
        "image_id": uploadImageId.value.toString(),
        "product_category_id": productCategoryId.value.toString(),
        "amount": int.parse(amountCtr.text),
        "qty": int.parse(quantityCtr.text),
      });
      loadingIndicator.show(context, '');
      var response = await Repository.post({
        "name": NameCtr.text.toString().trim(),
        "description": descriptionCtr.text.toString().trim(),
        "image_id": uploadImageId.value.toString(),
        "product_category_id": productCategoryId.value.toString(),
        "amount": int.parse(amountCtr.text),
        "qty": int.parse(quantityCtr.text),
      }, ApiUrl.addProduct, allowHeader: true);
      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("RESPOSNE", data);
      if (response.statusCode == 200) {
        if (data['status'] == 1) {
          showDialogForScreen(context, data['message'].toString(),
              callback: () {
            Get.back(result: true);
          });
        } else {
          showDialogForScreen(context, data['message'].toString(),
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

  void UpdateProduct(context, String productId, String id) async {
    var loadingIndicator = LoadingProgressDialog();
    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      logcat("UPDATE_PRODUCTTTTTT", {
        "name": NameCtr.text.toString().trim(),
        "description": descriptionCtr.text.toString().trim(),
        "image_id": uploadImageId.value.toString(),
        "product_category_id": productCategoryId.value.toString().trim(),
        "amount": int.parse(amountCtr.text),
        "qty": int.parse(quantityCtr.text),
      });
      loadingIndicator.show(context, '');
      var response = await Repository.put({
        "name": NameCtr.text.toString().trim(),
        "description": descriptionCtr.text.toString().trim(),
        "image_id": uploadImageId.value.toString(),
        "product_category_id": productCategoryId.value.toString().trim(),
        "amount": int.parse(amountCtr.text),
        "qty": int.parse(quantityCtr.text),
      }, '${ApiUrl.editProduct}/$id', allowHeader: true);
      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("RESPOSNE", data);
      if (response.statusCode == 200) {
        if (data['status'] == 1) {
          showDialogForScreen(context, data['message'].toString(),
              callback: () {
            Get.back(result: true);
          });
        } else {
          showDialogForScreen(context, data['message'].toString(),
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

  RxBool isProductCategoryList = false.obs;
  RxList<ListProductCategory> productCategoryObjectList =
      <ListProductCategory>[].obs;
  RxString productCategoryId = "".obs;

  void getProductCategoryList(context) async {
    state.value = ScreenState.apiLoading;
    isProductCategoryList.value = true;
    // try {
    if (networkManager.connectionType == 0) {
      showDialogForScreen(context, Connection.noConnection, callback: () {
        Get.back();
      });
      return;
    }
    var response = await Repository.post({}, ApiUrl.productCategoryList,
        allowHeader: true);
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
        showDialogForScreen(context, responseData['message'], callback: () {});
      }
    } else {
      showDialogForScreen(context, Connection.servererror, callback: () {});
    }
    // } catch (e) {
    //   logcat('Exception', e);
    //   isServiceTypeApiList.value = false;
    // }
  }

  Widget setCategoryList() {
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
              visualDensity: VisualDensity(
                  horizontal: 0,
                  vertical:
                      SizerUtil.deviceType == DeviceType.mobile ? -4 : -1),
              contentPadding: EdgeInsets.all(0),
              horizontalTitleGap: null,
              minLeadingWidth: 5,
              onTap: () {
                Get.back();
                productCategoryId.value =
                    productCategoryObjectList[index].id.toString();
                categroryCtr.text =
                    productCategoryObjectList[index].name.capitalize.toString();

                validateCategory(categroryCtr.text);
              },
              title: Text(
                productCategoryObjectList[index].name.toString(),
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

  RxString uploadImageId = ''.obs;

  void getImageApi(context) async {
    var loadingIndicator = LoadingProgressDialog();
    loadingIndicator.show(context, '');

    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.multiPartPost({
        "file": uploadImageFile.value!.path.split('/').last,
      }, ApiUrl.uploadImage,
          multiPart: uploadImageFile.value != null
              ? http.MultipartFile(
                  'file',
                  uploadImageFile.value!.readAsBytes().asStream(),
                  uploadImageFile.value!.lengthSync(),
                  filename: uploadImageFile.value!.path.split('/').last,
                )
              : null,
          allowHeader: true);
      var responseDetail = await response.stream.toBytes();
      loadingIndicator.hide(context);

      var result = String.fromCharCodes(responseDetail);
      var json = jsonDecode(result);
      var responseData = UploadImageModel.fromJson(json);
      if (response.statusCode == 200) {
        logcat("responseData", jsonEncode(responseData));
        if (responseData.status == "True") {
          logcat("UPLOAD_IMAGE_ID", responseData.data.id.toString());
          uploadImageId.value = responseData.data.id.toString();
        } else {
          showDialogForScreen(context, responseData.message.toString(),
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, responseData.message.toString(),
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context, Connection.servererror, callback: () {});
      loadingIndicator.hide(context);
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
        title:    ScreenTitle.addProduct,
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }

  Rx<File?> uploadImageFile = null.obs;

  actionClickUploadImage(context) async {
    await ImagePicker()
        .pickImage(
            source: ImageSource.gallery,
            maxWidth: 1080,
            maxHeight: 1080,
            imageQuality: 100)
        .then((file) async {
      if (file != null) {
        uploadImageFile = File(file.path).obs;
        productimgCtr.text = file.name;
        validateProductimg(productimgCtr.text);
        getImageApi(context);
      }
    });

    update();
  }

  actionClickUploadImageFromCamera(context, {bool? isCamera}) async {
    await ImagePicker()
        .pickImage(
            //source: ImageSource.gallery,
            source: isCamera == true ? ImageSource.camera : ImageSource.gallery,
            maxWidth: 1080,
            maxHeight: 1080,
            imageQuality: 100)
        .then((file) async {
      if (file != null) {
        //Cropping the image
        // CroppedFile? croppedFile = await ImageCropper().cropImage(
        //     sourcePath: file.path,
        //     maxWidth: 1080,
        //     maxHeight: 1080,
        //     cropStyle: CropStyle.rectangle,
        //     aspectRatioPresets: Platform.isAndroid
        //         ? [
        //             CropAspectRatioPreset.square,
        //             CropAspectRatioPreset.ratio3x2,
        //             CropAspectRatioPreset.original,
        //             CropAspectRatioPreset.ratio4x3,
        //             CropAspectRatioPreset.ratio16x9
        //           ]
        //         : [
        //             CropAspectRatioPreset.original,
        //             CropAspectRatioPreset.square,
        //             CropAspectRatioPreset.ratio3x2,
        //             CropAspectRatioPreset.ratio4x3,
        //             CropAspectRatioPreset.ratio5x3,
        //             CropAspectRatioPreset.ratio5x4,
        //             CropAspectRatioPreset.ratio7x5,
        //             CropAspectRatioPreset.ratio16x9
        //           ],
        //     uiSettings: [
        //       AndroidUiSettings(
        //           toolbarTitle: 'Crop Image',
        //           cropGridColor: primaryColor,
        //           toolbarColor: primaryColor,
        //           statusBarColor: primaryColor,
        //           toolbarWidgetColor: white,
        //           activeControlsWidgetColor: primaryColor,
        //           initAspectRatio: CropAspectRatioPreset.original,
        //           lockAspectRatio: false),
        //       IOSUiSettings(
        //         title: 'Crop Image',
        //         cancelButtonTitle: 'Cancel',
        //         doneButtonTitle: 'Done',
        //         aspectRatioLockEnabled: false,
        //       ),
        //     ],
        //     aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
        uploadImageFile = File(file.path).obs;
        productimgCtr.text = file.name;
        validateProductimg(productimgCtr.text);
        getImageApi(context);

        // if (croppedFile != null) {
        //   uploadImageFile = File(croppedFile.path).obs;
        //   profilePic.value = croppedFile.path;
        //   update();
        // }
      }
    });

    update();
  }
}
