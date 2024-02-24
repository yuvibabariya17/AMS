import 'dart:convert';
import 'package:booking_app/Models/DeleteSuccessModel.dart';
import 'package:booking_app/Models/VendorServiceModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Config/apicall_constant.dart';
import '../api_handle/Repository.dart';
import '../core/constants/strings.dart';
import '../core/utils/log.dart';
import '../dialogs/dialogs.dart';
import 'internet_controller.dart';

enum ScreenState { apiLoading, apiError, apiSuccess, noNetwork, noDataFound }

class serviceController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  late FocusNode searchNode;
  late TextEditingController searchCtr;

  RxBool isServiceTypeApiList = false.obs;
  RxList<VendorServiceList> serviceObjectList = <VendorServiceList>[].obs;
  RxString serviceId = "".obs;

  Rx<ScreenState> state = ScreenState.apiLoading.obs;
  RxString message = "".obs;
  RxList memberList = [].obs;

  // List<ServiceList> serviceObjectList = []; // Your data source
  TextEditingController searchController = TextEditingController();
  List<VendorServiceList> filteredServiceObjectList = [];
  @override
  void onInit() {
    searchNode = FocusNode();
    searchCtr = TextEditingController();
    super.onInit();
  }

  void getServiceList(context) async {
    state.value = ScreenState.apiLoading;
    // isServiceTypeApiList.value = true;
     try {
    if (networkManager.connectionType == 0) {
      showDialogForScreen(context, Connection.noConnection, callback: () {
        Get.back();
      });
      return;
    }
    var response =
        await Repository.post({}, ApiUrl.vendorServiceList, allowHeader: true);
    isServiceTypeApiList.value = false;
    var responseData = jsonDecode(response.body);
    logcat("SERVICERESPONSE", jsonEncode(responseData));
    if (response.statusCode == 200) {
      var data = VendorServiceModel.fromJson(responseData);
      if (data.status == 1) {
        state.value = ScreenState.apiSuccess;
        serviceObjectList.clear();
        serviceObjectList.addAll(data.data);
        logcat("SERVICE RESPONSE", jsonEncode(serviceObjectList));
      } else {
        showDialogForScreen(context, responseData['message'], callback: () {});
      }
    } else {
      showDialogForScreen(context, Connection.servererror, callback: () {});
    }
    } catch (e) {
      logcat('Exception', e);
      isServiceTypeApiList.value = false;
    }
  }

  void deleteServiceList(context, String itemId) async {
    state.value = ScreenState.apiLoading;
    isServiceTypeApiList.value = true;
    try {
      if (networkManager.connectionType == 0) {
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.delete(
          {}, '${ApiUrl.deleteVendorService}/$itemId',
          allowHeader: true);
      isServiceTypeApiList.value = false;
      var responseData = jsonDecode(response.body);
      logcat(" SERVICE RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = DeleteSuccessModel.fromJson(responseData);
        if (data.status == 1) {
          updateLocalList(itemId);
          state.value = ScreenState.apiSuccess;
          showDialogForScreen(context, responseData['message'],
              callback: () {});

          logcat("SERVICE RESPONSE", jsonEncode(serviceObjectList));
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isServiceTypeApiList.value = false;
    }
  }

  void updateLocalList(String deletedItemId) {
    int deletedItemIndex =
        serviceObjectList.indexWhere((item) => item.id == deletedItemId);

    if (deletedItemIndex != -1) {
      // Remove the deleted item from the list
      serviceObjectList.removeAt(deletedItemIndex);
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
