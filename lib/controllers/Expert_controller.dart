import 'dart:convert';
import 'package:booking_app/Models/DeleteSuccessModel.dart';
import 'package:get/get.dart';
import '../Config/apicall_constant.dart';
import '../Models/ExpertModel.dart';
import '../api_handle/Repository.dart';
import '../core/constants/strings.dart';
import '../core/utils/log.dart';
import '../dialogs/dialogs.dart';
import 'internet_controller.dart';

enum ScreenState { apiLoading, apiError, apiSuccess, noNetwork, noDataFound }

class expertcontroller extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  RxBool isExpertTypeApiList = false.obs;
  RxList<ExpertList> expertObjectList = <ExpertList>[].obs;
  RxString expertId = "".obs;
  RxBool isLoading = false.obs;

  Rx<ScreenState> state = ScreenState.apiLoading.obs;
  RxString message = "".obs;
  RxList memberList = [].obs;

  List<ExpertList> filteredExpertObjectList = [];

  void getExpertList(context) async {
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
        var data = ExpertModel.fromJson(responseData);
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

  void deleteExpertList(context, String itemId) async {
    state.value = ScreenState.apiLoading;
    isExpertTypeApiList.value = true;
    try {
      if (networkManager.connectionType == 0) {
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.delete(
          {}, '${ApiUrl.deleteExpert}/$itemId',
          allowHeader: true);
      isExpertTypeApiList.value = false;
      var responseData = jsonDecode(response.body);
      logcat(" SERVICE RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = DeleteSuccessModel.fromJson(responseData);
        if (data.status == 1) {
          updateLocalList(itemId);
          state.value = ScreenState.apiSuccess;
          showDialogForScreen(context, responseData['message'],
              callback: () {});

          logcat("SERVICE RESPONSE", jsonEncode(expertObjectList));
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

  void updateLocalList(String deletedItemId) {
    int deletedItemIndex =
        expertObjectList.indexWhere((item) => item.id == deletedItemId);

    if (deletedItemIndex != -1) {
      // Remove the deleted item from the list
      expertObjectList.removeAt(deletedItemIndex);
    }
  }

  // Future<void> fetchUpdatedList() async {
  //   try {
  //     // Make an API call to get the updated list
  //     var updatedResponse =
  //         await Repository.get({}, ApiUrl.expertList, allowHeader: true);

  //     // Parse the response and update the local list
  //     var updatedData = ExpertModel.fromJson(jsonDecode(updatedResponse.body));
  //     if (updatedData.status == 1) {
  //       expertObjectList.clear();
  //       expertObjectList.addAll(updatedData.data);
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
        title: ScreenTitle.expert,
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }
}
