import 'dart:convert';
import 'dart:io';
import 'package:booking_app/Config/apicall_constant.dart';
import 'package:booking_app/Models/CourseModel.dart';
import 'package:booking_app/Models/StudentModel.dart';
import 'package:booking_app/Models/UploadImageModel.dart';
import 'package:booking_app/Models/sign_in_form_validation.dart';
import 'package:booking_app/api_handle/Repository.dart';
import 'package:booking_app/controllers/home_screen_controller.dart';
import 'package:booking_app/controllers/internet_controller.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:booking_app/dialogs/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class AddStudentCourseController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  late FocusNode studentNode,
      courseNode,
      emailNode,
      notesNode,
      imageNode,
      startNode,
      feesNode;

  Rx<ScreenState> state = ScreenState.apiLoading.obs;

  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  late TextEditingController studentctr,
      coursectr,
      emailctr,
      notesctr,
      imgctr,
      Feesctr,
      startDatectr;
  // endTimectr

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    studentNode = FocusNode();
    imageNode = FocusNode();
    courseNode = FocusNode();
    emailNode = FocusNode();
    notesNode = FocusNode();
    feesNode = FocusNode();
    startNode = FocusNode();

    studentctr = TextEditingController();
    imgctr = TextEditingController();
    coursectr = TextEditingController();
    emailctr = TextEditingController();
    notesctr = TextEditingController();
    Feesctr = TextEditingController();
    startDatectr = TextEditingController();
    // endTimectr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  void updateDate(date) {
    startDatectr.text = date;
    update();
  }

  RxBool isFormInvalidate = false.obs;

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var StudentNameModel = ValidationModel(null, null, isValidate: false).obs;
  var ImageModel = ValidationModel(null, null, isValidate: false).obs;
  var FeesModel = ValidationModel(null, null, isValidate: false).obs;
  var CourseModel = ValidationModel(null, null, isValidate: false).obs;
  var NotesModel = ValidationModel(null, null, isValidate: false).obs;
  var StartModel = ValidationModel(null, null, isValidate: false).obs;

  void enableSignUpButton() {
    if (StudentNameModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (ImageModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (FeesModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (CourseModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (NotesModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (StartModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else {
      isFormInvalidate.value = true;
    }
  }

  void validateStudent(String? val) {
    StudentNameModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Name";
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

  void validateFees(String? val) {
    FeesModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Address";
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
      if (val != null && val.isEmpty) {
        model!.error = "Enter Email";
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
      if (val != null && val.isEmpty) {
        model!.error = "Enter Contact Number";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateStartDate(String? val) {
    StartModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Date";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  RxBool isStudentTypeList = false.obs;
  RxList<StudentList> studentObjectList = <StudentList>[].obs;
  RxString studentId = "".obs;

  void getStudentList(context) async {
    isStudentTypeList.value = true;
    try {
      if (networkManager.connectionType == 0) {
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response =
          await Repository.post({}, ApiUrl.studentList, allowHeader: true);
      isStudentTypeList.value = false;
      var responseData = jsonDecode(response.body);
      logcat("RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = StudentModel.fromJson(responseData);
        if (data.status == 1) {
          studentObjectList.clear();
          studentObjectList.addAll(data.data);
          logcat("RESPONSE", jsonEncode(studentObjectList));
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isStudentTypeList.value = false;
    }
  }

  Widget setStudentList() {
    return Obx(() {
      if (isStudentTypeList.value == true)
        return setDropDownContent([].obs, Text("Loading"),
            isApiIsLoading: isStudentTypeList.value);

      return setDropDownTestContent(
        studentObjectList,
        ListView.builder(
          shrinkWrap: true,
          itemCount: studentObjectList.length,
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
                studentId.value = studentObjectList[index].id.toString();
                studentctr.text =
                    studentObjectList[index].name.capitalize.toString();

                validateStudent(studentctr.text);
              },
              title: Text(
                studentObjectList[index].name.toString(),
                style: TextStyle(
                    fontFamily: fontRegular,
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 13.5.sp
                        : 11.sp,
                    color: isDarkMode() ? white : black),
              ),
            );
          },
        ),
      );
    });
  }

  RxBool isStudentCourseTypeList = false.obs;
  RxList<ListofCourse> studentCourseObjectList = <ListofCourse>[].obs;
  RxString studentCourseId = "".obs;

  void getCourseList(context) async {
    state.value = ScreenState.apiLoading;
    isStudentCourseTypeList.value = true;
    // try {
    if (networkManager.connectionType == 0) {
      showDialogForScreen(context, Connection.noConnection, callback: () {
        Get.back();
      });
      return;
    }
    var response =
        await Repository.post({}, ApiUrl.courselist, allowHeader: true);
    isStudentCourseTypeList.value = false;
    var responseData = jsonDecode(response.body);
    logcat(" COURSE LIST", jsonEncode(responseData));

    if (response.statusCode == 200) {
      var data = CourseListModel.fromJson(responseData);
      if (data.status == 1) {
        state.value = ScreenState.apiSuccess;
        studentCourseObjectList.clear();
        studentCourseObjectList.addAll(data.data);

        logcat("COURSE LIST", jsonEncode(studentCourseObjectList));
      } else {
        showDialogForScreen(context, responseData['message'], callback: () {});
      }
    } else {
      showDialogForScreen(context, Connection.servererror, callback: () {});
    }
    // } catch (e) {
    //   logcat('Exception', e);
    //   isCourseTypeApiList.value = false;
    // }
  }

  Widget setCourseList() {
    return Obx(() {
      if (isStudentCourseTypeList.value == true)
        return setDropDownContent([].obs, Text("Loading"),
            isApiIsLoading: isStudentCourseTypeList.value);

      return setDropDownTestContent(
        studentCourseObjectList,
        ListView.builder(
          shrinkWrap: true,
          itemCount: studentCourseObjectList.length,
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
                studentCourseId.value =
                    studentCourseObjectList[index].id.toString();
                coursectr.text =
                    studentCourseObjectList[index].name.capitalize.toString();

                validateCourse(coursectr.text);
              },
              title: Text(
                studentCourseObjectList[index].name.toString(),
                style: TextStyle(
                    fontFamily: fontRegular,
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 13.5.sp
                        : 11.sp,
                    color: isDarkMode() ? white : black),
              ),
            );
          },
        ),
      );
    });
  }

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
        title: "Student Course",
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }

  void AddStudentCourseApi(context) async {
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
      //  var retrievedObject = await UserPreferences().getSignInInfo();

      logcat("STUDENTCOURSE", {
        ({
          "student_id": studentId.value.toString(),
          "course_id": studentCourseId.value.toString(),
          "fees": Feesctr.text.toString().trim(),
          "starting_from": startDatectr.text.toString().trim(),
          "other_notes": notesctr.text.toString().trim(),
          "id_proof_url": uploadId.value.toString()
        })
      });

      var response = await Repository.post({
        "student_id": studentId.value.toString(),
        "course_id": studentCourseId.value.toString(),
        "fees": Feesctr.text.toString().trim(),
        "starting_from": startDatectr.text.toString().trim(),
        "other_notes": notesctr.text.toString().trim(),
        "id_proof_url": uploadId.value.toString()
      }, ApiUrl.addStudentCourse, allowHeader: true);
      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("ADDCOURSE", data);
      // var responseDetail = GetLoginModel.fromJson(data);
      if (response.statusCode == 200) {
        if (data['status'] == 1) {
          showDialogForScreen(context, data['message'].toString(),
              callback: () {
            Get.back(result: true);
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

  void UpdateStudentCourseApi(context, String courseId) async {
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
      //  var retrievedObject = await UserPreferences().getSignInInfo();

      logcat("STUDENTCOURSE", {
        ({
          "student_id": studentId.value.toString(),
          "course_id": studentCourseId.value.toString(),
          "fees": Feesctr.text.toString().trim(),
          "starting_from": startDatectr.text.toString().trim(),
          "other_notes": notesctr.text.toString().trim(),
          "id_proof_url": uploadId.value.toString()
        })
      });

      var response = await Repository.put({
        "student_id": studentId.value.toString(),
        "course_id": studentCourseId.value.toString(),
        "fees": Feesctr.text.toString().trim(),
        "starting_from": startDatectr.text.toString().trim(),
        "other_notes": notesctr.text.toString().trim(),
        "id_proof_url": uploadId.value.toString()
      }, '${ApiUrl.editStudentCourse}/$courseId', allowHeader: true);
      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("ADDCOURSE", data);
      // var responseDetail = GetLoginModel.fromJson(data);
      if (response.statusCode == 200) {
        if (data['status'] == 1) {
          showDialogForScreen(context, data['message'].toString(),
              callback: () {
            Get.back(result: true);
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

  actionClickUploadIdProof(context, {bool? isCamera}) async {
    await ImagePicker()
        .pickImage(
            source: isCamera == true ? ImageSource.camera : ImageSource.gallery,
            maxWidth: 1080,
            maxHeight: 1080,
            imageQuality: 100)
        .then((file) async {
      if (file != null) {
        uploadIdProof = File(file.path).obs;
        imgctr.text = file.name;
        validateImage(imgctr.text);
        getIdproofApi(context);
      }
    });

    update();
  }

  RxString uploadId = ''.obs;
  Rx<File?> uploadIdProof = null.obs;

  void getIdproofApi(context) async {
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
        "file": uploadIdProof.value!.path.split('/').last,
      }, ApiUrl.uploadImage,
          multiPart: uploadIdProof.value != null
              ? http.MultipartFile(
                  'file',
                  uploadIdProof.value!.readAsBytes().asStream(),
                  uploadIdProof.value!.lengthSync(),
                  filename: uploadIdProof.value!.path.split('/').last,
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
          uploadId.value = responseData.data.id.toString();
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
}
