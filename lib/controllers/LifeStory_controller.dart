import 'package:booking_app/controllers/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'internet_controller.dart';

class LifeStoryController extends GetxController {
  // GlobalKey<ScrollSnapListState> keydata = GlobalKey();
  final InternetController _networkManager = Get.find<InternetController>();
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


   final List<TimeOfDay> times = [
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 12, minute: 30),
    TimeOfDay(hour: 15, minute: 45),
    TimeOfDay(hour: 18, minute: 0),
    TimeOfDay(hour: 20, minute: 15),
  ];

  var profileController = Get.put(HomeScreenController());
  // RxBool isViewerIsAllowToEdit = false.obs;
  // isAllow() async {
  //   ModelProfile? profile = profileController.profile.value;
  //   if (profile != null) {
  //     isViewerIsAllowToEdit.value = await allowToEditProfile(profile.uuid);
  //     print("RIGHT: ${isViewerIsAllowToEdit.value}");
  //   }
  //   update();
  // }

  // void manuallyFocusToItem(int index) {
  //   keydata.currentState!.focusToItem(index);
  //   update();
  // }

  void onItemFocus(int index) {
    focusedIndex.value = index;
    update();
  }
}
