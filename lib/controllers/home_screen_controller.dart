import 'dart:convert';

import 'package:booking_app/Config/apicall_constant.dart';
import 'package:booking_app/Models/HomeScreenModel.dart';
import 'package:booking_app/Models/hairservice.dart';
import 'package:booking_app/Models/hairservice_model.dart';
import 'package:booking_app/api_handle/Repository.dart';
import 'package:booking_app/controllers/theme_controller.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:booking_app/preference/UserPreference.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Models/expert.dart';
import '../Models/expert_model.dart';
import '../Models/offers.dart';
import '../Models/offers_model.dart';
import 'internet_controller.dart';

enum ScreenState { apiLoading, apiError, apiSuccess, noNetwork, noDataFound }

class HomeScreenController extends GetxController {
  List<hairservice> staticData = hairserviceItems;
  var currentPage = 0;

  List pageNavigation = [];
  RxInt currentTreeView = 2.obs;

  RxBool isExpanded = false.obs;
  RxBool isTreeModeVertical = true.obs;
  var theme = Get.put(ThemeController());
  RxBool accessToDrawer = false.obs;
  DateTime selectedValue = DateTime.now();
  bool switch_state = false;
  bool switch_state1 = false;
  GlobalKey<ScrollSnapListState> keydata = GlobalKey();
  DateTime? selectedDate = DateTime.now();

  var icon;
  var leading;
  var isfilter;
  var title;
  DatePickerController datePickerController = DatePickerController();

  List<ExpertItem> staticData1 = expertItems;
  List<OfferItem> staticData2 = offersItems;
  RxString picDate = "".obs;
  RxList treeList = [].obs;
  String name = '';
  String number = '';

  changeIndex(int index) async {
    currentPage = index;
    update();
  }

  final GlobalKey<ScaffoldState> drawer_key = GlobalKey();

  void drawerAction() {
    drawer_key.currentState!.openDrawer();
    update();
  }

  void closeDrawer() {
    drawer_key.currentState!.closeDrawer();
  }

  void updateDate(date) {
    picDate.value = date;
    print("PICKED_DATE${picDate.value}");
    update();
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

  @override
  void onInit() {
    picDate.value = DateFormat.yMMMMd().format(DateTime.now());
    super.onInit();
  }

  Rx<ScreenState> state = ScreenState.apiLoading.obs;
  RxString message = "".obs;
  final InternetController networkManager = Get.find<InternetController>();

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  RxBool isSlotList = false.obs;
  RxList<AppointmentList> slotObjectList = <AppointmentList>[].obs;
  RxString slotId = "".obs;
  RxBool isLoading = false.obs;

  void getHomeList(context, String date) async {
    state.value = ScreenState.apiLoading;
    isLoading.value = false;
    // isServiceTypeApiList.value = true;
    //  try {
    if (networkManager.connectionType == 0) {
      showDialogForScreen(context, Connection.noConnection, callback: () {
        Get.back();
      });
      return;
    }
    var retrievedObject = await UserPreferences().getSignInInfo();

    logcat("PASSING_DATA", {
      "vendor_id": retrievedObject!.id.toString().trim(),
      "date": date.isNotEmpty ? date.toString() : ''
    });
    var response = await Repository.post({
      "search": {
        "vendor_id": retrievedObject.id.toString().trim(),
        "date": date.isNotEmpty ? date.toString() : ''
      }
    }, ApiUrl.homeApi, allowHeader: true);
    isSlotList.value = false;
    var responseData = jsonDecode(response.body);
    isLoading.value = true;
    logcat("HOME_RESPONSE", jsonEncode(responseData));

    if (response.statusCode == 200) {
      var data = HomeScreenModel.fromJson(responseData);
      if (data.status == 1) {
        state.value = ScreenState.apiSuccess;
        slotObjectList.clear();
        slotObjectList.addAll(data.data);
        update();
        logcat("HOME_RESPONSE", jsonEncode(slotObjectList));
        logcat("LENGTH", slotObjectList.length.toString());
      } else {
        showDialogForScreen(context, responseData['message'], callback: () {});
      }
      update();
    } else {
      showDialogForScreen(context, Connection.servererror, callback: () {});
    }
  }

  //  catch (e) {
  //   logcat('Exception', e);
  // }

  String formatTime(String timeString) {
    // Parse the time string into a DateTime object
    DateTime dateTime = DateTime.parse(timeString);
    // Format the time into the desired format
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  }

  String homeFormatTime(String dateString) {
    // Parse the time string into a DateTime object
    DateTime dateTime = DateTime.parse(dateString);
    // Format the time into the desired format
    String formattedTime =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(dateTime);
    return formattedTime;
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
        title: ScreenTitle.service,
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }

  // void initDataSet(BuildContext context) async {
  //   SignInData? retrievedObject = await UserPreferences().getSignInInfo();
  //   name = retrievedObject!.userName.toString();
  //   number = retrievedObject.contactNo1.toString();

  //   //controller.statectr.text = retrievedObject.stateId.toString();
  //   //controller.cityctr.text = retrievedObject.cityId.toString();

  //   update();
  // }

  RxList data = [].obs;
  RxInt focusedIndex = 0.obs;
  // void initData() {
  //   ModelProfile? profile = profileController.profile.value;
  //   if (profile != null && profile.lifeStory != null) {
  //     for (LifeStory model in profile.lifeStory!) {
  //       data.add(model);
  //     }
  //     onItemFocus(0);
  //   }
  //  }

  final List<String> times = [
    "9:00 AM",
    "9:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
    "1:00 PM",
  ].obs;

  // var profileController = Get.put(HomeScreenController());

  // RxBool isViewerIsAllowToEdit = false.obs;
  // isAllow() async {
  //   ModelProfile? profile = profileController.profile.value;
  //   if (profile != null) {
  //     isViewerIsAllowToEdit.value = await allowToEditProfile(profile.uuid);
  //     print("RIGHT: ${isViewerIsAllowToEdit.value}");
  //   }
  //   update();
  // }

  void manuallyFocusToItem(int index) {
    keydata.currentState!.focusToItem(index);
    update();
  }

  void onItemFocus(int index) {
    focusedIndex.value = index;
    update();
  }
}
