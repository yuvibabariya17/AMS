import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Models/sign_in_form_validation.dart';
import 'internet_controller.dart';

class AddVendorController extends GetxController {
  late final GetStorage _getStorage;
  final InternetController _networkManager = Get.find<InternetController>();

  late FocusNode VendorNode, CompanyNode, AddressNode, EmailNode, ContactNode;

  late TextEditingController Vendorctr,
      Companyctr,
      Addressctr,
      Emailctr,
      Contactctr;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    _getStorage = GetStorage();

    VendorNode = FocusNode();
    CompanyNode = FocusNode();
    AddressNode = FocusNode();
    EmailNode = FocusNode();
    ContactNode = FocusNode();

    Vendorctr = TextEditingController();
    Companyctr = TextEditingController();
    Addressctr = TextEditingController();
    Emailctr = TextEditingController();
    Contactctr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  var isLoading = false.obs;

  var VendorModel = ValidationModel(null, null, isValidate: false).obs;
  var CompanyModel = ValidationModel(null, null, isValidate: false).obs;
  var AddressModel = ValidationModel(null, null, isValidate: false).obs;
  var EmailModel = ValidationModel(null, null, isValidate: false).obs;
  var ContactModel = ValidationModel(null, null, isValidate: false).obs;

  void enableSignUpButton() {
    if (VendorModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (CompanyModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (AddressModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (EmailModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (CompanyModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else {
      isFormInvalidate.value = true;
    }
  }

  void validateVendor(String? val) {
    VendorModel.update((model) {
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

  void validateCompany(String? val) {
    CompanyModel.update((model) {
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

  void validateAddress(String? val) {
    AddressModel.update((model) {
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
    EmailModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Email Id";
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
      if (val != null && val.isEmpty) {
        model!.error = "Enter Contact No.";
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
