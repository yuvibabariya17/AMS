import 'dart:io';
import 'package:booking_app/core/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../Models/sign_in_form_validation.dart';
import '../dialogs/dialogs.dart';
import 'Appointment_screen_controller.dart';
import 'internet_controller.dart';

class PackageController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

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
  DateTime selectedDate = DateTime.now();

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
        model!.error = "Enter Note";
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

  // void addcustomerApi(context) async {
  //   var loadingIndicator = LoadingProgressDialog();
  //   try {
  //     if (networkManager.connectionType == 0) {
  //       loadingIndicator.hide(context);
  //       showDialogForScreen(context, Connection.noConnection, callback: () {
  //         Get.back();
  //       });
  //       return;
  //     }
  //     loadingIndicator.show(context, '');
  //     var retrievedObject = await UserPreferences().getSignInInfo();
  //     var response = await Repository.multiPartPost({
  //       "date_of_submit": fromDurationCtr.text.toString().trim(),
  //       "notes": noteCtr.text.toString().trim(),
  //       "vendor_id": retrievedObject!.id.toString().trim()
  //     }, ApiUrl.addReportBug,
  //         multiPart: avatarFile.value != null
  //             ? http.MultipartFile(
  //                 'img_url',
  //                 avatarFile.value!.readAsBytes().asStream(),
  //                 avatarFile.value!.lengthSync(),
  //                 filename: avatarFile.value!.path.split('/').last,
  //               )
  //             : null,
  //         multiPartData: videoFile.value != null
  //             ? http.MultipartFile(
  //                 'video_url',
  //                 videoFile.value!.readAsBytes().asStream(),
  //                 videoFile.value!.lengthSync(),
  //                 filename: videoFile.value!.path.split('/').last,
  //               )
  //             : null,
  //         allowHeader: true);
  //     var responseData = await response.stream.toBytes();
  //     loadingIndicator.hide(context);
  //     var result = String.fromCharCodes(responseData);
  //     var json = jsonDecode(result);
  //     if (response.statusCode == 200) {
  //       if (json['status'] == 1) {
  //         // Get.to(const dashboard());
  //       } else {
  //         showDialogForScreen(context, json['message'].toString(),
  //             callback: () {});
  //       }
  //     } else {
  //       state.value = ScreenState.apiError;
  //       showDialogForScreen(context, json['message'].toString(),
  //           callback: () {});
  //     }
  //   } catch (e) {
  //     logcat("Exception", e);
  //     showDialogForScreen(context, Connection.noConnection, callback: () {});
  //     loadingIndicator.hide(context);
  //   }
  // }

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
        title: ScreenTitle.reportBug,
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }

  // void getImage(context) async {
  //   var loadingIndicator = LoadingProgressDialog();
  //   loadingIndicator.show(context, '');
  //   try {
  //     if (networkManager.connectionType == 0) {
  //       loadingIndicator.hide(context);
  //       showDialogForScreen(context, Connection.noConnection, callback: () {
  //         Get.back();
  //       });
  //       return;
  //     }
  //     var response = await Repository.multiPartPost({
  //       "file": uploadReportFile.value!.path.split('/').last,
  //     }, ApiUrl.uploadImage,
  //         multiPart: uploadReportFile.value != null
  //             ? http.MultipartFile(
  //                 'file',
  //                 uploadReportFile.value!.readAsBytes().asStream(),
  //                 uploadReportFile.value!.lengthSync(),
  //                 filename: uploadReportFile.value!.path.split('/').last,
  //               )
  //             : null,
  //         allowHeader: true);
  //     var responseDetail = await response.stream.toBytes();
  //     loadingIndicator.hide(context);
  //     var result = String.fromCharCodes(responseDetail);
  //     var json = jsonDecode(result);
  //     var responseData = UploadImageModel.fromJson(json);
  //     if (response.statusCode == 200) {
  //       logcat("responseData", jsonEncode(responseData));
  //       if (responseData.status == "True") {
  //         logcat("UPLOAD_IMAGE_ID", responseData.data.id.toString());
  //         uploadImageId.value = responseData.data.id.toString();
  //       } else {
  //         showDialogForScreen(context, responseData.message.toString(),
  //             callback: () {});
  //       }
  //     } else {
  //       state.value = ScreenState.apiError;
  //       showDialogForScreen(context, responseData.message.toString(),
  //           callback: () {});
  //     }
  //   } catch (e) {
  //     logcat("Exception", e);
  //     showDialogForScreen(context, Connection.servererror, callback: () {});
  //     loadingIndicator.hide(context);
  //   }
  // }

  // void getVideo(context) async {
  //   var loadingIndicator = LoadingProgressDialog();
  //   loadingIndicator.show(context, '');
  //   try {
  //     if (networkManager.connectionType == 0) {
  //       loadingIndicator.hide(context);
  //       showDialogForScreen(context, Connection.noConnection, callback: () {
  //         Get.back();
  //       });
  //       return;
  //     }
  //     var response = await Repository.multiPartPost({
  //       "file": uploadVideoFile.value!.path.split('/').last,
  //     }, ApiUrl.uploadImage,
  //         multiPart: uploadVideoFile.value != null
  //             ? http.MultipartFile(
  //                 'file',
  //                 uploadVideoFile.value!.readAsBytes().asStream(),
  //                 uploadVideoFile.value!.lengthSync(),
  //                 filename: uploadVideoFile.value!.path.split('/').last,
  //               )
  //             : null,
  //         allowHeader: true);
  //     var responseDetail = await response.stream.toBytes();
  //     loadingIndicator.hide(context);
  //     var result = String.fromCharCodes(responseDetail);
  //     var json = jsonDecode(result);
  //     var responseData = UploadImageModel.fromJson(json);
  //     if (response.statusCode == 200) {
  //       logcat("responseData", jsonEncode(responseData));
  //       if (responseData.status == "True") {
  //         logcat("UPLOAD_IMAGE_ID", responseData.data.id.toString());
  //         uploadBreacherId.value = responseData.data.id.toString();
  //       } else {
  //         showDialogForScreen(context, responseData.message.toString(),
  //             callback: () {});
  //       }
  //     } else {
  //       state.value = ScreenState.apiError;
  //       showDialogForScreen(context, responseData.message.toString(),
  //           callback: () {});
  //     }
  //   } catch (e) {
  //     logcat("Exception", e);
  //     showDialogForScreen(context, Connection.servererror, callback: () {});
  //     loadingIndicator.hide(context);
  //   }
  // }

  // actionClickUploadImage(context, {bool? isCamera}) async {
  //   await ImagePicker()
  //       .pickImage(
  //           //source: ImageSource.gallery,
  //           source: isCamera == true ? ImageSource.camera : ImageSource.gallery,
  //           maxWidth: 1080,
  //           maxHeight: 1080,
  //           imageQuality: 100)
  //       .then((file) async {
  //     if (file != null) {
  //       //Cropping the image
  //       CroppedFile? croppedFile = await ImageCropper().cropImage(
  //           sourcePath: file.path,
  //           maxWidth: 1080,
  //           maxHeight: 1080,
  //           cropStyle: CropStyle.rectangle,
  //           aspectRatioPresets: Platform.isAndroid
  //               ? [
  //                   CropAspectRatioPreset.square,
  //                   CropAspectRatioPreset.ratio3x2,
  //                   CropAspectRatioPreset.original,
  //                   CropAspectRatioPreset.ratio4x3,
  //                   CropAspectRatioPreset.ratio16x9
  //                 ]
  //               : [
  //                   CropAspectRatioPreset.original,
  //                   CropAspectRatioPreset.square,
  //                   CropAspectRatioPreset.ratio3x2,
  //                   CropAspectRatioPreset.ratio4x3,
  //                   CropAspectRatioPreset.ratio5x3,
  //                   CropAspectRatioPreset.ratio5x4,
  //                   CropAspectRatioPreset.ratio7x5,
  //                   CropAspectRatioPreset.ratio16x9
  //                 ],
  //           uiSettings: [
  //             AndroidUiSettings(
  //                 toolbarTitle: 'Crop Image',
  //                 cropGridColor: primaryColor,
  //                 toolbarColor: primaryColor,
  //                 statusBarColor: primaryColor,
  //                 toolbarWidgetColor: white,
  //                 activeControlsWidgetColor: primaryColor,
  //                 initAspectRatio: CropAspectRatioPreset.original,
  //                 lockAspectRatio: false),
  //             IOSUiSettings(
  //               title: 'Crop Image',
  //               cancelButtonTitle: 'Cancel',
  //               doneButtonTitle: 'Done',
  //               aspectRatioLockEnabled: false,
  //             ),
  //           ],
  //           aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
  //       if (file != null) {
  //         uploadReportFile = File(file.path).obs;
  //         actfeesCtr.text = file.name;
  //         validateActFees(actfeesCtr.text);
  //         getImage(context);
  //       }
  //       // if (croppedFile != null) {
  //       //   uploadImageFile = File(croppedFile.path).obs;
  //       //   profilePic.value = croppedFile.path;
  //       //   update();
  //       // }
  //     }
  //   });
  //   update();
  // }

  // actionClickUploadVideo(context, {bool? isCamera}) async {
  //   await ImagePicker()
  //       .pickVideo(
  //           //source: ImageSource.gallery,
  //           source: isCamera == true ? ImageSource.camera : ImageSource.gallery,
  //           maxDuration: Duration(seconds: 60))
  //       .then((file) async {
  //     if (file != null) {
  //       //Cropping the image
  //       // CroppedFile? croppedFile = await ImageCropper().cropImage(
  //       //     sourcePath: file.path,
  //       //     maxWidth: 1080,
  //       //     maxHeight: 1080,
  //       //     cropStyle: CropStyle.rectangle,
  //       //     aspectRatioPresets: Platform.isAndroid
  //       //         ? [
  //       //             CropAspectRatioPreset.square,
  //       //             CropAspectRatioPreset.ratio3x2,
  //       //             CropAspectRatioPreset.original,
  //       //             CropAspectRatioPreset.ratio4x3,
  //       //             CropAspectRatioPreset.ratio16x9
  //       //           ]
  //       //         : [
  //       //             CropAspectRatioPreset.original,
  //       //             CropAspectRatioPreset.square,
  //       //             CropAspectRatioPreset.ratio3x2,
  //       //             CropAspectRatioPreset.ratio4x3,
  //       //             CropAspectRatioPreset.ratio5x3,
  //       //             CropAspectRatioPreset.ratio5x4,
  //       //             CropAspectRatioPreset.ratio7x5,
  //       //             CropAspectRatioPreset.ratio16x9
  //       //           ],
  //       //     uiSettings: [
  //       //       AndroidUiSettings(
  //       //           toolbarTitle: 'Crop Image',
  //       //           cropGridColor: primaryColor,
  //       //           toolbarColor: primaryColor,
  //       //           statusBarColor: primaryColor,
  //       //           toolbarWidgetColor: white,
  //       //           activeControlsWidgetColor: primaryColor,
  //       //           initAspectRatio: CropAspectRatioPreset.original,
  //       //           lockAspectRatio: false),
  //       //       IOSUiSettings(
  //       //         title: 'Crop Image',
  //       //         cancelButtonTitle: 'Cancel',
  //       //         doneButtonTitle: 'Done',
  //       //         aspectRatioLockEnabled: false,
  //       //       ),
  //       //     ],
  //       //     aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
  //       if (file != null) {
  //         uploadVideoFile = File(file.path).obs;
  //         packFeesCtr.text = file.name;
  //         validatePackFees(packFeesCtr.text);
  //         getVideo(context);
  //       }
  //       // if (croppedFile != null) {
  //       //   uploadImageFile = File(croppedFile.path).obs;
  //       //   profilePic.value = croppedFile.path;
  //       //   update();
  //       // }
  //     }
  //   });

  //   update();
  // }

  // Rx<File?> uploadReportFile = null.obs;
  // Rx<File?> uploadVideoFile = null.obs;

  // // actionClickUploadImage(context) async {
  // //   await ImagePicker()
  // //       .pickImage(
  // //           source: ImageSource.gallery,
  // //           maxWidth: 1080,
  // //           maxHeight: 1080,
  // //           imageQuality: 100)
  // //       .then((file) async {
  // //     if (file != null) {
  // //       if (file != null) {
  // //         uploadReportFile = File(file.path).obs;
  // //         imgctr.text = file.name;
  // //         validateImage(imgctr.text);
  // //       }
  // //     }
  // //   });

  // //   update();
  // // }

  // // actionClickUploadVideo(context) async {
  // //   await ImagePicker()
  // //       .pickImage(
  // //           source: ImageSource.gallery,
  // //           maxWidth: 1080,
  // //           maxHeight: 1080,
  // //           imageQuality: 100)
  // //       .then((file) async {
  // //     if (file != null) {
  // //       if (file != null) {
  // //         uploadVideoFile = File(file.path).obs;
  // //         videoctr.text = file.name;
  // //         validateVideo(videoctr.text);
  // //       }
  // //     }
  // //   });

  // //   update();
  // // }
}
