import 'dart:convert';

import 'package:booking_app/Config/apicall_constant.dart';
import 'package:booking_app/Models/AppointmentListModel.dart';
import 'package:booking_app/Models/CustomerListModel.dart';
import 'package:booking_app/Models/VendorServiceModel.dart';
import 'package:booking_app/Models/sign_in_form_validation.dart';
import 'package:booking_app/api_handle/Repository.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:booking_app/preference/UserPreference.dart';
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
  late FocusNode customerNode, serviceNode, startDateNode, endDateNode;
  late TextEditingController CustomerCtr, serviceCtr, startDateCtr, endDateCtr;

  var CustomerModel = ValidationModel(null, null, isValidate: false).obs;
  var StartDateModel = ValidationModel(null, null, isValidate: false).obs;
  var EndDateModel = ValidationModel(null, null, isValidate: false).obs;
  var ServiceMpdel = ValidationModel(null, null, isValidate: false).obs;

  changeIndex(int index) async {
    currentPage.value = index;
    update();
  }

  @override
  void onInit() {
    customerNode = FocusNode();
    serviceNode = FocusNode();
    startDateNode = FocusNode();
    endDateNode = FocusNode();

    CustomerCtr = TextEditingController();
    serviceCtr = TextEditingController();
    startDateCtr = TextEditingController();
    endDateCtr = TextEditingController();

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

  RxBool isFormInvalidate = true.obs;

  RxBool isCustomerTypeApiList = false.obs;
  RxList<ListofCustomer> customerObjectList = <ListofCustomer>[].obs;
  RxString customerId = "".obs;
  final formKey = GlobalKey<FormState>();

  void updateDate(date) {
    startDateCtr.text = date;
    print("PICKED_DATE${startDateCtr.value}");
    update();
  }

  void updateEndDate(date) {
    startDateCtr.text = date;
    print("PICKED_DATE${endDateCtr.value}");
    update();
  }

  RxBool isAppointmentTypeList = false.obs;
  RxList<ListofAppointment> appointmentObjectList = <ListofAppointment>[].obs;
  RxString appointmentId = "".obs;

  void getAppointmentList(context, String? customerId) async {
    isAppointmentTypeList.value = true;
    try {
      if (networkManager.connectionType == 0) {
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }

      var retrievedObject = await UserPreferences().getSignInInfo();
      var response = await Repository.post({
        "pagination": {
          "pageNo": 1,
          "recordPerPage": 20,
          "sortBy": "name",
          "sortDirection": "asc"
        },
        "search": {
          //"startAt": "2024-03-23"
          //"endAt": "2024-03-15"
          "vendor_id": retrievedObject!.id.toString().trim(),
          "customer_id": customerId
          //"vendor_service_id": "64ffed654016bf16c7fe8a6f",
          //"appointment_slot_id": "6500476bf3b6019b811a1e22"
        }
      }, ApiUrl.appointmentList, allowHeader: true);
      isAppointmentTypeList.value = false;
      var responseData = jsonDecode(response.body);
      logcat("CUSTOMER LIST", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = AppointmentModel.fromJson(responseData);
        if (data.status == 1) {
          appointmentObjectList.clear();
          appointmentObjectList.addAll(data.data);
          logcat("APPOINTMENT_LIST", jsonEncode(appointmentObjectList));
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

  RxBool isServiceTypeApiList = false.obs;
  RxList<VendorServiceList> serviceObjectList = <VendorServiceList>[].obs;
  RxString serviceId = "".obs;

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
      var response = await Repository.post({
        "pagination": {
          "pageNo": 1,
          "recordPerPage": 20,
          "sortBy": "name",
          "sortDirection": "asc"
        }
      }, ApiUrl.vendorServiceList, allowHeader: true);
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

  Widget setServiceList() {
    return Obx(() {
      if (isServiceTypeApiList.value == true)
        return setDropDownContent([].obs, Text("Loading"),
            isApiIsLoading: isServiceTypeApiList.value);

      return setDropDownTestContent(
        serviceObjectList,
        ListView.builder(
          shrinkWrap: true,
          itemCount: serviceObjectList.length,
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
                serviceId.value = serviceObjectList[index].id.toString();
                serviceCtr.text = serviceObjectList[index]
                    .serviceInfo
                    .name
                    .capitalize
                    .toString();
                validateCustomer(CustomerCtr.text);
              },
              title: Text(
                serviceObjectList[index].serviceInfo.name.capitalize.toString(),
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
                CustomerCtr.text =
                    customerObjectList[index].name.capitalize.toString();
                validateCustomer(CustomerCtr.text);
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

    //  enableSignUpButton();
  }

  void validateService(String? val) {
    ServiceMpdel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Service";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    //  enableSignUpButton();
  }

  void validateDate(String? val) {
    StartDateModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Date";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    // enableSignUpButton();
  }

  void validateEndDate(String? val) {
    EndDateModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Date";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    // enableSignUpButton();
  }

  void enableSignUpButton() {
    if (CustomerModel.value.isValidate == false) {
      logcat("STEP", '1');
      isFormInvalidate.value = false;
    } else if (StartDateModel.value.isValidate == false) {
      logcat("STEP", '2');
      isFormInvalidate.value = false;
    } else if (EndDateModel.value.isValidate == false) {
      logcat("STEP", '2');
      isFormInvalidate.value = false;
    } else {
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
