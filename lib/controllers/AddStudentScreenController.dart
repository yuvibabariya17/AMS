import 'dart:convert';
import 'dart:io';
import 'package:booking_app/Config/apicall_constant.dart';
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

class AddStudentController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  late FocusNode nameNode,
      addressNode,
      emailNode,
      contactNode,
      imageNode,
      idNode;

  Rx<File?> avatarFile = null.obs;
  Rx<File?> videoFile = null.obs;
  Rx<ScreenState> state = ScreenState.apiLoading.obs;

  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  late TextEditingController namectr,
      addressctr,
      emailctr,
      contactctr,
      imgctr,
      idctr;
  // startTimectr,
  // endTimectr

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    nameNode = FocusNode();
    imageNode = FocusNode();
    addressNode = FocusNode();
    emailNode = FocusNode();
    contactNode = FocusNode();
    idNode = FocusNode();

    namectr = TextEditingController();
    imgctr = TextEditingController();
    addressctr = TextEditingController();
    emailctr = TextEditingController();
    contactctr = TextEditingController();
    idctr = TextEditingController();

    // startTimectr = TextEditingController();
    // endTimectr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var NameModel = ValidationModel(null, null, isValidate: false).obs;
  var ImageModel = ValidationModel(null, null, isValidate: false).obs;
  var AddressModel = ValidationModel(null, null, isValidate: false).obs;
  var EmailModel = ValidationModel(null, null, isValidate: false).obs;
  var ContactModel = ValidationModel(null, null, isValidate: false).obs;
  var IdModel = ValidationModel(null, null, isValidate: false).obs;

  void enableSignUpButton() {
    if (NameModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (ImageModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (AddressModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (EmailModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (ContactModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (IdModel.value.isValidate == false) {
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

  void validateAddress(String? val) {
    AddressModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Address";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateEmail(String? val) {
    EmailModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Email";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateId(String? val) {
    IdModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Id";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateContact(String? val) {
    ContactModel.update((model) {
      if (val == null || val.isEmpty) {
        model!.error = "Enter Contact No.1";
        model.isValidate = false;
      } else if (val.toString().trim()!.replaceAll(' ', '').length != 10) {
        model!.error = "Enter Valid Contact No";
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
  RxString uploadIdproof = ''.obs;

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
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
        title: "Student",
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }

  void AddStudent(context) async {
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
      //  var retrievedObject = await UserPreferences().getSignInInfo();

      logcat("ADDCOURSE", {
        ({
          "name": namectr.text.toString().trim(),
          "address": addressctr.text.toString().trim(),
          "email": emailctr.text.toString().trim(),
          "contact": contactctr.text.toString().trim(),
          "photo_url": uploadImageId.value.toString(),
          "id_proof_url": uploadIdproof.value.toString(),
        })
      });

      var response = await Repository.post({
        "name": namectr.text.toString().trim(),
        "address": addressctr.text.toString().trim(),
        "email": emailctr.text.toString().trim(),
        "contact": contactctr.text.toString().trim(),
        "photo_url": uploadImageId.value.toString(),
        "id_proof_url": uploadIdproof.value.toString(),
      }, ApiUrl.addStudent, allowHeader: true);
      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("ADDCOURSE", data);
      // var responseDetail = GetLoginModel.fromJson(data);
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

  Rx<File?> uploadImageFile = null.obs;
  Rx<File?> uploadIdProof = null.obs;

  actionClickUploadImage(context, {bool? isCamera}) async {
    await ImagePicker()
        .pickImage(
            source: isCamera == true ? ImageSource.camera : ImageSource.gallery,
            maxWidth: 1080,
            maxHeight: 1080,
            imageQuality: 100)
        .then((file) async {
      if (file != null) {
        if (file != null) {
          uploadImageFile = File(file.path).obs;
          imgctr.text = file.name;
          validateImage(imgctr.text);
          getImageApi(context);
        }
      }
    });

    update();
  }

  actionClickUploadIdProof(context, {bool? isCamera}) async {
    await ImagePicker()
        .pickImage(
            source: isCamera == true ? ImageSource.camera : ImageSource.gallery,
            maxWidth: 1080,
            maxHeight: 1080,
            imageQuality: 100)
        .then((file) async {
      if (file != null) {
        if (file != null) {
          uploadIdProof = File(file.path).obs;
          idctr.text = file.name;
          validateId(idctr.text);
          getIdproofApi(context);
        }
      }
    });

    update();
  }

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

  void getIdproofApi(context) async {
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
        "file": uploadIdProof.value!.path.split('/').last,
      }, ApiUrl.uploadImage,
          multiPart: uploadIdProof.value != null
              ? http.MultipartFile(
                  'file',
                  uploadIdProof.value!.readAsBytes().asStream(),
                  uploadIdProof.value!.lengthSync(),
                  filename: uploadIdProof.value!.path.split('/').last,
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
          uploadIdproof.value = responseData.data.id.toString();
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
}
