import 'dart:convert';
import 'package:booking_app/Config/apicall_constant.dart';
import 'package:booking_app/Models/AppointmentListModel.dart';
import 'package:booking_app/Models/DeleteSuccessModel.dart';
import 'package:booking_app/api_handle/Repository.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:booking_app/dialogs/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/notification_model.dart';
import '../Models/notification_Static.dart';
import 'internet_controller.dart';

enum ScreenState { apiLoading, apiError, apiSuccess, noNetwork, noDataFound }

class UpcomingAppointmentController extends GetxController {
  List<NotificationItem> staticData = notificationItems;
  late TabController tabController;
  RxInt currentPage = 0.obs;
  bool isOnline = true;

  changeIndex(int index) async {
    currentPage.value = index;
    update();
  }

  final InternetController networkManager = Get.find<InternetController>();

  RxBool isAppointmentTypeList = false.obs;
  RxList<ListofAppointment> appointmentObjectList = <ListofAppointment>[].obs;
  RxString appointmentId = "".obs;
  RxBool isLoading = false.obs;

  Rx<ScreenState> state = ScreenState.apiLoading.obs;
  RxString message = "".obs;
  RxList memberList = [].obs;

  // List<ListofAppointment> filteredExpertObjectList = [];
  RxInt currentPags = 1.obs;
  RxInt totalPages = 0.obs;

  void getAppointmentList(context, int currentPags, bool isFirst,
      {bool? isClearList}) async {
    var loadingIndicator = LoadingProgressDialogs();
    if (isFirst == true) {
      logcat("STEP_1", "STEP");
      state.value = ScreenState.apiLoading;
    } else {
      logcat("STEP_2", "STEP");
      loadingIndicator.show(context, "message");
    }
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
      logcat("CURRENT_PAGE::", currentPags.toString());
      var response = await Repository.post({
        "pagination": {
          "pageNo": currentPags,
          "recordPerPage": 20,
          "sortBy": "name",
          "sortDirection": "asc"
        },
      }, ApiUrl.appointmentList, allowHeader: true);
      if (isFirst == false) {
        loadingIndicator.hide(context);
      }
      isAppointmentTypeList.value = false;
      var responseData = jsonDecode(response.body);
      logcat("APPOINTMENT LIST", jsonEncode(responseData));

      if (response.statusCode == 200) {
        if (responseData['status'] == 1) {
          var data = AppointmentModel.fromJson(responseData);
          var today = DateTime.now();
          totalPages.value = data.totalPages;
          data.data.retainWhere((appointment) =>
              appointment.dateOfAppointment.isAfter(today) ||
              appointment.dateOfAppointment.day == today.day);
          state.value = ScreenState.apiSuccess;
          if (isClearList == true) {
            appointmentObjectList.clear();
          }

          appointmentObjectList.addAll(data.data);
          update();
          logcat("APPOINTMENT_RESPONSE:", jsonEncode(appointmentObjectList));
          logcat("API_LENGTH", appointmentObjectList.length.toString());
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isAppointmentTypeList.value = false;
    }
  }

  void deleteAppointment(context, String itemId) async {
    state.value = ScreenState.apiLoading;
    isAppointmentTypeList.value = true;
    try {
      if (networkManager.connectionType == 0) {
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.delete(
          {}, '${ApiUrl.appointmentDelete}/$itemId',
          allowHeader: true);
      isAppointmentTypeList.value = false;
      var responseData = jsonDecode(response.body);
      logcat(" APPOINTMENT RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = DeleteSuccessModel.fromJson(responseData);
        if (data.status == 1) {
          updateLocalList(itemId);
          state.value = ScreenState.apiSuccess;
          showDialogForScreen(context, responseData['message'],
              callback: () {});
          logcat("APPOINTMENTRESPONSE", jsonEncode(appointmentObjectList));
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isAppointmentTypeList.value = false;
    }
  }

  void updateLocalList(String deletedItemId) {
    int deletedItemIndex =
        appointmentObjectList.indexWhere((item) => item.id == deletedItemId);
    if (deletedItemIndex != -1) {
      appointmentObjectList.removeAt(deletedItemIndex);
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
        title: "Appointment",
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
