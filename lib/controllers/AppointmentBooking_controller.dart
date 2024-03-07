import 'dart:convert';
import 'package:booking_app/Models/AppointmentSlotModel.dart';
import 'package:booking_app/Models/CustomerListModel.dart';
import 'package:booking_app/Models/ExpertModel.dart';
import 'package:booking_app/Models/VendorServiceModel.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/dialogs/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../Config/apicall_constant.dart';
import '../Models/CommonModel.dart';
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
  late FocusNode appointmentTypeNode;
  late FocusNode durationNode;
  late FocusNode dateNode;

  late TextEditingController Customerctr;
  late TextEditingController Servicectr;
  late TextEditingController Slotctr;
  late TextEditingController Amountctr;
  late TextEditingController Notectr;
  late TextEditingController Remindctr;
  late TextEditingController expertctr;
  late TextEditingController appointmentTypectr;
  late TextEditingController durationctr;
  late TextEditingController datectr;

  final formKey = GlobalKey<FormState>();
  RxBool isClickd = false.obs;
  RxInt selectedIndex = 0.obs;
  RxBool isRemind = false.obs;
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
    appointmentTypeNode = FocusNode();
    durationNode = FocusNode();

    Customerctr = TextEditingController();
    expertctr = TextEditingController();
    Servicectr = TextEditingController();
    datectr = TextEditingController();
    Slotctr = TextEditingController();
    Amountctr = TextEditingController();
    Notectr = TextEditingController();
    Remindctr = TextEditingController();
    datectr = TextEditingController();
    appointmentTypectr = TextEditingController();
    durationctr = TextEditingController();

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

  String sitingTime = "";

  void updateSittingDuration(date) {
    durationctr.text = date;
    print("PICKED_DATE${durationctr.value}");
    update();
  }

  updateSelectedTimeSlote(bool isSelected) {
    isItemSelected.value = isSelected;
    enableSignUpButton();
    update();
  }

  RxBool isItemSelected = false.obs;

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
  var appointmentTypeModel = ValidationModel(null, null, isValidate: false).obs;
  var durationModel = ValidationModel(null, null, isValidate: false).obs;
  var SlotSelectionModel = ValidationModel(null, null, isValidate: false).obs;

  void enableSignUpButton() {
    if (CustomerModel.value.isValidate == false) {
      logcat("STEP", '1');
      isFormInvalidate.value = false;
    } else if (ServicesModel.value.isValidate == false) {
      logcat("STEP", '2');
      isFormInvalidate.value = false;
    } else if (expertsModel.value.isValidate == false) {
      logcat("STEP", '3');
      isFormInvalidate.value = false;
    } else if (dateModel.value.isValidate == false) {
      logcat("STEP", '4');
      isFormInvalidate.value = false;
    } else if (durationModel.value.isValidate == false) {
      logcat("STEP", '5');
      isFormInvalidate.value = false;
    } else if (isItemSelected.value == false) {
      logcat("STEP", '6');
      isFormInvalidate.value = false;
    } else if (AmountModel.value.isValidate == false) {
      logcat("STEP", '7');
      isFormInvalidate.value = false;
    } else if (appointmentTypeModel.value.isValidate == false) {
      logcat("STEP", '8');
      isFormInvalidate.value = false;
    } else if (NoteModel.value.isValidate == false) {
      logcat("STEP", '9');
      isFormInvalidate.value = false;
    } else {
      logcat("STEP", '11');
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

  void validateSlots() {
    if (selectedIndex.value == -1) {
      // No slot selected
      SlotSelectionModel.update((model) {
        model!.error = "Please select a slot";
        model.isValidate = false;
      });
    } else {
      // Slot selected
      SlotSelectionModel.update((model) {
        model!.error = null;
        model.isValidate = true;
      });
    }

    // Call a method to enable/disable the button based on validation
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

  void validateDuration(String? val) {
    durationModel.update((model) {
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

  void validateAppointmentType(String? val) {
    appointmentTypeModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Appointment Type";
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

  RxString selectedAppointmentSlotId = "".obs;
  RxString apiFormattedDate = "".obs;

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

      logcat("ADDAPPOINTMENT", {
        "vendor_id": retrievedObject!.id.toString().trim(),
        "customer_id": customerId.value.toString().trim(),
        "export_id": expertId.value.toString().trim(),
        "vendor_service_id": ServiceId.value.toString().trim(),
        "appointment_slot_id":
            selectedAppointmentSlotId.value.toString().trim(),
        "amount": Amountctr.text.toString().trim(),
        "appointment_type": appointmentTypectr.text.toString().trim(),
        "duration": durationctr.text.toString().trim(),
        "date_of_appointment": apiFormattedDate.value,
        "make_reminder": 1,
        "is_confirmed": 1,
        "is_finished": 0,
        "is_cancelled": 0,
        "is_reschedule": 0,
        "notes": Notectr.text.toString().trim()
      });
      var response = await Repository.post({
        "vendor_id": retrievedObject.id.toString().trim(),
        "customer_id": customerId.value.toString().trim(),
        "export_id": expertId.value.toString().trim(),
        "vendor_service_id": ServiceId.value.toString().trim(),
        "appointment_slot_id":
            selectedAppointmentSlotId.value.toString().trim(),
        "amount": Amountctr.text.toString().trim(),
        "appointment_type": appointmentTypectr.text.toString().trim(),
        "duration": durationctr.text.toString().trim(),
        "date_of_appointment": apiFormattedDate.value,
        "make_reminder": 1,
        "is_confirmed": 1,
        "is_finished": 0,
        "is_cancelled": 0,
        "is_reschedule": 0,
        "notes": Notectr.text.toString().trim()
        // "appointment_slot_id": Feesctr.text.toString().trim(),
        // "duration": .text.toString().trim(),
      }, ApiUrl.addAppointment, allowHeader: true);
      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("RESPOSNE", data);
      // var responseDetail = CommonModel.fromJson(data);
      if (response.statusCode == 200) {
        if (data['status'] == 1) {
          showDialogForScreen(context, data['message'].toString(),
              callback: () {
            Get.back(result: true);
          });
        } else {
          showDialogForScreen(context, data['message'].toString(),
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

  void UpdateAppointment(context, String Id) async {
    // logcat("IDD:::::", serviceId.toString());
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

      logcat("UPDATE_APPOINTMENT", {
        "vendor_id": retrievedObject!.id.toString().trim(),
        "customer_id": customerId.value.toString().trim(),
        "export_id": expertId.value.toString().trim(),
        "vendor_service_id": ServiceId.value.toString().trim(),
        "appointment_slot_id":
            selectedAppointmentSlotId.value.toString().trim(),
        "amount": Amountctr.text.toString().trim(),
        "appointment_type": appointmentTypectr.text.toString().trim(),
        "duration": durationctr.text.toString().trim(),
        "date_of_appointment": apiFormattedDate.value,
        "make_reminder": 1,
        "is_confirmed": 1,
        "is_finished": 0,
        "is_cancelled": 0,
        "is_reschedule": 0,
        "notes": Notectr.text.toString().trim()
      });
      var response = await Repository.put({
        "vendor_id": retrievedObject!.id.toString().trim(),
        "customer_id": customerId.value.toString().trim(),
        "export_id": expertId.value.toString().trim(),
        "vendor_service_id": ServiceId.value.toString().trim(),
        "appointment_slot_id":
            selectedAppointmentSlotId.value.toString().trim(),
        "amount": Amountctr.text.toString().trim(),
        "appointment_type": appointmentTypectr.text.toString().trim(),
        "duration": durationctr.text.toString().trim(),
        "date_of_appointment": apiFormattedDate.value,
        "make_reminder": 1,
        "is_confirmed": 1,
        "is_finished": 0,
        "is_cancelled": 0,
        "is_reschedule": 0,
        "notes": Notectr.text.toString().trim()
      }, '${ApiUrl.editAppointment}/$Id', allowHeader: true);
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

// APPOITNTMENT SLOT LIST

  RxBool isSlotApiList = false.obs;
  RxList<SlotList> slotObjectList = <SlotList>[].obs;
  RxString slotId = "".obs;

  void getAppointmentSlot(context) async {
    isSlotApiList.value = true;
    // try {
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
    }, ApiUrl.slotList, allowHeader: true);
    isSlotApiList.value = false;
    var responseData = jsonDecode(response.body);
    logcat("SLOT_LIST", jsonEncode(responseData));

    if (response.statusCode == 200) {
      var data = AppointmentSlotModel.fromJson(responseData);
      if (data.status == 1) {
        slotObjectList.clear();
        slotObjectList.addAll(data.data);

        if (slotObjectList.isNotEmpty) {
          selectedAppointmentSlotId.value = slotObjectList[0].id.toString();
          updateSelectedTimeSlote(true);
        }
        logcat("SLOT_LIST", jsonEncode(slotObjectList));
        logcat("SLOT_LIST_LENGTH", (slotObjectList.length));
        logcat("RECORD", (data.totalRecord.toString()));
      } else {
        showDialogForScreen(context, responseData['message'], callback: () {});
      }
    } else {
      showDialogForScreen(context, Connection.servererror, callback: () {});
    }
    // } catch (e) {
    //   logcat('Exception', e);
    //   isSlotApiList.value = false;
    // }
  }

  Widget setAppointmentList() {
    return Obx(() {
      if (isSlotApiList.value == true)
        return setDropDownContent([].obs, Text("Loading"),
            isApiIsLoading: isSlotApiList.value);

      return GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          childAspectRatio: 2.0,
          crossAxisCount: 3,
          crossAxisSpacing: 17,
          mainAxisSpacing: 4,
          children: List.generate(choices.length, (index) {
            return GestureDetector(
              onTap: () {
                selectedIndex.value = index;
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 25.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color:
                      selectedIndex.value == index ? Colors.black : Colors.grey,
                ),
                child: Center(
                  child: Text(
                    choices[index].title,
                    style: TextStyle(
                        fontFamily: opensans_Bold,
                        color: Colors.white,
                        fontSize: SizerUtil.deviceType == DeviceType.mobile
                            ? 12.sp
                            : 13.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            );
          }));

      // setDropDownTestContent(
      //   slotObjectList,

      //   ListView.builder(
      //     shrinkWrap: true,
      //     itemCount: slotObjectList.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       return ListTile(
      //         dense: true,
      //         visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      //         contentPadding:
      //             const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
      //         horizontalTitleGap: null,
      //         minLeadingWidth: 5,
      //         onTap: () {
      //           Get.back();
      //           logcat("SLOT_LIST", "SLOT");
      //           slotId.value = slotObjectList[index].id.toString();
      //           expertctr.text =
      //               slotObjectList[index].timeOfAppointment.toString();

      //           validateExpert(expertctr.text);
      //           getAppointmentSlot(context);
      //         },
      //         title: Text(
      //           slotObjectList[index].timeOfAppointment.toString(),
      //           style: TextStyle(fontFamily: fontRegular, fontSize: 13.5.sp),
      //         ),
      //       );
      //     },
      //   ),
      // );
    });
  }

  // EXPERT LISTTTT

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
      logcat("EXPERT LIST", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = ExpertModel.fromJson(responseData);
        if (data.status == 1) {
          expertObjectList.clear();
          expertObjectList.addAll(data.data);
          logcat("EXPERT LIST", jsonEncode(expertObjectList));
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
                logcat("SETEXPERTLIST", "EXPERT");
                expertId.value = expertObjectList[index].id.toString();
                expertctr.text =
                    expertObjectList[index].name.capitalize.toString();

                validateExpert(expertctr.text);
                getAppointmentSlot(context);
              },
              title: Text(
                expertObjectList[index].name.toString(),
                style: TextStyle(
                    fontFamily: fontRegular,
                    fontSize: 13.5.sp,
                    color: isDarkMode() ? white : black),
              ),
            );
          },
        ),
      );
    });
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
                    serviceObjectList[index].serviceInfo.name.toString();

                validateService(Servicectr.text);
              },
              title: Text(
                serviceObjectList[index].serviceInfo.name.toString(),
                style: TextStyle(
                    fontFamily: fontRegular,
                    fontSize: 13.5.sp,
                    color: isDarkMode() ? white : black),
              ),
            );
          },
        ),
      );
    });
  }

  RxBool isServiceTypeApiList = false.obs;
  RxList<VendorServiceList> serviceObjectList = <VendorServiceList>[].obs;
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
      }, ApiUrl.vendorServiceList, allowHeader: true);
      isServiceTypeApiList.value = false;
      var responseData = jsonDecode(response.body);
      logcat("SERVICE LIST", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = VendorServiceModel.fromJson(responseData);
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

  RxBool isCustomerTypeApiList = false.obs;
  RxList<ListofCustomer> customerObjectList = <ListofCustomer>[].obs;
  RxString customerId = "".obs;

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
                customerObjectList[index].name.toString(),
                style: TextStyle(
                    fontFamily: fontRegular,
                    fontSize: 13.5.sp,
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
        title: ScreenTitle.appointmentBooking,
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }

  void navigate() {
    // Get.to(const SignUpScreen(false));
  }
}
