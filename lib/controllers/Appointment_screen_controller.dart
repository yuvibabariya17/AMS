import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/notification_model.dart';
import '../Models/product.dart';
import 'internet_controller.dart';

enum ScreenState { apiLoading, apiError, apiSuccess, noNetwork, noDataFound }

class AppointmentScreenController extends GetxController {
  List<ProductItem> staticData = notificationItems;
  late TabController tabController;
  RxInt currentPage = 0.obs;
  bool isOnline = true;
  

  changeIndex(int index) async {
    currentPage.value = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  Rx<ScreenState> state = ScreenState.apiLoading.obs;
  RxString message = "".obs;
  final InternetController _networkManager = Get.find<InternetController>();

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
