import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Models/sign_in_form_validation.dart';
import 'internet_controller.dart';

class PhoneController extends GetxController {
  late final GetStorage _getStorage;
  final InternetController _networkManager = Get.find<InternetController>();

  late FocusNode Phone;

  late TextEditingController phonectr;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    _getStorage = GetStorage();

    Phone = FocusNode();

    phonectr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var phoneModel = ValidationModel(null, null, isValidate: false).obs;

  void enableSignUpButton() {
    if (phoneModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else {
      isFormInvalidate.value = true;
    }
  }

  void validatePhone(String? val) {
    phoneModel.update((model) {
      if (val == null || val.isEmpty) {
        model!.error = "Enter Contact No.1";
        model.isValidate = false;
      } else if (val.replaceAll(' ', '').length < 10) {
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

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void navigate() {
    // Get.to(const SignUpScreen(false));
  }
}
