import 'dart:convert';
import 'package:booking_app/Config/apicall_constant.dart';
import 'package:booking_app/Models/ExpertModel.dart';
import 'package:booking_app/api_handle/Repository.dart';
import 'package:booking_app/controllers/home_screen_controller.dart';
import 'package:booking_app/controllers/internet_controller.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:get/get.dart';

class StaffController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  RxBool isExpertTypeApiList = false.obs;
  RxList<ExpertList> expertObjectList = <ExpertList>[].obs;
  RxString expertId = "".obs;
  RxBool isLoading = false.obs;

  RxString profilePic = "".obs;

  RxString message = "".obs;
  Rx<ScreenState> state = ScreenState.apiLoading.obs;
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
