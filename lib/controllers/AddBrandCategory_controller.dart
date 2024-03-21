import 'dart:convert';
import 'dart:io';
import 'package:booking_app/Config/apicall_constant.dart';
import 'package:booking_app/Models/CommonModel.dart';
import 'package:booking_app/Models/UploadImageModel.dart';
import 'package:booking_app/Models/sign_in_form_validation.dart';
import 'package:booking_app/api_handle/Repository.dart';
import 'package:booking_app/controllers/home_screen_controller.dart';
import 'package:booking_app/controllers/internet_controller.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:booking_app/dialogs/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddBrandCategoryController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  late FocusNode nameNode, descNode, emailNode, contactNode, imageNode, idNode;

  Rx<File?> avatarFile = null.obs;
  Rx<File?> videoFile = null.obs;
  Rx<ScreenState> state = ScreenState.apiLoading.obs;

  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  late TextEditingController namectr, descCtr, imgctr;

  // startTimectr,
  // endTimectr

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    nameNode = FocusNode();
    imageNode = FocusNode();
    descNode = FocusNode();

    namectr = TextEditingController();
    imgctr = TextEditingController();
    descCtr = TextEditingController();

    // startTimectr = TextEditingController();
    // endTimectr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var NameModel = ValidationModel(null, null, isValidate: false).obs;
  var ImageModel = ValidationModel(null, null, isValidate: false).obs;
  var DescriptionModel = ValidationModel(null, null, isValidate: false).obs;
  var EmailModel = ValidationModel(null, null, isValidate: false).obs;
  var ContactModel = ValidationModel(null, null, isValidate: false).obs;
  var IdModel = ValidationModel(null, null, isValidate: false).obs;

  void enableSignUpButton() {
    if (NameModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (ImageModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (DescriptionModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else {
      isFormInvalidate.value = true;
    }
  }

  void validateName(String? val) {
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

  void validateImage(String? val) {
    ImageModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Image";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateDescription(String? val) {
    DescriptionModel.update((model) {
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

  RxBool isFormInvalidate = false.obs;
  RxString uploadImageId = ''.obs;
  RxString uploadBreacherId = ''.obs;

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  showDialogForScreen(context, String message, bool? isEdit,
      {Function? callback}) {
    showMessage(
        context: context,
        callback: () {
          if (callback != null) {
            callback();
          }
          return true;
        },
        message: message,
        title: isEdit == true
            ? ScreenTitle.updateBrandCategory
            : ScreenTitle.addBrandCategory,
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }

  void AddBrandCategory(context) async {
    var loadingIndicator = LoadingProgressDialog();
    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Connection.noConnection, false,
            callback: () {
          Get.back();
        });
        return;
      }
      logcat("PRODUCTTTTTT", {});
      loadingIndicator.show(context, '');
      var response = await Repository.post({
        "name": namectr.text.toString().trim(),
        "image_id": uploadImageId.value.toString(),
        "description": descCtr.text.toLowerCase().trim(),
      }, ApiUrl.addBrandCategory, allowHeader: true);
      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("RESPOSNE", data);
      if (response.statusCode == 200) {
        var responseDetail = CommonModel.fromJson(data);
        if (responseDetail.status == 1) {
          showDialogForScreen(context, responseDetail.message.toString(), false,
              callback: () {
            Get.back(result: true);
          });
        } else {
          showDialogForScreen(context, responseDetail.message.toString(), false,
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, data['message'].toString(), false,
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context, Connection.servererror, false,
          callback: () {});
      loadingIndicator.hide(context);
    }
  }

  void UpdateBrandCategory(context, String brandCategoryId) async {
    var loadingIndicator = LoadingProgressDialog();
    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Connection.noConnection, true,
            callback: () {
          Get.back();
        });
        return;
      }
      logcat("PRODUCTTTTTT", {});
      loadingIndicator.show(context, '');
      var response = await Repository.put({
        "name": namectr.text.toString().trim(),
        "image_id": uploadImageId.value.toString(),
        "description": descCtr.text.toLowerCase().trim(),
      }, '${ApiUrl.editBrandCategory}/$brandCategoryId', allowHeader: true);
      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("RESPOSNE", data);
      if (response.statusCode == 200) {
        var responseDetail = CommonModel.fromJson(data);
        if (responseDetail.status == 1) {
          showDialogForScreen(context, responseDetail.message.toString(), true,
              callback: () {
            Get.back(result: true);
          });
        } else {
          showDialogForScreen(context, responseDetail.message.toString(), true,
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, data['message'].toString(), true,
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context, Connection.servererror, true,
          callback: () {});
      loadingIndicator.hide(context);
    }
  }

  Rx<File?> uploadProfile = null.obs;
  RxString uploadProfileId = ''.obs;

  void getIdProof(context) async {
    var loadingIndicator = LoadingProgressDialog();
    loadingIndicator.show(context, '');

    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Connection.noConnection, false,
            callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.multiPartPost({
        "file": uploadProfile.value!.path.split('/').last,
      }, ApiUrl.uploadImage,
          multiPart: uploadProfile.value != null
              ? http.MultipartFile(
                  'file',
                  uploadProfile.value!.readAsBytes().asStream(),
                  uploadProfile.value!.lengthSync(),
                  filename: uploadProfile.value!.path.split('/').last,
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
          uploadProfileId.value = responseData.data.id.toString();
        } else {
          showDialogForScreen(context, responseData.message.toString(), false,
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, responseData.message.toString(), false,
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context, Connection.servererror, false,
          callback: () {});
      loadingIndicator.hide(context);
    }
  }

  void getImage(context) async {
    var loadingIndicator = LoadingProgressDialog();
    loadingIndicator.show(context, '');

    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Connection.noConnection, false,
            callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.multiPartPost({
        "file": uploadReportFile.value!.path.split('/').last,
      }, ApiUrl.uploadImage,
          multiPart: uploadReportFile.value != null
              ? http.MultipartFile(
                  'file',
                  uploadReportFile.value!.readAsBytes().asStream(),
                  uploadReportFile.value!.lengthSync(),
                  filename: uploadReportFile.value!.path.split('/').last,
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
          showDialogForScreen(context, responseData.message.toString(), false,
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, responseData.message.toString(), false,
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context, Connection.servererror, false,
          callback: () {});
      loadingIndicator.hide(context);
    }
  }

  actionClickUploadImage(context, {bool? isCamera}) async {
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
        CroppedFile? croppedFile = await ImageCropper().cropImage(
            sourcePath: file.path,
            maxWidth: 1080,
            maxHeight: 1080,
            cropStyle: CropStyle.rectangle,
            aspectRatioPresets: Platform.isAndroid
                ? [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
                  ]
                : [
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio5x3,
                    CropAspectRatioPreset.ratio5x4,
                    CropAspectRatioPreset.ratio7x5,
                    CropAspectRatioPreset.ratio16x9
                  ],
            uiSettings: [
              AndroidUiSettings(
                  toolbarTitle: 'Crop Image',
                  cropGridColor: primaryColor,
                  toolbarColor: primaryColor,
                  statusBarColor: primaryColor,
                  toolbarWidgetColor: white,
                  activeControlsWidgetColor: primaryColor,
                  initAspectRatio: CropAspectRatioPreset.original,
                  lockAspectRatio: false),
              IOSUiSettings(
                title: 'Crop Image',
                cancelButtonTitle: 'Cancel',
                doneButtonTitle: 'Done',
                aspectRatioLockEnabled: false,
              ),
            ],
            aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
        if (file != null) {
          uploadReportFile = File(file.path).obs;
          imgctr.text = file.name;
          validateImage(imgctr.text);
          getImage(context);
        }

        // if (croppedFile != null) {
        //   uploadImageFile = File(croppedFile.path).obs;
        //   profilePic.value = croppedFile.path;
        //   update();
        // }
      }
    });

    update();
  }

  Rx<File?> uploadReportFile = null.obs;
  Rx<File?> uploadVideoFile = null.obs;
}
