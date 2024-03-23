import 'dart:convert';

import 'package:booking_app/Config/apicall_constant.dart';
import 'package:booking_app/Models/AppointmentListModel.dart';
import 'package:booking_app/Models/CustomerListModel.dart';
import 'package:booking_app/Models/sign_in_form_validation.dart';
import 'package:booking_app/api_handle/Repository.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../Models/notification_model.dart';
import '../Models/notification_Static.dart';
import 'internet_controller.dart';

enum ScreenState { apiLoading, apiError, apiSuccess, noNetwork, noDataFound }

class AppointmentScreenController extends GetxController {
  List<NotificationItem> staticData = notificationItems;
  late TabController tabController;
  RxInt currentPage = 0.obs;
  bool isOnline = true;
  RxBool isFromUpcoming = true.obs;
  late FocusNode CustomerNode;
  late TextEditingController Customerctr;

  changeIndex(int index) async {
    currentPage.value = index;
    update();
  }

  @override
  void onInit() {
    CustomerNode = FocusNode();
    Customerctr = TextEditingController();

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

  RxString apiFormattedDate = "".obs;

  var CustomerModel = ValidationModel(null, null, isValidate: false).obs;

  RxBool isFormInvalidate = false.obs;

  RxBool isCustomerTypeApiList = false.obs;
  RxList<ListofCustomer> customerObjectList = <ListofCustomer>[].obs;
  RxString customerId = "".obs;
  final formKey = GlobalKey<FormState>();

  void getCustomerList(context) async {
    isCustomerTypeApiList.value = true;
    try {
      if (networkManager.connectionType == 0) {
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response =
          await Repository.post({}, ApiUrl.customerList, allowHeader: true);
      isCustomerTypeApiList.value = false;
      var responseData = jsonDecode(response.body);
      logcat("CUSTOMER LIST", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = CustomerListModel.fromJson(responseData);
        if (data.status == 1) {
          customerObjectList.clear();
          customerObjectList.addAll(data.data);
          logcat("CUSTOMER LIST", jsonEncode(customerObjectList));
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

  Widget setCustomerList() {
    return Obx(() {
      if (isCustomerTypeApiList.value == true)
        return setDropDownContent([].obs, Text("Loading"),
            isApiIsLoading: isCustomerTypeApiList.value);

      return setDropDownTestContent(
        customerObjectList,
        ListView.builder(
          shrinkWrap: true,
          itemCount: customerObjectList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              dense: true,
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
              horizontalTitleGap: null,
              minLeadingWidth: 5,
              onTap: () {
                Get.back();
                logcat("SETCUSTOMERLIST", "CUSTOMER");
                customerId.value = customerObjectList[index].id.toString();
                Customerctr.text =
                    customerObjectList[index].name.capitalize.toString();
                validateCustomer(Customerctr.text);
              },
              title: Text(
                customerObjectList[index].name.capitalize.toString(),
                style: TextStyle(
                    fontFamily: fontRegular,
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 13.5.sp
                        : 11.sp,
                    color: isDarkMode() ? white : black),
              ),
            );
          },
        ),
      );
    });
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

  void validateCustomer(String? val) {
    CustomerModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Customer";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void enableSignUpButton() {
    if (CustomerModel.value.isValidate == false) {
      logcat("STEP", '1');
      isFormInvalidate.value = false;
    }
    //  else if (ServicesModel.value.isValidate == false) {
    //   logcat("STEP", '2');
    //   isFormInvalidate.value = false;
    // }
    else {
      logcat("STEP", '11');
      isFormInvalidate.value = true;
    }
  }

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
