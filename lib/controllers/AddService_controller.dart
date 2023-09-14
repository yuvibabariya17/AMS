import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Models/sign_in_form_validation.dart';
import 'internet_controller.dart';

class AddserviceController extends GetxController {
  late final GetStorage _getStorage;
  final InternetController _networkManager = Get.find<InternetController>();

  late FocusNode ServiceNode, ExpertNode, PriceNode;

  late TextEditingController Servicectr, Expertctr, Pricectr;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    _getStorage = GetStorage();

    ServiceNode = FocusNode();
    ExpertNode = FocusNode();
    PriceNode = FocusNode();

    Servicectr = TextEditingController();
    Expertctr = TextEditingController();
    Pricectr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var ServiceModel = ValidationModel(null, null, isValidate: false).obs;
  var ExpertModel = ValidationModel(null, null, isValidate: false).obs;
  var PriceModel = ValidationModel(null, null, isValidate: false).obs;

  void enableSignUpButton() {
    if (ServiceModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (ExpertModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (PriceModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else {
      isFormInvalidate.value = true;
    }
  }

  void validateServicename(String? val) {
    ServiceModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Service Name";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateExpertname(String? val) {
    ExpertModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Expert Name";
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
        model!.error = "Enter Price";
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
