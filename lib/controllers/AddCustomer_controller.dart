import 'dart:convert';
import 'dart:io';
import 'package:booking_app/core/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../Config/apicall_constant.dart';

import '../Models/UploadImageModel.dart';
import '../Models/sign_in_form_validation.dart';

import '../api_handle/Repository.dart';
import '../core/utils/log.dart';
import '../dialogs/dialogs.dart';
import '../dialogs/loading_indicator.dart';
import '../preference/UserPreference.dart';
import 'Appointment_screen_controller.dart';
import 'internet_controller.dart';
import 'package:http/http.dart' as http;

class AddCustomerController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();
  final formKey = GlobalKey<FormState>();
  Rx<ScreenState> state = ScreenState.apiLoading.obs;
  DateTime selectedDate = DateTime.now();
  DateTime selectedAnniversaryDate = DateTime.now();
  Rx<File?> avatarFile = null.obs;

  late FocusNode CustomerNode,
      ProfileNode,
      DobNode,
      DoaNode,
      AddressNode,
      Contact1Node,
      Contact2Node,
      WhatsappNode,
      EmailNode;

  late TextEditingController Customerctr,
      Profilectr,
      Dobctr,
      Doactr,
      Addressctr,
      Contact1ctr,
      Contact2ctr,
      Whatsappctr,
      Emailctr;

  @override
  void onInit() {
    CustomerNode = FocusNode();
    ProfileNode = FocusNode();
    DobNode = FocusNode();
    DoaNode = FocusNode();
    AddressNode = FocusNode();
    Contact1Node = FocusNode();
    Contact2Node = FocusNode();
    WhatsappNode = FocusNode();
    EmailNode = FocusNode();

    Customerctr = TextEditingController();
    Profilectr = TextEditingController();
    Dobctr = TextEditingController();
    Doactr = TextEditingController();
    Addressctr = TextEditingController();
    Contact1ctr = TextEditingController();
    Contact2ctr = TextEditingController();
    Whatsappctr = TextEditingController();
    Emailctr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  void updateDate(date) {
    Dobctr.text = date;
    update();
  }

  void updateAnniversaryDate(date) {
    Doactr.text = date;
    update();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var customerModel = ValidationModel(null, null, isValidate: false).obs;
  var profileModel = ValidationModel(null, null, isValidate: false).obs;
  var dobModel = ValidationModel(null, null, isValidate: false).obs;
  var doaModel = ValidationModel(null, null, isValidate: false).obs;
  var addressModel = ValidationModel(null, null, isValidate: false).obs;
  var contact1Model = ValidationModel(null, null, isValidate: false).obs;
  var contact2Model = ValidationModel(null, null, isValidate: false).obs;
  var whatsappModel = ValidationModel(null, null, isValidate: false).obs;
  var emailModel = ValidationModel(null, null, isValidate: false).obs;

  void enableSignUpButton() {
    return;
    // if (customerModel.value.isValidate == false) {
    //   isFormInvalidate.value = false;
    // } else if (profileModel.value.isValidate == false) {
    //   isFormInvalidate.value = false;
    // } else if (dobModel.value.isValidate == false) {
    //   isFormInvalidate.value = false;
    // } else if (doaModel.value.isValidate == false) {
    //   isFormInvalidate.value = false;
    // } else if (addressModel.value.isValidate == false) {
    //   isFormInvalidate.value = false;
    // } else if (contact1Model.value.isValidate == false) {
    //   isFormInvalidate.value = false;
    // } else if (contact2Model.value.isValidate == false) {
    //   isFormInvalidate.value = false;
    // } else if (whatsappModel.value.isValidate == false) {
    //   isFormInvalidate.value = false;
    // } else if (emailModel.value.isValidate == false) {
    //   isFormInvalidate.value = false;
    // } else {
    //   isFormInvalidate.value = true;
    // }
  }

  void validateCustomerName(String? val) {
    customerModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Customer Name";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateProfile(String? val) {
    profileModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Profile Photo";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateDob(String? val) {
    dobModel.update((model) {
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

  void validateDoa(String? val) {
    doaModel.update((model) {
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

  void validateAddree(String? val) {
    addressModel.update((model) {
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

  void validateContact1(String? val) {
    contact1Model.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Contact Number 1";
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

  void validateContact2(String? val) {
    contact2Model.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Contact Number 2";
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

  void validateWhatsapp(String? val) {
    whatsappModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Whatsapp Number";
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

  void validateEmail(String? val) {
    emailModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Email Id";
        model.isValidate = false;
      } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(Emailctr.text.trim())) {
        model!.error = "Enter Valid Email Id";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  RxBool isFormInvalidate = true.obs;
  RxString uploadImageId = ''.obs;

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void getImageApi(context) async {
    var loadingIndicator = LoadingProgressDialog();
    loadingIndicator.show(context, '');

    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Strings.noInternetConnection,
            callback: () {
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
      showDialogForScreen(context, Strings.servererror, callback: () {});
      loadingIndicator.hide(context);
    }
  }

  void addcustomerApi(context) async {
    var loadingIndicator = LoadingProgressDialog();
    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Strings.noInternetConnection,
            callback: () {
          Get.back();
        });
        return;
      }
      loadingIndicator.show(context, '');
      var retrievedObject = await UserPreferences().getSignInInfo();
      var response = await Repository.post({
        "name": Customerctr.text.toString().trim(),
        "contact_no": Contact1ctr.text.toString().trim(),
        "whatsapp_no": Whatsappctr.text.toString().trim(),
        "pic": uploadImageId.value.toString(),
        "email": Emailctr.text.toString().trim(),
        "date_of_birth": Dobctr.text.toString().trim(),
        "date_of_anniversary": Doactr.text.toString().trim(),
        "address": Addressctr.text.toString().trim(),
        "vendor_id": retrievedObject!.id.toString().trim()
      }, ApiUrl.addCustomer, allowHeader: true);
      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("RESPOSNE", data);
      if (response.statusCode == 200) {
        if (data['status'] == 1) {
          showDialogForScreen(context, data['message'].toString(),
              callback: () {
            Get.back();
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
      showDialogForScreen(context, Strings.servererror, callback: () {});
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
        title: "Add Customer",
        negativeButton: '',
        positiveButton: "Continue");
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
        if (file != null) {
          uploadImageFile = File(file.path).obs;
          Profilectr.text = file.name;
          validateProfile(Profilectr.text);
          getImageApi(context);
        }
      }
    });

    update();
  }
}
