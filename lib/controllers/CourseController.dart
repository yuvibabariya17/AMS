import 'dart:convert';
import 'package:booking_app/Models/CourseModel.dart';
import 'package:booking_app/Models/DeleteSuccessModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Config/apicall_constant.dart';
import '../api_handle/Repository.dart';
import '../core/constants/strings.dart';
import '../core/utils/log.dart';
import '../dialogs/dialogs.dart';
import 'internet_controller.dart';

enum ScreenState { apiLoading, apiError, apiSuccess, noNetwork, noDataFound }

class CourseController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  late FocusNode searchNode;
  late TextEditingController searchCtr;

  RxBool isCourseTypeApiList = false.obs;
  RxList<ListofCourse> courseObjectList = <ListofCourse>[].obs;
  RxString courseId = "".obs;

  Rx<ScreenState> state = ScreenState.apiLoading.obs;
  RxString message = "".obs;
  RxList memberList = [].obs;

  // List<ServiceList> serviceObjectList = []; // Your data source
  TextEditingController searchController = TextEditingController();
  List<ListofCourse> filteredCourseObjectList = [];
  @override
  void onInit() {
    searchNode = FocusNode();
    searchCtr = TextEditingController();
    super.onInit();
  }

  void deleteCourseList(context, String itemId) async {
    state.value = ScreenState.apiLoading;
    isCourseTypeApiList.value = true;
    try {
      if (networkManager.connectionType == 0) {
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.delete(
          {}, '${ApiUrl.deleteCourse}/$itemId',
          allowHeader: true);
      isCourseTypeApiList.value = false;
      var responseData = jsonDecode(response.body);
      logcat(" SERVICE RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = DeleteSuccessModel.fromJson(responseData);
        if (data.status == 1) {
          updateLocalList(itemId);
          state.value = ScreenState.apiSuccess;
          showDialogForScreen(context, responseData['message'],
              callback: () {});

          logcat("SERVICE RESPONSE", jsonEncode(courseObjectList));
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isCourseTypeApiList.value = false;
    }
  }

  void updateLocalList(String deletedItemId) {
    int deletedItemIndex =
        courseObjectList.indexWhere((item) => item.id == deletedItemId);

    if (deletedItemIndex != -1) {
      // Remove the deleted item from the list
      courseObjectList.removeAt(deletedItemIndex);
    }
  }

  void getCourseList(context) async {
    state.value = ScreenState.apiLoading;
    isCourseTypeApiList.value = true;
    // try {
    if (networkManager.connectionType == 0) {
      showDialogForScreen(context, Connection.noConnection, callback: () {
        Get.back();
      });
      return;
    }
    var response =
        await Repository.post({}, ApiUrl.courselist, allowHeader: true);
    isCourseTypeApiList.value = false;
    var responseData = jsonDecode(response.body);
    logcat(" SERVICE RESPONSE", jsonEncode(responseData));

    if (response.statusCode == 200) {
      var data = CourseListModel.fromJson(responseData);
      if (data.status == 1) {
        state.value = ScreenState.apiSuccess;
        courseObjectList.clear();
        courseObjectList.addAll(data.data);
        logcat("SERVICE RESPONSE", jsonEncode(courseObjectList));
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
        title: "Course",
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
