import 'package:booking_app/controllers/theme_controller.dart';
import 'package:booking_app/core/constants/get_storage_key.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';

bool isDarkMode() {
  bool isDark;
  var data = Get.find<ThemeController>().isDarkMode;
  //  print("IsDarkModeEMPTY${isDark}");
  if (data == null || data.toString().isEmpty) {
    isDark = false;
    print("IsDarkModeEMPTY${isDark}");
  } else if (GetStorage().read(GetStorageKey.IS_DARK_MODE) == 1) {
    isDark = false;
    print("IsLIGHTModeEMPTY${isDark}");
  } else {
    isDark = true;
    print("IsDarkMode${isDark}");
  }
  return isDark;
}

// bool isDarkMode() {
//   var box = Hive.box(Strings.storeDarkMode);
//   var name = box.get('name');

//   print('Name: $name');
//   bool isDark = false; // Default value
//   // Open the Hive box
//   Hive.openBox<int>(Strings.storeDarkMode).then((settingsBox) {
//     // Read the selected mode from the box
//     var data = settingsBox.get(Strings.selectedMode);

//     // Check if the data is null or empty
//     if (data == null || data.toString().isEmpty) {
//       isDark = false;
//       print("IsDarkModeEMPTY${isDark}");
//     }
//     // Check if the selected mode is 1 (indicating light mode)
//     else if (data == 1) {
//       isDark = false;
//       print("IsLIGHTModeEMPTY${isDark}");
//     }
//     // If none of the above conditions are true, assume dark mode
//     else {
//       isDark = true;
//       print("IsDarkMode${isDark}");
//     }
//   }).catchError((error) {
//     // Handle any errors that occur during box opening or data retrieval
//     print("Error opening Hive box: $error");
//   });

//   return isDark;
// }

Future<DateTime?> getDateTimePicker(context) async {
  DateTime? value = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100));
  print("Get Value:${value}");
  return value;
}
