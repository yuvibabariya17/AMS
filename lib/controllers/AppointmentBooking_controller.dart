import 'dart:convert';
import 'package:booking_app/Models/ExpertModel.dart';
import 'package:booking_app/dialogs/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../Config/apicall_constant.dart';
import '../Models/CommonModel.dart';
import '../Models/ServiceModel.dart';
import '../Models/sign_in_form_validation.dart';
import '../Screens/BookingAppointmentScreen/TimeSlot.dart';
import '../api_handle/Repository.dart';
import '../core/constants/strings.dart';
import '../core/themes/font_constant.dart';
import '../core/utils/log.dart';
import '../dialogs/dialogs.dart';
import '../preference/UserPreference.dart';
import 'Appointment_screen_controller.dart';
import 'internet_controller.dart';

class AppointmentBookingController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  late FocusNode CustomerNode;
  late FocusNode ServiceNode;
  late FocusNode SlotNode;
  late FocusNode AmountNode;
  late FocusNode NoteNode;
  late FocusNode RemindNode;
  late FocusNode expertNode;

  late TextEditingController Customerctr;
  late TextEditingController Servicectr;
  late TextEditingController Slotctr;
  late TextEditingController Amountctr;
  late TextEditingController Notectr;
  late TextEditingController Remindctr;
  late TextEditingController expertctr;

  late TextEditingController datectr;
  late FocusNode dateNode;

  final formKey = GlobalKey<FormState>();
  RxBool isClickd = false.obs;
  RxInt selectedIndex = 0.obs;
  RxBool value_1 = false.obs;
  Rx<ScreenState> state = ScreenState.apiLoading.obs;

  @override
  void onInit() {
    CustomerNode = FocusNode();
    ServiceNode = FocusNode();
    SlotNode = FocusNode();
    AmountNode = FocusNode();
    NoteNode = FocusNode();
    RemindNode = FocusNode();
    expertNode = FocusNode();
    dateNode = FocusNode();

    Customerctr = TextEditingController();
    expertctr = TextEditingController();
    Servicectr = TextEditingController();
    datectr = TextEditingController();
    Slotctr = TextEditingController();
    Amountctr = TextEditingController();
    Notectr = TextEditingController();
    Remindctr = TextEditingController();
    datectr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  RxList<Choice> choices = [
    Choice(
      title: '11:30 AM',
      isSelected: false,
    ),
    Choice(
      title: '01:30 AM',
      isSelected: false,
    ),
    Choice(
      title: '12:30 PM',
      isSelected: false,
    ),
    Choice(
      title: '01:30 PM',
      isSelected: false,
    ),
    Choice(title: '02:30 PM', isSelected: false),
    Choice(title: '04:00 PM', isSelected: false),
    Choice(title: '05:00 PM', isSelected: false),
    Choice(title: '06:00 PM', isSelected: false),
    Choice(title: '07:00 PM', isSelected: false),
    Choice(title: '08:00 PM', isSelected: false),
    Choice(title: '09:00 PM', isSelected: false),
    Choice(title: '12:00 PM', isSelected: false),
  ].obs;

  void setOnClick(bool isClick) {
    isClickd.value = !isClick;
    update();
  }

  void updateDate(date) {
    datectr.text = date;
    print("PICKED_DATE${datectr.value}");
    update();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var CustomerModel = ValidationModel(null, null, isValidate: false).obs;
  var ServicesModel = ValidationModel(null, null, isValidate: false).obs;
  var SlotModel = ValidationModel(null, null, isValidate: false).obs;
  var AmountModel = ValidationModel(null, null, isValidate: false).obs;
  var NoteModel = ValidationModel(null, null, isValidate: false).obs;
  var RemindModel = ValidationModel(null, null, isValidate: false).obs;
  var expertsModel = ValidationModel(null, null, isValidate: false).obs;
  var dateModel = ValidationModel(null, null, isValidate: false).obs;
  var slotModel = ValidationModel(null, null, isValidate: false).obs;

  void 
  
  
  
  enableSignUpButton() {
    if (CustomerModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (ServicesModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (expertsModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (dateModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (SlotModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (AmountModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (NoteModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (RemindModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (slotModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    }
    
    else {
      isFormInvalidate.value = true;
    }
  }

  void validateCustomer(String? val) {
    CustomerModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Name";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateService(String? val) {
    ServicesModel.update((model) {
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

  void validateExpert(String? val) {
    expertsModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Expert";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateDate(String? val) {
    dateModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Date";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  
  void validateSlot(String? val) {
    slotModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Time Slot";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateAmount(String? val) {
    AmountModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Amount";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateNote(String? val) {
    NoteModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Notes";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateRemind(String? val) {
    RemindModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Reminder for Customer";
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

//Main API CALLING

  void AddBookingAppointmentAPI(context) async {
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
      var response = await Repository.post({
        "vendor_id": retrievedObject!.id.toString().trim(),
        "customer_id": retrievedObject!.id.toString().trim(),
        "vendor_service_id": serviceId.value.toString().trim(),
        // "appointment_slot_id": Feesctr.text.toString().trim(),
        // "duration": .text.toString().trim(),
        "date_of_appointment": retrievedObject!.id.toString().trim(),
      }, ApiUrl.addCourse, allowHeader: true);
      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("RESPOSNE", data);
      var responseDetail = CommonModel.fromJson(data);
      if (response.statusCode == 200) {
        if (responseDetail.status == 1) {
          Get.back();
        } else {
          showDialogForScreen(context, responseDetail.message.toString(),
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, responseDetail.message.toString(),
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context, Connection.servererror, callback: () {});
      loadingIndicator.hide(context);
    }
  }

  RxBool isExpertTypeApiList = false.obs;
  RxList<ExpertList> expertObjectList = <ExpertList>[].obs;
  RxString expertId = "".obs;

  void getExpertList(context) async {
    isExpertTypeApiList.value = true;
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
      logcat("RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = ExpertModel.fromJson(responseData);
        if (data.status == 1) {
          expertObjectList.clear();
          expertObjectList.addAll(data.data);
          logcat("RESPONSE", jsonEncode(expertObjectList));
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

  Widget setExpertList() {
    return Obx(() {
      if (isExpertTypeApiList.value == true)
        return setDropDownContent([].obs, Text("Loading"),
            isApiIsLoading: isExpertTypeApiList.value);

      return setDropDownTestContent(
        expertObjectList,
        ListView.builder(
          shrinkWrap: true,
          itemCount: expertObjectList.length,
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
                logcat("ONTAP", "SACHIN");
                expertId.value = expertObjectList[index].serviceInfo.toString();
                expertctr.text =
                    expertObjectList[index].name.capitalize.toString();

                validateExpert(expertctr.text);
              },
              title: Text(
                expertObjectList[index].name.toString(),
                style: TextStyle(fontFamily: fontRegular, fontSize: 13.5.sp),
              ),
            );
          },
        ),
      );
    });
  }

  // SERVICE LIST

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
                logcat("ONTAP", "SACHIN");
                serviceId.value =
                    serviceObjectList[index].serviceInfo.toString();
                Servicectr.text = serviceObjectList[index]
                    .serviceInfo!
                    .name
                    .capitalize
                    .toString();

                validateService(Servicectr.text);
              },
              title: Text(
                serviceObjectList[index].serviceInfo!.name.toString(),
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
  RxString serviceId = "".obs;

  void getServieList(context) async {
    isServiceTypeApiList.value = true;
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
      logcat("RESPONSE", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = ServiceModel.fromJson(responseData);
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
        title: ScreenTitle.appointmentBooking,
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }

  void navigate() {
    // Get.to(const SignUpScreen(false));
  }
}
