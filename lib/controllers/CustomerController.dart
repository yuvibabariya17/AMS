import 'dart:convert';
import 'package:booking_app/Models/CustomerListModel.dart';
import 'package:booking_app/Models/DeleteSuccessModel.dart';
import 'package:booking_app/dialogs/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Config/apicall_constant.dart';
import '../api_handle/Repository.dart';
import '../core/constants/strings.dart';
import '../core/utils/log.dart';
import '../dialogs/dialogs.dart';
import 'internet_controller.dart';

enum ScreenState { apiLoading, apiError, apiSuccess, noNetwork, noDataFound }

class CustomerController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  late FocusNode searchNode;
  late TextEditingController searchCtr;

  RxBool isCustomerTypeApiList = false.obs;
  RxList<ListofCustomer> customerObjectList = <ListofCustomer>[].obs;
  RxString customerId = "".obs;

  Rx<ScreenState> state = ScreenState.apiLoading.obs;
  RxString message = "".obs;
  RxList memberList = [].obs;

  // List<ServiceList> serviceObjectList = []; // Your data source
  TextEditingController searchController = TextEditingController();
  List<ListofCustomer> filteredCustomerObjectList = [];
  @override
  void onInit() {
    searchNode = FocusNode();
    searchCtr = TextEditingController();
    super.onInit();
  }

  launchPhoneCall(String phoneNumber) async {
    try {
      String url = 'tel:$phoneNumber'; // Add "+91" to the phone number
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching phone call: $e');
    }
  }

  launchWhatsappCall(String phoneNumber) async {
    try {
      String url = 'tel:$phoneNumber'; // Add "+91" to the phone number
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching phone call: $e');
    }
  }

  void lanchEmail(String email) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      throw 'Could not launch $_emailLaunchUri';
    }
  }

  void getCustomerList(context, bool isFirst) async {
    var loadingIndicator = LoadingProgressDialogs();
    if (isFirst == true) {
      logcat("STEP_1", "STEP");
      state.value = ScreenState.apiLoading;
    } else {
      logcat("STEP_2", "STEP");
      loadingIndicator.show(context, "message");
    }
    isCustomerTypeApiList.value = true;
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
      var response =
          await Repository.post({}, ApiUrl.customerList, allowHeader: true);
      if (isFirst == false) {
        loadingIndicator.hide(context);
      }
      isCustomerTypeApiList.value = false;
      var responseData = jsonDecode(response.body);
      logcat(" CUSTOMER RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = CustomerListModel.fromJson(responseData);
        if (data.status == 1) {
          state.value = ScreenState.apiSuccess;
          customerObjectList.clear();
          customerObjectList.addAll(data.data);
          logcat("CUSTOMER RESPONSE", jsonEncode(customerObjectList));
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isCustomerTypeApiList.value = false;
    }
  }

  void deleteCustomerList(context, String itemId) async {
    state.value = ScreenState.apiLoading;
    isCustomerTypeApiList.value = true;
    try {
      if (networkManager.connectionType == 0) {
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.delete(
          {}, '${ApiUrl.deleteCustomer}/$itemId',
          allowHeader: true);
      isCustomerTypeApiList.value = false;
      var responseData = jsonDecode(response.body);
      logcat(" SERVICE RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = DeleteSuccessModel.fromJson(responseData);
        if (data.status == 1) {
          updateLocalList(itemId);
          state.value = ScreenState.apiSuccess;
          showDialogForScreen(context, responseData['message'],
              callback: () {});

          logcat("SERVICE RESPONSE", jsonEncode(customerObjectList));
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isCustomerTypeApiList.value = false;
    }
  }

  void updateLocalList(String deletedItemId) {
    int deletedItemIndex =
        customerObjectList.indexWhere((item) => item.id == deletedItemId);

    if (deletedItemIndex != -1) {
      // Remove the deleted item from the list
      customerObjectList.removeAt(deletedItemIndex);
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
        title: "Customer",
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
