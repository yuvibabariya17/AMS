import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../Models/sign_in_form_validation.dart';
import '../core/constants/strings.dart';
import '../dialogs/dialogs.dart';
import 'Appointment_screen_controller.dart';
import 'internet_controller.dart';

class EmailController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();
  final resetpasskey = GlobalKey<FormState>();

  late FocusNode emailNode;

  late TextEditingController emailctr;

  var emailModel = ValidationModel(null, null, isValidate: false).obs;

  Rx<ScreenState> states = ScreenState.apiLoading.obs;
  RxString message = "".obs;

  RxBool isFormInvalidate = false.obs;

  @override
  void onInit() {
    emailNode = FocusNode();

    emailctr = TextEditingController();

    super.onInit();
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

  void enableSignUpButton() {
    if (emailModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else {
      isFormInvalidate.value = true;
    }
  }

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
        title: ScreenTitle.changePassTitle,
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }
}
