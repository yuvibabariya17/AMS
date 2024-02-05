import 'dart:convert';
import 'package:booking_app/Models/ServiceCategoryModel.dart';
import 'package:booking_app/Models/ServiceModel.dart';
import 'package:booking_app/Models/SubCategoryModel.dart';
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
      daysNode,
      categoryNode,
      subCategoryNode;
  Rx<ScreenState> state = ScreenState.apiLoading.obs;

  late TextEditingController Servicectr,
      Expertctr,
      Pricectr,
      approxtimectr,
      sittingctr,
      durationctr,
      intervalctr,
      daysctr,
      categoryctr,
      subCategoryctr;
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
    categoryNode = FocusNode();
    subCategoryNode = FocusNode();

    Servicectr = TextEditingController();
    Expertctr = TextEditingController();
    Pricectr = TextEditingController();
    approxtimectr = TextEditingController();
    sittingctr = TextEditingController();
    durationctr = TextEditingController();
    daysctr = TextEditingController();
    intervalctr = TextEditingController();
    categoryctr = TextEditingController();
    subCategoryctr = TextEditingController();

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
  var categoryModel = ValidationModel(null, null, isValidate: false).obs;
  var subCategoryModel = ValidationModel(null, null, isValidate: false).obs;

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
    } else if (categoryModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (subCategoryModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else {
      isFormInvalidate.value = true;
    }
  }

  void validateCategory(String? val) {
    categoryModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Category";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateSubCategory(String? val) {
    subCategoryModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Sub Category";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateServicename(String? val) {
    serviceModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Service";
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

  // SERVICE CATEGORY

  RxBool isServiceCategoryList = false.obs;
  RxList<ServiceCategoryList> serviceCategoryList = <ServiceCategoryList>[].obs;
  RxString categoryId = "".obs;

  void getServiceCategoryList(context) async {
    isServiceCategoryList.value = true;
    try {
      if (networkManager.connectionType == 0) {
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.post({
        "search": {
          "startAt": "2023-06-06T00:00:00.704Z",
          "endAt": "2023-06-06T23:55:00.704Z"
        },
        "pagination": {
          "pageNo": 1,
          "recordPerPage": 10,
          "sortBy": "name",
          "sortDirection": 1
        }
      }, ApiUrl.serviceCategoryList, allowHeader: true);
      isServiceCategoryList.value = false;
      var responseData = jsonDecode(response.body);
      logcat("CATEGORY LIST", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = ServiceCategoryModel.fromJson(responseData);
        if (data.status == 1) {
          serviceCategoryList.clear();
          serviceCategoryList.addAll(data.data);

          logcat("CATEGORY LIST", jsonEncode(serviceCategoryList));
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isServiceCategoryList.value = false;
    }
  }

  Widget setServiceCategoryList() {
    return Obx(() {
      if (isServiceCategoryList.value == true)
        return setDropDownContent([].obs, Text("Loading"),
            isApiIsLoading: isServiceCategoryList.value);

      return setDropDownTestContent(
        serviceCategoryList,
        ListView.builder(
          shrinkWrap: true,
          itemCount: serviceCategoryList.length,
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
                logcat("CATEGORY List", "CATEGORY");
                categoryId.value = serviceCategoryList[index].name.toString();
                categoryctr.text = serviceCategoryList[index].name.toString();

                validateCategory(categoryctr.text);
              },
              title: Text(
                serviceCategoryList[index].name.toString(),
                style: TextStyle(fontFamily: fontRegular, fontSize: 13.5.sp),
              ),
            );
          },
        ),
      );
    });
  }

// SERVICE SUB CATEGORY LIST

  RxBool isSubCategoryList = false.obs;
  RxList<ServiceSubCategoryList> subcategoryList =
      <ServiceSubCategoryList>[].obs;
  RxString subCategoryId = "".obs;

  void getSubCategoryList(context, String city) async {
    isSubCategoryList.value = true;
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
        "search": {
          "startAt": "2023-06-06T00:00:00.704Z",
          "endAt": "2023-06-06T00:00:00.704Z",
          "category_id": categoryId.value.toString(),
        }
      }, ApiUrl.subCategoryList, allowHeader: true);
      isSubCategoryList.value = false;
      var responseData = jsonDecode(response.body);
      logcat("SUBCATEGORY LIST", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = SubCategoryModel.fromJson(responseData);
        if (data.status == 1) {
          subcategoryList.clear();
          subcategoryList.addAll(data.data);

          logcat("SUBCATEGORY LIST", jsonEncode(subcategoryList));
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isSubCategoryList.value = false;
    }
  }

  Widget setSubCategoryList() {
    return Obx(() {
      if (isSubCategoryList.value == true)
        return setDropDownContent([].obs, Text("Loading"),
            isApiIsLoading: isSubCategoryList.value);

      return setDropDownTestContent(
        subcategoryList,
        ListView.builder(
          shrinkWrap: true,
          itemCount: subcategoryList.length,
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
                logcat("SUBCATEGORY List", "SUBCATEGORY");
                subCategoryId.value = subcategoryList[index].name.toString();
                subCategoryctr.text = subcategoryList[index].name.toString();

                validateSubCategory(subCategoryctr.text);
              },
              title: Text(
                subcategoryList[index].name.toString(),
                style: TextStyle(fontFamily: fontRegular, fontSize: 13.5.sp),
              ),
            );
          },
        ),
      );
    });
  }

  // SERVICE LIST

  RxBool isServiceTypeApiList = false.obs;
  RxList<ServiceList> serviceObjectList = <ServiceList>[].obs;
  RxString ServiceId = "".obs;

  void getServiceList(context) async {
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
        "search": {
          "startAt": "2023-06-06T00:00:00.704Z",
          "endAt": "2023-06-06T00:00:00.704Z",
          "category_id": categoryId.value.toString(),
          "sub_category_id": subCategoryId.value.toString(),
        }
      }, ApiUrl.serviceList, allowHeader: true);
      isServiceTypeApiList.value = false;
      var responseData = jsonDecode(response.body);
      logcat("SERVICE LIST", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = ServiceModel.fromJson(responseData);
        if (data.status == 1) {
          serviceObjectList.clear();
          serviceObjectList.addAll(data.data);

          logcat("SERVICE LIST", jsonEncode(serviceObjectList));
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
                logcat("Service List", "LIST");
                ServiceId.value = serviceObjectList[index].name.toString();
                Servicectr.text = serviceObjectList[index].name.toString();

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
      }, '${ApiUrl.editCourse}/$serviceId', allowHeader: true);
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

  void addVendorService(context) async {
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
      var response = await Repository.post({
        "vendor_id": retrievedObject.id.toString().trim(),
        "service_id": ServiceId.toString().trim(),
        "fees": int.parse(Pricectr.text),
        "oppox_time": approxTime.replaceAll(' ', '').toString().trim(),
        "oppox_setting": sittingctr.text.toString().trim(),
        "oppox_setting_duration":
            sitingTime.replaceAll(' ', '').toString().trim(),
        "oppox_setting_days_inverval": daysctr.text.toString().trim(),
      }, ApiUrl.addVendorService, allowHeader: true);
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
}
