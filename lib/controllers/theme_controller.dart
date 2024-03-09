import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import '../../core/constants/get_storage_key.dart';

class ThemeController extends GetxController {
  RxBool isDark = true.obs;
  RxInt? isDarkMode = 0.obs;
  @override
  void onInit() {
    // initHive();
    super.onInit();
    fetchCurrent();
  }

  Future<void> initHive() async {
    final settingsBox = await Hive.openBox<int>(Strings.storeDarkMode);
    isDarkMode!.value = settingsBox.get(Strings.selectedMode) ?? 0;
    settingsBox.put(Strings.selectedMode, isDarkMode!.value);
    logcat('initHive', isDarkMode!.value.toString());
    update();
    update();
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
