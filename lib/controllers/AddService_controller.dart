import 'dart:convert';
import 'package:booking_app/Models/ServiceModelNew.dart';
import 'package:booking_app/preference/UserPreference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../Models/CommonModel.dart';
import '../Config/apicall_constant.dart';
import '../Models/sign_in_form_validation.dart';
import '../api_handle/Repository.dart';
import '../core/constants/strings.dart';
import '../core/themes/font_constant.dart';
import '../core/utils/log.dart';
import '../dialogs/dialogs.dart';
import '../dialogs/loading_indicator.dart';
import 'Appointment_screen_controller.dart';
import 'internet_controller.dart';

class AddserviceController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  DateTime selectedDate = DateTime.now();
  DateTime durationDate = DateTime.now();

  String approxTime = "";
  String sitingTime = "";

  void updateApproxtime(date) {
    approxtimectr.text = date;
    print("PICKED_DATE${approxtimectr.value}");
    update();
  }

  void updateSittingDuration(date) {
    durationctr.text = date;
    print("PICKED_DATE${durationctr.value}");
    update();
  }

  late FocusNode ServiceNode,
      ExpertNode,
      PriceNode,
      approxtimeNode,
      sittingNode,
      durationNode,
      intervalNode,
      daysNode;
  Rx<ScreenState> state = ScreenState.apiLoading.obs;

  late TextEditingController Servicectr,
      Expertctr,
      Pricectr,
      approxtimectr,
      sittingctr,
      durationctr,
      intervalctr,
      daysctr;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    ServiceNode = FocusNode();
    ExpertNode = FocusNode();
    PriceNode = FocusNode();
    approxtimeNode = FocusNode();
    sittingNode = FocusNode();
    durationNode = FocusNode();
    daysNode = FocusNode();
    intervalNode = FocusNode();

    Servicectr = TextEditingController();
    Expertctr = TextEditingController();
    Pricectr = TextEditingController();
    approxtimectr = TextEditingController();
    sittingctr = TextEditingController();
    durationctr = TextEditingController();
    daysctr = TextEditingController();
    intervalctr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  void initDataSet() async {
    update();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var serviceModel = ValidationModel(null, null, isValidate: false).obs;
  var ExpertModel = ValidationModel(null, null, isValidate: false).obs;
  var approxtimeModel = ValidationModel(null, null, isValidate: false).obs;
  var sittingModel = ValidationModel(null, null, isValidate: false).obs;
  var durationModel = ValidationModel(null, null, isValidate: false).obs;
  var daysModel = ValidationModel(null, null, isValidate: false).obs;
  var intervalModel = ValidationModel(null, null, isValidate: false).obs;

  var PriceModel = ValidationModel(null, null, isValidate: false).obs;

  void enableSignUpButton() {
    if (serviceModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (PriceModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (approxtimeModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (sittingModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (durationModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (daysModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (intervalModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else {
      isFormInvalidate.value = true;
    }
  }

  void validateServicename(String? val) {
    serviceModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Service Name";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateExpertname(String? val) {
    ExpertModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Expert Name";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateIntervalDuration(String? val) {
    intervalModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Sitting Days Interval";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validatePrice(String? val) {
    PriceModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Price";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateApproxtime(String? val) {
    approxtimeModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Approx Time";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateSitting(String? val) {
    sittingModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Approx Sitting";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateDuration(String? val) {
    durationModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Sitting Duration";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateDays(String? val) {
    daysModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Days";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  RxBool isFormInvalidate = false.obs;

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
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
                ServiceId.value = serviceObjectList[index].id.toString();
                Servicectr.text =
                    serviceObjectList[index].name.capitalize.toString();

                validateServicename(Servicectr.text);
              },
              title: Text(
                serviceObjectList[index].name.toString(),
                style: TextStyle(fontFamily: fontRegular, fontSize: 13.5.sp),
              ),
            );
          },
        ),
      );
    });
  }

  RxBool isServiceTypeApiList = false.obs;
  RxList<ServiceList> serviceObjectList = <ServiceList>[].obs;
  RxString ServiceId = "".obs;

  void ServiceListApi(context) async {
    isServiceTypeApiList.value = true;
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
        },
      }, ApiUrl.serviceList, allowHeader: true);
      isServiceTypeApiList.value = false;
      var responseData = jsonDecode(response.body);
      logcat("RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = ServiceModelNew.fromJson(responseData);
        if (data.status == 1) {
          serviceObjectList.clear();
          serviceObjectList.addAll(data.data);

          logcat("RESPONSE", jsonEncode(serviceObjectList));
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
        title: ScreenTitle.addService,
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }

  void UpdateVendorServiceApi(context, String serviceId) async {
    var loadingIndicator = LoadingProgressDialog();
    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      loadingIndicator.show(context, '');
      var retrievedObject = await UserPreferences().getSignInInfo();

      logcat("ADDDDD SERVICE", {
        "vendor_id": retrievedObject!.id.toString().trim(),
        "service_id": ServiceId.toString().trim(),
        "fees": int.parse(Pricectr.text),
        "oppox_time": approxTime.replaceAll(' ', '').toString().trim(),
        "oppox_setting": sittingctr.text.toString().trim(),
        "oppox_setting_duration":
            sitingTime.replaceAll(' ', '').toString().trim(),
        "oppox_setting_days_inverval": daysctr.text.toString().trim(),
      });
      var response = await Repository.put({
        "vendor_id": retrievedObject!.id.toString().trim(),
        "service_id": ServiceId.toString().trim(),
        "fees": int.parse(Pricectr.text),
        "oppox_time": approxTime.replaceAll(' ', '').toString().trim(),
        "oppox_setting": sittingctr.text.toString().trim(),
        "oppox_setting_duration":
            sitingTime.replaceAll(' ', '').toString().trim(),
        "oppox_setting_days_inverval": daysctr.text.toString().trim(),
      },  '${ApiUrl.editCourse}/$serviceId', allowHeader: true);
      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("RESPOSNE", data);
      if (response.statusCode == 200) {
        var responseDetail = CommonModel.fromJson(data);
        if (responseDetail.status == 1) {
          showDialogForScreen(context, responseDetail.message.toString(),
              callback: () {
            Get.back(result: true);
          });
        } else {
          showDialogForScreen(context, responseDetail.message.toString(),
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, data['message'].toString(),
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context, Connection.servererror, callback: () {});
      loadingIndicator.hide(context);
    }
  }

  void addServiceApi(context) async {
    var loadingIndicator = LoadingProgressDialog();
    // try {
    if (networkManager.connectionType == 0) {
      loadingIndicator.hide(context);
      showDialogForScreen(context, Connection.noConnection, callback: () {
        Get.back();
      });
      return;
    }
    loadingIndicator.show(context, '');
    var retrievedObject = await UserPreferences().getSignInInfo();
    logcat("ADDDDD SERVICE", {
      "vendor_id": retrievedObject!.id.toString().trim(),
      "service_id": ServiceId.toString().trim(),
      "fees": int.parse(Pricectr.text),
      "oppox_time": approxTime.replaceAll(' ', '').toString().trim(),
      "oppox_setting": sittingctr.text.toString().trim(),
      "oppox_setting_duration":
          sitingTime.replaceAll(' ', '').toString().trim(),
      "oppox_setting_days_inverval": daysctr.text.toString().trim(),
    });
    var response = await Repository.post({
      "vendor_id": retrievedObject.id.toString().trim(),
      "service_id": ServiceId.toString().trim(),
      "fees": int.parse(Pricectr.text),
      "oppox_time": approxTime.replaceAll(' ', '').toString().trim(),
      "oppox_setting": sittingctr.text.toString().trim(),
      "oppox_setting_duration":
          sitingTime.replaceAll(' ', '').toString().trim(),
      "oppox_setting_days_inverval": daysctr.text.toString().trim(),
    }, ApiUrl.addService, allowHeader: true);
    loadingIndicator.hide(context);
    var data = jsonDecode(response.body);
    logcat("RESPOSNE", data);
    if (response.statusCode == 200) {
      var responseDetail = CommonModel.fromJson(data);
      if (responseDetail.status == 1) {
        showDialogForScreen(context, responseDetail.message.toString(),
            callback: () {
          Get.back(result: true);
        });
      } else {
        showDialogForScreen(context, responseDetail.message.toString(),
            callback: () {});
      }
    } else {
      state.value = ScreenState.apiError;
      showDialogForScreen(context, data['message'].toString(), callback: () {});
    }
  }
  //   catch (e) {
  //     logcat("Exception", e);
  //     showDialogForScreen(context, Strings.servererror, callback: () {});
  //     loadingIndicator.hide(context);
  //   }
  // }
}
