import 'dart:convert';
import 'package:booking_app/Models/DeleteSuccessModel.dart';
import 'package:booking_app/Models/StudentCourseListModel.dart';
import 'package:booking_app/dialogs/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Config/apicall_constant.dart';
import '../api_handle/Repository.dart';
import '../core/constants/strings.dart';
import '../core/utils/log.dart';
import '../dialogs/dialogs.dart';
import 'internet_controller.dart';

enum ScreenState { apiLoading, apiError, apiSuccess, noNetwork, noDataFound }

class StudentCourseController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  late FocusNode searchNode;
  late TextEditingController searchCtr;

  RxBool isStudentList = false.obs;
  RxList<ListofStudentCourse> studentObjectList = <ListofStudentCourse>[].obs;
  RxString studentId = "".obs;

  Rx<ScreenState> state = ScreenState.apiLoading.obs;
  RxString message = "".obs;
  RxList memberList = [].obs;

  // List<ServiceList> serviceObjectList = []; // Your data source
  TextEditingController searchController = TextEditingController();
  List<ListofStudentCourse> filteredStudentObjectList = [];
  @override
  void onInit() {
    searchNode = FocusNode();
    searchCtr = TextEditingController();
    super.onInit();
  }

  void getStudentCourseList(context, bool isFirst) async {
    var loadingIndicator = LoadingProgressDialogs();
    if (isFirst == true) {
      logcat("STEP_1", "STEP");
      state.value = ScreenState.apiLoading;
    } else {
      logcat("STEP_2", "STEP");
      loadingIndicator.show(context, "message");
    }
    isStudentList.value = true;
    try {
      if (networkManager.connectionType == 0) {
        if (isFirst == false) {
          loadingIndicator.hide(context);
        }
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.post({}, ApiUrl.studentCourseList,
          allowHeader: true);
      if (isFirst == false) {
        loadingIndicator.hide(context);
      }
      isStudentList.value = false;
      var responseData = jsonDecode(response.body);
      logcat(" COURSELIST RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = StudentCourseListModel.fromJson(responseData);
        if (data.status == 1) {
          state.value = ScreenState.apiSuccess;
          studentObjectList.clear();
          studentObjectList.addAll(data.data);
          logcat("COURSELIST RESPONSE", jsonEncode(studentObjectList));
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isStudentList.value = false;
    }
  }

  void deleteStudentCourseList(context, String studentcourseList) async {
    state.value = ScreenState.apiLoading;
    isStudentList.value = true;
    try {
      if (networkManager.connectionType == 0) {
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.delete(
          {}, '${ApiUrl.deleteStudentCourseList}/$studentcourseList',
          allowHeader: true);
      isStudentList.value = false;
      var responseData = jsonDecode(response.body);
      logcat(" COURSELIST RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = DeleteSuccessModel.fromJson(responseData);
        if (data.status == 1) {
          updateLocalList(studentcourseList);
          state.value = ScreenState.apiSuccess;
          // showDialogForScreen(context, responseData['message'],
          //     callback: () {});

          logcat("COURSELIST RESPONSE", jsonEncode(studentObjectList));
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isStudentList.value = false;
    }
  }

  void updateLocalList(String deletedItemId) {
    int deletedItemIndex =
        studentObjectList.indexWhere((item) => item.id == deletedItemId);

    if (deletedItemIndex != -1) {
      // Remove the deleted item from the list
      studentObjectList.removeAt(deletedItemIndex);
    }
  }

  // Future<void> fetchUpdatedList() async {
  //   try {
  //     // Make an API call to get the updated list
  //     var updatedResponse =
  //         await Repository.get({}, ApiUrl.ServiceList, allowHeader: true);

  //     // Parse the response and update the local list
  //     var updatedData = ServiceModel.fromJson(jsonDecode(updatedResponse.body));
  //     if (updatedData.status == 1) {
  //       serviceObjectList.clear();
  //       serviceObjectList.addAll(updatedData.data);
  //     }
  //   } catch (e) {
  //     // Handle errors if needed
  //     logcat('Error fetching updated list', e);
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
        title: ScreenTitle.service,
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
