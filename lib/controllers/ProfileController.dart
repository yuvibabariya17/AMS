import 'package:booking_app/controllers/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/Staff_model.dart';
import '../Models/service.dart';
import '../Models/service_model.dart';
import '../Models/staff.dart';
import '../dialogs/dialogs.dart';
import 'internet_controller.dart';

class ProfileController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  Rx<ScreenState> state = ScreenState.apiLoading.obs;
  late TabController tabController;
  List<ServiceItem> staticData = SettingsItems;
  List<StaffItem> staticData1 = StaffItems;
  var currentPage = 0;
  bool states = false;
  int isDarkModes = 0;

  RxString userName = "".obs;
  RxString number = "".obs;
  RxString email = "".obs;
  RxString profilePic = "".obs;
  RxString gender = "".obs;
  RxString address = "".obs;
  RxString companyaddress = "".obs;

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
        title: "Add Expert",
        negativeButton: '',
        positiveButton: "Continue");
  }
}
