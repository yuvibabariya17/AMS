import 'dart:convert';
import 'dart:io';
import 'package:booking_app/Config/apicall_constant.dart';
import 'package:booking_app/api_handle/Repository.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/dialogs/loading_indicator.dart';
import 'package:booking_app/preference/UserPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../Models/sign_in_form_validation.dart';
import '../dialogs/dialogs.dart';
import 'Appointment_screen_controller.dart';
import 'internet_controller.dart';

class AddPackageController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  late FocusNode nameNode,
      actfeesNode,
      packFeesNode,
      NoteNode,
      fromDurationNode,
      toDurationNode;
  Rx<File?> avatarFile = null.obs;
  Rx<File?> videoFile = null.obs;
  Rx<ScreenState> state = ScreenState.apiLoading.obs;

  late TextEditingController nameCtr,
      actfeesCtr,
      packFeesCtr,
      noteCtr,
      fromDurationCtr,
      toDurationCtr;

  final formKey = GlobalKey<FormState>();

  String startTime = "";
  String endTime = "";

  @override
  void onInit() {
    nameNode = FocusNode();
    actfeesNode = FocusNode();
    packFeesNode = FocusNode();
    NoteNode = FocusNode();
    fromDurationNode = FocusNode();
    toDurationNode = FocusNode();

    nameCtr = TextEditingController();
    actfeesCtr = TextEditingController();
    packFeesCtr = TextEditingController();
    noteCtr = TextEditingController();
    fromDurationCtr = TextEditingController();
    toDurationCtr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  void updateDate(date) {
    fromDurationCtr.text = date;
    update();
  }

  void updateAnniversaryDate(date) {
    toDurationCtr.text = date;
    update();
  }

  void updateStartTime(date) {
    fromDurationCtr.text = date;
    print("PICKED_DATE${fromDurationCtr.value}");
    update();
  }

  void updateEndTime(date) {
    toDurationCtr.text = date;
    print("PICKED_DATE${toDurationCtr.value}");
    update();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var NameModel = ValidationModel(null, null, isValidate: false).obs;
  var ActfeesModel = ValidationModel(null, null, isValidate: false).obs;
  var PackfeesModel = ValidationModel(null, null, isValidate: false).obs;
  var NoteModel = ValidationModel(null, null, isValidate: false).obs;
  var FromDurationModel = ValidationModel(null, null, isValidate: false).obs;
  var ToDurationModel = ValidationModel(null, null, isValidate: false).obs;

  void enableSignUpButton() {
    if (NameModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (ActfeesModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (PackfeesModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (NoteModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (FromDurationModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (ToDurationModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else {
      isFormInvalidate.value = true;
    }
  }

  void validateName(String? val) {
    NameModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Ente Package Name";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateActFees(String? val) {
    ActfeesModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Actual Fees";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validatePackFees(String? val) {
    PackfeesModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Package Fees";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateNote(String? val) {
    NoteModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Notes";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateToDuration(String? val) {
    ToDurationModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Notes";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateFromDuration(String? val) {
    FromDurationModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Notes";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void AddPackageApi(context) async {
    var loadingIndicator = LoadingProgressDialog();
    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Connection.noConnection, false,
            callback: () {
          Get.back();
        });
        return;
      }
      loadingIndicator.show(context, '');
      var retrievedObject = await UserPreferences().getSignInInfo();

      logcat(
        "ADD PACKAGE",
        {
          "vendor_id": retrievedObject!.id.toString().trim(),
          "name": nameCtr.text.toString().trim(),
          "act_fees": actfeesCtr.text.toString().trim(),
          "pack_fees": packFeesCtr.text.toString().trim(),
          "other_notes": noteCtr.text.toString().trim(),
          "duration_from": fromDurationCtr.text.toString().trim(),
          "duration_to": toDurationCtr.text.toString().trim(),
        },
      );

      var response = await Repository.post({
        "vendor_id": retrievedObject!.id.toString().trim(),
        "name": nameCtr.text.toString().trim(),
        "act_fees": actfeesCtr.text.toString().trim(),
        "pack_fees": packFeesCtr.text.toString().trim(),
        "other_notes": noteCtr.text.toString().trim(),
        "duration_from": fromDurationCtr.text.toString().trim(),
        "duration_to": toDurationCtr.text.toString().trim(),
      }, ApiUrl.addPackage, allowHeader: true);
      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("ADDCOURSE", data);
      // var responseDetail = GetLoginModel.fromJson(data);
      if (response.statusCode == 200) {
        if (data['status'] == 1) {
          showDialogForScreen(context, data['message'].toString(), false,
              callback: () {
            Get.back(result: true);
          });
        } else {
          showDialogForScreen(context, data['message'].toString(), false,
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, data['message'].toString(), false,
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context, Connection.servererror, false,
          callback: () {});
      loadingIndicator.hide(context);
    }
  }

  void UpdatePackageApi(context, String packageId) async {
    var loadingIndicator = LoadingProgressDialog();
    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Connection.noConnection, true,
            callback: () {
          Get.back();
        });
        return;
      }
      loadingIndicator.show(context, '');
      var retrievedObject = await UserPreferences().getSignInInfo();

      logcat(
        "UPDATE_PACKAGE",
        {
          "vendor_id": retrievedObject!.id.toString().trim(),
          "name": nameCtr.text.toString().trim(),
          "act_fees": actfeesCtr.text.toString().trim(),
          "pack_fees": packFeesCtr.text.toString().trim(),
          "other_notes": noteCtr.text.toString().trim(),
          "duration_from": fromDurationCtr.text.toString().trim(),
          "duration_to": toDurationCtr.text.toString().trim(),
        },
      );

      var response = await Repository.put({
        "vendor_id": retrievedObject!.id.toString().trim(),
        "name": nameCtr.text.toString().trim(),
        "act_fees": actfeesCtr.text.toString().trim(),
        "pack_fees": packFeesCtr.text.toString().trim(),
        "other_notes": noteCtr.text.toString().trim(),
        "duration_from": fromDurationCtr.text.toString().trim(),
        "duration_to": toDurationCtr.text.toString().trim(),
      }, '${ApiUrl.editPackage}/$packageId', allowHeader: true);
      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("ADDCOURSE", data);
      // var responseDetail = GetLoginModel.fromJson(data);
      if (response.statusCode == 200) {
        if (data['status'] == 1) {
          showDialogForScreen(context, data['message'].toString(), true,
              callback: () {
            Get.back(result: true);
          });
        } else {
          showDialogForScreen(context, data['message'].toString(), true,
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, data['message'].toString(), true,
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context, Connection.servererror, true,
          callback: () {});
      loadingIndicator.hide(context);
    }
  }

  RxBool isFormInvalidate = false.obs;
  RxString uploadImageId = ''.obs;
  RxString uploadBreacherId = ''.obs;

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void navigate() {
    // Get.to(const SignUpScreen(false));
  }

  showDialogForScreen(context, String message, bool? isEdit,
      {Function? callback}) {
    showMessage(
        context: context,
        callback: () {
          if (callback != null) {
            callback();
          }
          return true;
        },
        message: message,
        title:
            isEdit == true ? ScreenTitle.updatePackage : ScreenTitle.addPackage,
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }
}
