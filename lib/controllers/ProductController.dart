import 'dart:convert';
import 'package:booking_app/Models/DeleteSuccessModel.dart';
import 'package:booking_app/Models/ProductListModel.dart';
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

class ProductController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  late FocusNode searchNode;
  late TextEditingController searchCtr;

  RxBool isProductTypeApiList = false.obs;
  RxList<ListofProduct> productObjectList = <ListofProduct>[].obs;
  RxString customerId = "".obs;

  Rx<ScreenState> state = ScreenState.apiLoading.obs;
  RxString message = "".obs;
  RxList memberList = [].obs;

  // List<ServiceList> serviceObjectList = []; // Your data source
  TextEditingController searchController = TextEditingController();
  List<ListofProduct> filteredProductObjectList = [];
  @override
  void onInit() {
    searchNode = FocusNode();
    searchCtr = TextEditingController();
    super.onInit();
  }

  void getProductList(context, bool isFirst) async {
    var loadingIndicator = LoadingProgressDialogs();
    if (isFirst == true) {
      logcat("STEP_1", "STEP");
      state.value = ScreenState.apiLoading;
    } else {
      logcat("STEP_2", "STEP");
      loadingIndicator.show(context, "message");
    }
    isProductTypeApiList.value = true;
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
          await Repository.post({}, ApiUrl.productList, allowHeader: true);
      if (isFirst == false) {
        loadingIndicator.hide(context);
      }
      isProductTypeApiList.value = false;
      var responseData = jsonDecode(response.body);
      logcat(" PRODUCT RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = ProductListModel.fromJson(responseData);
        if (data.status == 1) {
          state.value = ScreenState.apiSuccess;
          productObjectList.clear();
          productObjectList.addAll(data.data);
          logcat("PRODUCT RESPONSE", jsonEncode(productObjectList));
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isProductTypeApiList.value = false;
    }
  }

  void deleteProductList(context, String itemId) async {
    state.value = ScreenState.apiLoading;
    isProductTypeApiList.value = true;
    try {
      if (networkManager.connectionType == 0) {
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.delete(
          {}, '${ApiUrl.deleteProduct}/$itemId',
          allowHeader: true);
      isProductTypeApiList.value = false;
      var responseData = jsonDecode(response.body);
      logcat(" DELETE RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = DeleteSuccessModel.fromJson(responseData);
        if (data.status == 1) {
          updateLocalList(itemId);
          state.value = ScreenState.apiSuccess;
          // showDialogForScreen(context, responseData['message'],
          //     callback: () {});

          logcat("DELETE RESPONSE", jsonEncode(productObjectList));
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isProductTypeApiList.value = false;
    }
  }

  void updateLocalList(String deletedItemId) {
    int deletedItemIndex =
        productObjectList.indexWhere((item) => item.id == deletedItemId);

    if (deletedItemIndex != -1) {
      // Remove the deleted item from the list
      productObjectList.removeAt(deletedItemIndex);
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
        title: "Product",
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
