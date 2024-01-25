import 'dart:convert';
import 'package:booking_app/Config/apicall_constant.dart';
import 'package:booking_app/Models/AppointmentListModel.dart';
import 'package:booking_app/api_handle/Repository.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/notification_model.dart';
import '../Models/product.dart';
import 'internet_controller.dart';

enum ScreenState { apiLoading, apiError, apiSuccess, noNetwork, noDataFound }

class AppointmentScreenController extends GetxController {
  List<ProductItem> staticData = notificationItems;
  late TabController tabController;
  RxInt currentPage = 0.obs;
  bool isOnline = true;
  

  changeIndex(int index) async {
    currentPage.value = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }




  final InternetController networkManager = Get.find<InternetController>();

  RxBool isExpertTypeApiList = false.obs;
  RxList<ListofAppointment> expertObjectList = <ListofAppointment>[].obs;
  RxString expertId = "".obs;
  RxBool isLoading = false.obs;

  Rx<ScreenState> state = ScreenState.apiLoading.obs;
  RxString message = "".obs;
  RxList memberList = [].obs;

  List<ListofAppointment> filteredExpertObjectList = [];

  void getAppointmentList(context) async {
    state.value = ScreenState.apiLoading;
    // isExpertTypeApiList.value = true;
    try {
      if (networkManager.connectionType == 0) {
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response =
          await Repository.post({}, ApiUrl.expertList, allowHeader: true);
      isExpertTypeApiList.value = false;
      var responseData = jsonDecode(response.body);
      logcat("EXPERTRESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = AppointmentModel.fromJson(responseData);
        if (data.status == 1) {
          state.value = ScreenState.apiSuccess;
          expertObjectList.clear();
          expertObjectList.addAll(data.data);
          logcat("EXPERT RESPONSE", jsonEncode(expertObjectList));

          
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isExpertTypeApiList.value = false;
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
        title: ScreenTitle.expert,
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
