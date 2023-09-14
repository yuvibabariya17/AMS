import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Models/sign_in_form_validation.dart';
import 'internet_controller.dart';

class SignUpController extends GetxController {
  late final GetStorage _getStorage;
  final InternetController _networkManager = Get.find<InternetController>();

  late FocusNode vendorNameNode,
      companyNameNode,
      addressNode,
      emailNode,
      contactNode;

  late TextEditingController vendorNameCtr,
      companyNameCtr,
      addressCtr,
      emailCtr,
      contactCtr;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    _getStorage = GetStorage();

    vendorNameNode = FocusNode();
    companyNameNode = FocusNode();
    addressNode = FocusNode();
    emailNode = FocusNode();
    contactNode = FocusNode();

    vendorNameCtr = TextEditingController();
    companyNameCtr = TextEditingController();
    addressCtr = TextEditingController();
    emailCtr = TextEditingController();
    contactCtr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var vendorNameModel = ValidationModel(null, null, isValidate: false).obs;
  var companyNameModel = ValidationModel(null, null, isValidate: false).obs;
  var addressModel = ValidationModel(null, null, isValidate: false).obs;
  var emailModel = ValidationModel(null, null, isValidate: false).obs;
  var mobileNoModel = ValidationModel(null, null, isValidate: false).obs;

  void validateVendorname(String? val) {
    vendorNameModel.update((model) {
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

  void validateCompanyname(String? val) {
    companyNameModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Company Name";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateAddressname(String? val) {
    addressModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Company Address";
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
      if (val == null || val.isEmpty) {
        model!.error = "Enter Email Id";
        model.isValidate = false;
      } else if (!GetUtils.isEmail(val)) {
        model!.error = "Enter Valid Email";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });
    enableSignUpButton();
  }

  void validatePhone(String? val) {
    mobileNoModel.update((model) {
      if (val == null || val.isEmpty) {
        model!.error = "Enter Contact No";
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

  void enableSignUpButton() {
    if (vendorNameModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (companyNameModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (addressModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (emailModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (mobileNoModel.value.isValidate == false) {
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

  void navigate() {
    // Get.to(const SignUpScreen(false));
  }
}
