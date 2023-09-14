import 'dart:convert';
import 'dart:io';
import 'package:booking_app/core/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../Config/apicall_constant.dart';
import '../Models/sign_in_form_validation.dart';
import '../api_handle/Repository.dart';
import '../core/utils/log.dart';
import '../dialogs/dialogs.dart';
import '../dialogs/loading_indicator.dart';
import '../preference/UserPreference.dart';
import 'Appointment_screen_controller.dart';
import 'internet_controller.dart';
import 'package:http/http.dart' as http;

class ReportBugController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  late FocusNode SelectvendorNode, ImageNode, VideoNode, NoteNode, dateNode;
  Rx<File?> avatarFile = null.obs;
  Rx<File?> videoFile = null.obs;
  Rx<ScreenState> state = ScreenState.apiLoading.obs;

  late TextEditingController selectvendorctr,
      imgctr,
      videoctr,
      notesctr,
      datectr;

  final formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  @override
  void onInit() {
    SelectvendorNode = FocusNode();
    ImageNode = FocusNode();
    VideoNode = FocusNode();
    NoteNode = FocusNode();
    dateNode = FocusNode();

    selectvendorctr = TextEditingController();
    imgctr = TextEditingController();
    videoctr = TextEditingController();
    notesctr = TextEditingController();
    datectr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  void updateDate(date) {
    datectr.text = date;
    update();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var SelectvendorModel = ValidationModel(null, null, isValidate: false).obs;
  var ImageModel = ValidationModel(null, null, isValidate: false).obs;
  var VideoModel = ValidationModel(null, null, isValidate: false).obs;
  var NoteModel = ValidationModel(null, null, isValidate: false).obs;
  var DateModel = ValidationModel(null, null, isValidate: false).obs;

  void enableSignUpButton() {
    if (SelectvendorModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (ImageModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (VideoModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (NoteModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (DateModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else {
      isFormInvalidate.value = true;
    }
  }

  void validateFieldname(String? val) {
    SelectvendorModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Field Name";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateImage(String? val) {
    ImageModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Image";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateVideo(String? val) {
    VideoModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Video";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateDate(String? val) {
    SelectvendorModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Field Name";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateNotes(String? val) {
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

  RxBool isFormInvalidate = false.obs;

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void navigate() {
    // Get.to(const SignUpScreen(false));
  }

  void addcustomerApi(context) async {
    var loadingIndicator = LoadingProgressDialog();
    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Strings.noInternetConnection,
            callback: () {
          Get.back();
        });
        return;
      }
      loadingIndicator.show(context, '');
      var retrievedObject = await UserPreferences().getSignInInfo();

      var response = await Repository.multiPartPost({
        "date_of_submit": datectr.text.toString().trim(),
        "notes": notesctr.text.toString().trim(),
        "vendor_id": retrievedObject!.id.toString().trim()
      }, ApiUrl.addReportBug,
          multiPart: avatarFile.value != null
              ? http.MultipartFile(
                  'img_url',
                  avatarFile.value!.readAsBytes().asStream(),
                  avatarFile.value!.lengthSync(),
                  filename: avatarFile.value!.path.split('/').last,
                )
              : null,
          multiPartData: videoFile.value != null
              ? http.MultipartFile(
                  'video_url',
                  videoFile.value!.readAsBytes().asStream(),
                  videoFile.value!.lengthSync(),
                  filename: videoFile.value!.path.split('/').last,
                )
              : null,
          allowHeader: true);
      var responseData = await response.stream.toBytes();
      loadingIndicator.hide(context);

      var result = String.fromCharCodes(responseData);
      var json = jsonDecode(result);

      if (response.statusCode == 200) {
        if (json['status'] == 1) {
          // Get.to(const dashboard());
        } else {
          showDialogForScreen(context, json['message'].toString(),
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, json['message'].toString(),
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context, Strings.noInternetConnection,
          callback: () {});
      loadingIndicator.hide(context);
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
        title: "Report Bug",
        negativeButton: '',
        positiveButton: "Continue");
  }

  Rx<File?> uploadReportFile = null.obs;
  Rx<File?> uploadVideoFile = null.obs;

  actionClickUploadImage(context) async {
    await ImagePicker()
        .pickImage(
            source: ImageSource.gallery,
            maxWidth: 1080,
            maxHeight: 1080,
            imageQuality: 100)
        .then((file) async {
      if (file != null) {
        if (file != null) {
          uploadReportFile = File(file.path).obs;
          imgctr.text = file.name;
          validateImage(imgctr.text);
        }
      }
    });

    update();
  }

  actionClickUploadVideo(context) async {
    await ImagePicker()
        .pickImage(
            source: ImageSource.gallery,
            maxWidth: 1080,
            maxHeight: 1080,
            imageQuality: 100)
        .then((file) async {
      if (file != null) {
        if (file != null) {
          uploadVideoFile = File(file.path).obs;
          videoctr.text = file.name;
          validateVideo(videoctr.text);
        }
      }
    });

    update();
  }
}
