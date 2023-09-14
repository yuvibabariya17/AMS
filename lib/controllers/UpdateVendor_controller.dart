import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Models/sign_in_form_validation.dart';
import 'internet_controller.dart';

class UpdateVendorController extends GetxController {
  late final GetStorage _getStorage;
  final InternetController _networkManager = Get.find<InternetController>();

  late FocusNode VendornameNode,
      CompanynameNode,
      CompanyAddressNode,
      EmailNode,
      PassNode,
      ContactpernameNode,
      Contact_oneNode,
      Contact_twoNode,
      WhatsappNode,
      LogoNode,
      BreachersNode,
      ProfileNode,
      PropertyNode;

  late TextEditingController Vendornamectr,
      companyctr,
      addressctr,
      emailctr,
      passctr,
      contactpernamectr,
      contact_onectr,
      contact_twoctr,
      whatsappctr,
      logoctr,
      breacherctr,
      profilectr,
      propertyctr;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    _getStorage = GetStorage();

    VendornameNode = FocusNode();
    CompanynameNode = FocusNode();
    CompanyAddressNode = FocusNode();
    EmailNode = FocusNode();
    PassNode = FocusNode();
    ContactpernameNode = FocusNode();
    Contact_oneNode = FocusNode();
    Contact_twoNode = FocusNode();
    WhatsappNode = FocusNode();
    LogoNode = FocusNode();
    BreachersNode = FocusNode();
    ProfileNode = FocusNode();
    PropertyNode = FocusNode();

    emailctr = TextEditingController();
    passctr = TextEditingController();
    Vendornamectr = TextEditingController();
    companyctr = TextEditingController();
    addressctr = TextEditingController();
    contactpernamectr = TextEditingController();
    contact_onectr = TextEditingController();
    contact_twoctr = TextEditingController();
    whatsappctr = TextEditingController();
    logoctr = TextEditingController();
    breacherctr = TextEditingController();
    profilectr = TextEditingController();
    propertyctr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var passModel = ValidationModel(null, null, isValidate: false).obs;
  var vendornameModel = ValidationModel(null, null, isValidate: false).obs;
  var companyModel = ValidationModel(null, null, isValidate: false).obs;
  var addressModel = ValidationModel(null, null, isValidate: false).obs;
  var emailModel = ValidationModel(null, null, isValidate: false).obs;
  var contactnameModel = ValidationModel(null, null, isValidate: false).obs;
  var contactoneModel = ValidationModel(null, null, isValidate: false).obs;
  var contacttwoModel = ValidationModel(null, null, isValidate: false).obs;
  var whatsappModel = ValidationModel(null, null, isValidate: false).obs;
  var logoModel = ValidationModel(null, null, isValidate: false).obs;
  var breacherModel = ValidationModel(null, null, isValidate: false).obs;
  var profileModel = ValidationModel(null, null, isValidate: false).obs;
  var propertyModel = ValidationModel(null, null, isValidate: false).obs;

  void validateVendorname(String? val) {
    vendornameModel.update((model) {
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

  void validatePass(String? val) {
    passModel.update((model) {
      if (val == null || val.isEmpty) {
        model!.error = "Enter Password";
        model.isValidate = false;
      } else if (val.replaceAll(' ', '').length < 10) {
        model!.error = "Enter Valid Password";
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

  void validateCompanyname(String? val) {
    companyModel.update((model) {
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

  void validatePhone1(String? val) {
    contactoneModel.update((model) {
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

  void validatePhone2(String? val) {
    contacttwoModel.update((model) {
      if (val == null || val.isEmpty) {
        model!.error = "Enter Contact No.2";
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

  void validatePhone3(String? val) {
    whatsappModel.update((model) {
      if (val == null || val.isEmpty) {
        model!.error = "Enter Whatsapp No";
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

  void validateLogo(String? val) {
    logoModel.update((model) {
      if (val == null || val.isEmpty) {
        model!.error = "Select Logo";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateBreacher(String? val) {
    breacherModel.update((model) {
      if (val == null || val.isEmpty) {
        model!.error = "Select Breachers";
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
      if (val == null || val.isEmpty) {
        model!.error = "Select Profile Pic";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateProperty(String? val) {
    propertyModel.update((model) {
      if (val == null || val.isEmpty) {
        model!.error = "Select Property Images";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void enableSignUpButton() {
    if (vendornameModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (companyModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (addressModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (emailModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (passModel.value.isValidate == false) {
      isFormInvalidate.value = false;
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
