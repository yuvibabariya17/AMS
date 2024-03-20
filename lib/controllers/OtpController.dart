import 'package:booking_app/controllers/home_screen_controller.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'internet_controller.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  late FocusNode node1, node2, node3, node4;
  late TextEditingController otp1, otp2, otp3, otp4;

  Rx<ScreenState> state = ScreenState.apiLoading.obs; 
  RxString message = "".obs;
  RxList memberList = [].obs;
  RxBool isFormInvalidate = false.obs;

  RxBool allFieldsFilled = false.obs;

  // Callback function to handle the last text field
  void handleLastField(bool isLastField) {
    if (isLastField && isFieldFilleds()) {
      logcat("isFieldFilleds", "DONE");
      // All fields are filled
      allFieldsFilled.value = true;
    } else {
      logcat("NotFieldFilleds", "DONE");
      allFieldsFilled.value = false;
    }
    logcat("allFieldsFilled", allFieldsFilled.value.toString());
    update();
  }

  // List<ServiceList> serviceObjectList = []; // Your data source
  bool isFieldFilleds() {
    return otp1.text.isNotEmpty &&
        otp2.text.isNotEmpty &&
        otp3.text.isNotEmpty &&
        otp4.text.isNotEmpty;
  }

  @override
  void onInit() {
    node1 = FocusNode();
    node2 = FocusNode();
    node3 = FocusNode();
    node4 = FocusNode();

    otp1 = TextEditingController();
    otp2 = TextEditingController();
    otp3 = TextEditingController();
    otp4 = TextEditingController();

    otp1.addListener(validateForm);
    otp2.addListener(validateForm);
    otp3.addListener(validateForm);
    otp4.addListener(validateForm);
    super.onInit();
  }

  void validateForm() {
    isFormInvalidate.value = isFieldFilleds();
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
        title: ScreenTitle.service,
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
