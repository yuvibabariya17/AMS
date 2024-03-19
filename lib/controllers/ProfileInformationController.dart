import 'package:booking_app/controllers/home_screen_controller.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileInformationController extends GetxController {
  Rx<ScreenState> state = ScreenState.apiLoading.obs;

  var currentPage = 0;
  bool states = false;
  int isDarkModes = 0;

  String name = '';
  String number = '';

  RxString profilePic = "".obs;

  // RxString userName = "".obs;
  // RxString number = "".obs;
  // RxString email = "".obs;
  // RxString profilePic = "".obs;
  // RxString gender = "".obs;
  // RxString address = "".obs;
  // RxString companyaddress = "".obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  RxBool isFormInvalidate = false.obs;

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
        title: ScreenTitle.profile,
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }

  // void initDataSet(BuildContext context) async {
  //   logcat("Name", name.toString());
  //   logcat("Number", number.toString());
  //   SignInData? retrievedObject = await UserPreferences().getSignInInfo();

  //   name = retrievedObject!.userName.toString();
  //   // number = retrievedObject.contactNo1.toString();

  //   //controller.statectr.text = retrievedObject.stateId.toString();
  //   //controller.cityctr.text = retrievedObject.cityId.toString();
  //   update();
  // }
}
