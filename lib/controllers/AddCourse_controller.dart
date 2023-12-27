import 'dart:convert';
import 'dart:io';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:booking_app/Models/UploadImageModel.dart';

import '../Config/apicall_constant.dart';
import '../Models/CourseModel.dart';
import '../Models/SigninModel.dart';
import '../Models/sign_in_form_validation.dart';
import '../Screens/DashboardScreen.dart';
import '../api_handle/Repository.dart';
import '../core/constants/strings.dart';
import '../core/themes/font_constant.dart';
import '../core/utils/log.dart';
import '../dialogs/dialogs.dart';
import '../dialogs/loading_indicator.dart';
import '../preference/UserPreference.dart';
import 'Appointment_screen_controller.dart';
import 'package:http/http.dart' as http;
import 'internet_controller.dart';

class AddCourseController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  Rx<ScreenState> state = ScreenState.apiLoading.obs;

  RxString profilePic = "".obs;

  final formKey = GlobalKey<FormState>();

  late FocusNode StudentNode,
      CourseNode,
      FeesNode,
      StartNode,
      DurationNode,
      DescNode,
      NotesNode,
      IdNode;

  late TextEditingController Studentctr,
      Coursectr,
      Feesctr,
      Startctr,
      Durationctr,
      Descctr,
      Notesctr,
      Idctr;

  @override
  void onInit() {
    StudentNode = FocusNode();
    CourseNode = FocusNode();
    FeesNode = FocusNode();
    DurationNode = FocusNode();
    StartNode = FocusNode();
    DescNode = FocusNode();
    NotesNode = FocusNode();
    IdNode = FocusNode();

    Studentctr = TextEditingController();
    Coursectr = TextEditingController();
    Feesctr = TextEditingController();
    Startctr = TextEditingController();
    Durationctr = TextEditingController();
    Descctr = TextEditingController();
    Notesctr = TextEditingController();
    Idctr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  void updateDate(date) {
    Startctr.text = date;
    print("PICKED_DATE${Startctr.value}");
    update();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var StudentModel = ValidationModel(null, null, isValidate: false).obs;
  var CourseModel = ValidationModel(null, null, isValidate: false).obs;
  var FeesModel = ValidationModel(null, null, isValidate: false).obs;
  var DurationModel = ValidationModel(null, null, isValidate: false).obs;
  var DescModel = ValidationModel(null, null, isValidate: false).obs;
  var NotesModel = ValidationModel(null, null, isValidate: false).obs;
  var IdModel = ValidationModel(null, null, isValidate: false).obs;

  void enableSignUpButton() {
    if (StudentModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    }
    // else if (CourseModel.value.isValidate == false) {
    //   isFormInvalidate.value = false;
    // }

    else if (FeesModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (DurationModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (DescModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (NotesModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (IdModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else {
      isFormInvalidate.value = true;
    }
  }

  void validateStudent(String? val) {
    StudentModel.update((model) {
      if (val != null && val.toString().trim().isEmpty) {
        model!.error = "Enter Student Name";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateCourse(String? val) {
    CourseModel.update((model) {
      if (val != null && val.toString().trim().isEmpty) {
        model!.error = "Enter Course";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateFee(String? val) {
    FeesModel.update((model) {
      if (val != null && val.toString().trim().isEmpty) {
        model!.error = "Enter Fee";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateStartDate(String? val) {
    DurationModel.update((model) {
      if (val != null && val.toString().trim().isEmpty) {
        model!.error = "Select Start Date";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateDescription(String? val) {
    DescModel.update((model) {
      if (val != null && val.toString().trim().isEmpty) {
        model!.error = "Enter Description";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateNotes(String? val) {
    NotesModel.update((model) {
      if (val != null && val.toString().trim().isEmpty) {
        model!.error = "Enter Notes";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateId(String? val) {
    IdModel.update((model) {
      if (val != null && val.toString().trim().isEmpty) {
        model!.error = "Enter Image";
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

  void AddCourseApi(context) async {
    var loadingIndicator = LoadingProgressDialog();
    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      loadingIndicator.show(context, '');
      var retrievedObject = await UserPreferences().getSignInInfo();

      logcat("ADDCOURSE", {
        "name": Studentctr.text.toString().trim(),
        "thumbnail_url": uploadImageId.value.toString(),
        "duration": Durationctr.text.toString().trim(),
        "fees": Feesctr.text.toString().trim(),
        "description": Descctr.text.toString().trim(),
        "vendor_id": retrievedObject!.id.toString().trim()
      });

      var response = await Repository.post({
        "name": Studentctr.text.toString().trim(),
        "thumbnail_url": uploadImageId.value.toString(),
        "duration": Durationctr.text.toString().trim(),
        "fees": Feesctr.text.toString().trim(),
        "description": Descctr.text.toString().trim(),
        "vendor_id": retrievedObject!.id.toString().trim()
      }, ApiUrl.addCourse, allowHeader: true);
      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("RESPOSNE", data);
      // var responseDetail = GetLoginModel.fromJson(data);
      if (response.statusCode == 200) {
        if (data['status'] == 1) {
          showDialogForScreen(context, data['message'].toString(),
              callback: () {
            Get.back();
          });
        } else {
          showDialogForScreen(context, data['message'].toString(),
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, data['message'].toString(),
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context, Connection.servererror, callback: () {});
      loadingIndicator.hide(context);
    }
  }

  RxBool isCourseTypeApiCall = false.obs;
  RxList<ListofCourse> courseObjectList = <ListofCourse>[].obs;
  RxString courseId = "".obs;

  void getCourseApi(context) async {
    isCourseTypeApiCall.value = true;
    // try {
    if (networkManager.connectionType == 0) {
      showDialogForScreen(context, Connection.noConnection, callback: () {
        Get.back();
      });
      return;
    }
    var response =
        await Repository.post({}, ApiUrl.courselist, allowHeader: true);
    isCourseTypeApiCall.value = false;
    var responseData = jsonDecode(response.body);
    logcat("RESPONSE", jsonEncode(responseData));

    if (response.statusCode == 200) {
      var data = CourseListModel.fromJson(responseData);
      if (data.status == 1) {
        courseObjectList.clear();
        courseObjectList.addAll(data.data);
        logcat("RESPONSE", jsonEncode(courseObjectList));
      } else {
        showDialogForScreen(context, responseData['message'], callback: () {});
      }
    } else {
      showDialogForScreen(context, Connection.servererror, callback: () {});
    }
    // } catch (e) {
    //   logcat('Exception', e);
    //   isCourseTypeApiCall.value = false;
    // }
  }

  Widget setCourseList() {
    return Obx(() {
      if (isCourseTypeApiCall.value == true)
        return setDropDownContent([].obs, Text("Loading"),
            isApiIsLoading: isCourseTypeApiCall.value);

      return setDropDownTestContent(
        courseObjectList,
        ListView.builder(
          shrinkWrap: true,
          itemCount: courseObjectList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              dense: true,
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
              horizontalTitleGap: null,
              minLeadingWidth: 5,
              onTap: () {
                Get.back();
                logcat("ONTAP", "SACHIN");
                courseId.value = courseObjectList[index].name.toString();
                Coursectr.text =
                    courseObjectList[index].name.capitalize.toString();

                validateCourse(Coursectr.text);
              },
              title: Text(
                courseObjectList[index].name.capitalize.toString(),
                style: TextStyle(fontFamily: fontRegular, fontSize: 13.5.sp),
              ),
            );
          },
        ),
      );
    });
  }

  RxString uploadImageId = ''.obs;

  void getImageApi(context) async {
    var loadingIndicator = LoadingProgressDialog();
    loadingIndicator.show(context, '');

    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.multiPartPost({
        "file": uploadImageFile.value!.path.split('/').last,
      }, ApiUrl.uploadImage,
          multiPart: uploadImageFile.value != null
              ? http.MultipartFile(
                  'file',
                  uploadImageFile.value!.readAsBytes().asStream(),
                  uploadImageFile.value!.lengthSync(),
                  filename: uploadImageFile.value!.path.split('/').last,
                )
              : null,
          allowHeader: true);
      var responseDetail = await response.stream.toBytes();
      loadingIndicator.hide(context);

      var result = String.fromCharCodes(responseDetail);
      var json = jsonDecode(result);
      var responseData = UploadImageModel.fromJson(json);
      if (response.statusCode == 200) {
        logcat("responseData", jsonEncode(responseData));
        if (responseData.status == "True") {
          logcat("UPLOAD_IMAGE_ID", responseData.data.id.toString());
          uploadImageId.value = responseData.data.id.toString();
        } else {
          showDialogForScreen(context, responseData.message.toString(),
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, responseData.message.toString(),
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context, Connection.servererror, callback: () {});
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
        title: ScreenTitle.addCourse,
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }

  Rx<File?> uploadImageFile = null.obs;

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
          uploadImageFile = File(file.path).obs;
          Idctr.text = file.name;
          validateId(Idctr.text);
          getImageApi(context);
        }
      }
    });

    update();
  }

  actionClickUploadImageFromCamera(context, {bool? isCamera}) async {
    await ImagePicker()
        .pickImage(
            //source: ImageSource.gallery,
            source: isCamera == true ? ImageSource.camera : ImageSource.gallery,
            maxWidth: 1080,
            maxHeight: 1080,
            imageQuality: 100)
        .then((file) async {
      if (file != null) {
        //Cropping the image
        CroppedFile? croppedFile = await ImageCropper().cropImage(
            sourcePath: file.path,
            maxWidth: 1080,
            maxHeight: 1080,
            cropStyle: CropStyle.rectangle,
            aspectRatioPresets: Platform.isAndroid
                ? [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
                  ]
                : [
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio5x3,
                    CropAspectRatioPreset.ratio5x4,
                    CropAspectRatioPreset.ratio7x5,
                    CropAspectRatioPreset.ratio16x9
                  ],
            uiSettings: [
              AndroidUiSettings(
                  toolbarTitle: 'Crop Image',
                  cropGridColor: primaryColor,
                  toolbarColor: primaryColor,
                  statusBarColor: primaryColor,
                  toolbarWidgetColor: white,
                  activeControlsWidgetColor: primaryColor,
                  initAspectRatio: CropAspectRatioPreset.original,
                  lockAspectRatio: false),
              IOSUiSettings(
                title: 'Crop Image',
                cancelButtonTitle: 'Cancel',
                doneButtonTitle: 'Done',
                aspectRatioLockEnabled: false,
              ),
            ],
            aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
        if (file != null) {
          uploadImageFile = File(file.path).obs;
          Idctr.text = file.name;
          validateId(Idctr.text);
          getImageApi(context);
        }

        // if (croppedFile != null) {
        //   uploadImageFile = File(croppedFile.path).obs;
        //   profilePic.value = croppedFile.path;
        //   update();
        // }
      }
    });

    update();
  }
}
