import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/constants/get_storage_key.dart';

class ThemeController extends GetxController {
  RxBool isDark = true.obs;
  @override
  void onInit() {
    super.onInit();
    fetchCurrent();
  }

  fetchCurrent() {
    var data = GetStorage().read(GetStorageKey.IS_DARK_MODE);
    if (data == null || data.toString().isEmpty) {
      isDark.value = false;
    } else if (GetStorage().read(GetStorageKey.IS_DARK_MODE) == 1) {
      isDark.value = false;
    } else {
      isDark.value = true;
    }

    update();
  }

  void toggleTheme() {
    isDark.value = !isDark.value;
    Get.changeTheme(isDark.value ? ThemeData.dark() : ThemeData.light());
  }

  updateState(int themeMode) {
    fetchCurrent();
  }
}
