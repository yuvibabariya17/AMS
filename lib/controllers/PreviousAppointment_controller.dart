import 'dart:convert';
import 'package:booking_app/Config/apicall_constant.dart';
import 'package:booking_app/Models/AppointmentListModel.dart';
import 'package:booking_app/Models/DeleteSuccessModel.dart';
import 'package:booking_app/api_handle/Repository.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:booking_app/preference/UserPreference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/notification_model.dart';
import '../Models/notification_Static.dart';
import 'internet_controller.dart';

enum ScreenState { apiLoading, apiError, apiSuccess, noNetwork, noDataFound }

class PreviousAppointmentController extends GetxController {
  List<NotificationItem> staticData = notificationItems;
  late TabController tabController;
  RxInt currentPage = 1.obs;
  bool isOnline = true;

  changeIndex(int index) async {
    currentPage.value = index;
    update();
  }

  final InternetController networkManager = Get.find<InternetController>();

  RxBool isAppointmentApiList = false.obs;
  RxList<ListofAppointment> appointmentObjectList = <ListofAppointment>[].obs;
  RxString appointmentId = "".obs;
  RxBool isLoading = false.obs;

  Rx<ScreenState> state = ScreenState.apiLoading.obs;
  RxString message = "".obs;
  RxList memberList = [].obs;
  RxInt totalPages = 0.obs;

  void getAppointmentList(context,
      {String? selectedDateString,
      String? customerId,
      bool? isFromFilter,
      String? serviceId}) async {
    state.value = ScreenState.apiLoading;

    try {
      if (networkManager.connectionType == 0) {
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }

      var retrievedObject = await UserPreferences().getSignInInfo();

      logcat("PARAMETER", {
        "pagination": {
          "pageNo": currentPage.value,
          "recordPerPage": 20,
          "sortBy": "name",
          "sortDirection": "asc"
        },
        "search": {
          //"startAt": "2024-03-23"
          //"endAt": "2024-03-15"
          "vendor_id": retrievedObject!.id.toString().trim(),
          "customer_id": customerId ?? '',
          "vendor_service_id": serviceId ?? '',
          //"appointment_slot_id": "6500476bf3b6019b811a1e22"
        }
      });
      DateTime today = DateTime.now();
      DateTime lastWeekStart = today.subtract(Duration(days: 7));
      DateTime lastWeekEnd = today.subtract(Duration(days: 1));

      var response = await Repository.post({
        "pagination": {
          "pageNo": currentPage.value,
          "recordPerPage": 20,
          "sortBy": "name",
          "sortDirection": "asc"
        },
        "search": {
          //"startAt": "2024-03-23"
          //"endAt": "2024-03-15"
          "vendor_id": retrievedObject.id.toString().trim(),
          "customer_id": customerId ?? '',
          "vendor_service_id": serviceId ?? '',
          //"appointment_slot_id": "6500476bf3b6019b811a1e22"
        }
      }, ApiUrl.appointmentList, allowHeader: true);
      isAppointmentApiList.value = false;
      var responseData = jsonDecode(response.body);
      logcat("APPOINTMENT LIST", jsonEncode(responseData));

      if (response.statusCode == 200) {
        if (responseData['status'] == 1) {
          state.value = ScreenState.apiSuccess;
          var data = AppointmentModel.fromJson(responseData);
          totalPages.value = data.totalPages;
          if (isFromFilter == true) {
            appointmentObjectList.clear();
            appointmentObjectList.addAll(data.data);
          } else {
            var today = DateTime.now();
            var twoDaysAgo = today.subtract(Duration(days: 3));

            logcat("TWODAYSAGO", twoDaysAgo.toString());

            data.data.retainWhere((appointment) =>
                appointment.dateOfAppointment.isAfter(lastWeekStart) &&
                appointment.dateOfAppointment.isBefore(lastWeekEnd));
            data.data.sort(
                (a, b) => a.dateOfAppointment.compareTo(b.dateOfAppointment));

            appointmentObjectList.clear();
            appointmentObjectList.addAll(data.data);
          }
          update();
          logcat("APPOINTMENT LIST", jsonEncode(appointmentObjectList));
          if (currentPage.value < totalPages.value) {
            currentPage.value++;
            getAppointmentList(
              context,
            );
          }
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isAppointmentApiList.value = false;
    }
  }

  void deleteAppointment(context, String itemId) async {
    state.value = ScreenState.apiLoading;
    isAppointmentApiList.value = true;
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
      isAppointmentApiList.value = false;
      var responseData = jsonDecode(response.body);
      logcat(" APPOINTMENT RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = DeleteSuccessModel.fromJson(responseData);
        if (data.status == 1) {
          updateLocalList(itemId);
          state.value = ScreenState.apiSuccess;
          showDialogForScreen(context, responseData['message'],
              callback: () {});

          logcat("APPOINTMENT RESPONSE", jsonEncode(appointmentObjectList));
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isAppointmentApiList.value = false;
    }
  }

  void updateLocalList(String deletedItemId) {
    int deletedItemIndex =
        appointmentObjectList.indexWhere((item) => item.id == deletedItemId);

    if (deletedItemIndex != -1) {
      // Remove the deleted item from the list
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
        title: "Previous Appointment",
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
