import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Models/sign_in_form_validation.dart';
import 'internet_controller.dart';

class AddVendorServiceController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  late FocusNode FieldNode, TimeNode, ApproxNode, DurationNode;

  late TextEditingController fieldctr, timectr, approxctr, durationctr;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    FieldNode = FocusNode();
    TimeNode = FocusNode();
    ApproxNode = FocusNode();
    DurationNode = FocusNode();

    fieldctr = TextEditingController();
    timectr = TextEditingController();
    approxctr = TextEditingController();
    durationctr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var FieldModel = ValidationModel(null, null, isValidate: false).obs;
  var TimeModel = ValidationModel(null, null, isValidate: false).obs;
  var ApproxModel = ValidationModel(null, null, isValidate: false).obs;
  var DurationModel = ValidationModel(null, null, isValidate: false).obs;

  void enableSignUpButton() {
    if (FieldModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (TimeModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (ApproxModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (DurationModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else {
      isFormInvalidate.value = true;
    }
  }

  void validateFieldname(String? val) {
    FieldModel.update((model) {
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

  void validateTime(String? val) {
    TimeModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Time";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateApprox(String? val) {
    ApproxModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Approx Sitting";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateDuration(String? val) {
    DurationModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Duration of Sitting";
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
