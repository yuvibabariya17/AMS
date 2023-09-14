import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/get_storage_key.dart';

bool isDarkMode() {
  bool isDark;
  var data = GetStorage().read(GetStorageKey.IS_DARK_MODE);
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

Future<DateTime?> getDateTimePicker(context) async {
  DateTime? value = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100));
  print("Get Value:${value}");
  return value;
}
