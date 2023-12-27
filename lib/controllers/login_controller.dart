import 'dart:convert';

import 'package:booking_app/Screens/DashboardScreen.dart';
import 'package:booking_app/models/SignInModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Config/apicall_constant.dart';
import '../Models/sign_in_form_validation.dart';
import '../api_handle/Repository.dart';
import '../core/constants/strings.dart';
import '../core/utils/log.dart';
import '../dialogs/dialogs.dart';
import '../dialogs/loading_indicator.dart';
import '../preference/UserPreference.dart';
import 'Appointment_screen_controller.dart';
import 'internet_controller.dart';

class LoginController extends GetxController {
  late final GetStorage getStorage;
  final InternetController networkManager = Get.find<InternetController>();

  late FocusNode Email, Pass;

  late TextEditingController emailctr, passctr;

  Rx<ScreenState> state = ScreenState.apiLoading.obs;

  final formKey = GlobalKey<FormState>();
  RxBool obsecureText = true.obs;

  @override
  void onInit() {
    getStorage = GetStorage();

    Email = FocusNode();
    Pass = FocusNode();

    emailctr = TextEditingController();
    passctr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  var isLoading = false.obs;
  var emailModel = ValidationModel(null, null, isValidate: false).obs;
  var passModel = ValidationModel(null, null, isValidate: false).obs;

  void enableSignUpButton() {
    if (emailModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (passModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else {
      isFormInvalidate.value = true;
    }
  }

  void validateEmail(String? val) {
    emailModel.update((model) {
      if (val != null && val.toString().trim().isEmpty) {
        model!.error = "Enter Email Id";
        model.isValidate = false;
      } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(emailctr.text.trim())) {
        model!.error = "Enter Valid Email Id";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validatePassword(String? val) {
    passModel.update((model) {
      if (val == null || val.toString().trim().isEmpty) {
        model!.error = "Enter Password";
        model.isValidate = false;
      } else if (val.length < 8) {
        model!.error = "Enter Valid Password";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });
    enableSignUpButton();
  }

  RxBool isFormInvalidate = false.obs;

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void signInAPI(context) async {
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
      var response = await Repository.post({
        "email_id": emailctr.text.toString().trim(),
        "password": passctr.text.toString().trim()
      }, ApiUrl.login);
      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("RESPOSNE", data);
      if (response.statusCode == 200) {
        var responseDetail = GetLoginModel.fromJson(data);
        if (responseDetail.status == 1) {
          UserPreferences().saveSignInInfo(responseDetail.data);
          UserPreferences().setToken(responseDetail.data.token.toString());
          Get.offAll(dashboard());
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

  // void signInAPI(context) async {
  //   var loadingIndicator = LoadingProgressDialog();
  //   try {
  //     if (networkManager.connectionType == 0) {
  //       loadingIndicator.hide(context);
  //       showDialogForScreen(context,  Strings.noInternetConnection, callback: () {
  //         Get.back();
  //       });
  //       return;
  //     }
  //     loadingIndicator.show(context, '');
  //     var response = await Repository.post({
  //       "email_id": emailctr.text.toString().trim(),
  //       "password": passctr.text.toString().trim()
  //     }, ApiUrl.login);
  //     loadingIndicator.hide(context);
  //     var data = jsonDecode(response.body);
  //     logcat("RESPOSNE", data);
  //     var responseDetail = GetLoginModel.fromJson(data);
  //     if (response.statusCode == 200) {
  //       if (responseDetail.status == 1) {
  //         UserPreferences().saveSignInInfo(responseDetail.data);
  //         UserPreferences().setToken(responseDetail.data.token.toString());
  //         Get.to(const dashboard());
  //       } else {
  //         showDialogForScreen(context, responseDetail.message.toString(),
  //             callback: () {});
  //       }
  //     } else {
  //       state.value = ScreenState.apiError;
  //       showDialogForScreen(context, responseDetail.message.toString(),
  //           callback: () {});
  //     }
  //   } catch (e) {
  //     logcat("Exception", e);
  //     showDialogForScreen(context,  Strings.servererror,
  //         callback: () {});
  //     loadingIndicator.hide(context);
  //   }
  // }

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
        title: ScreenTitle.signIn,
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }
}
