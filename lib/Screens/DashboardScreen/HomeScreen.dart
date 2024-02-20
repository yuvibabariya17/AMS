import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Screens/DashboardScreen/ListScreen%20.dart';
import 'package:booking_app/Screens/NotificationScreen/NotificationScreen.dart';
import 'package:booking_app/controllers/home_screen_controller.dart';
import 'package:booking_app/core/Common/Common.dart';
import 'package:booking_app/core/Common/appbar.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../controllers/internet_controller.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    required this.callback,
    super.key,
  });
  Function callback;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controller = Get.put(HomeScreenController());

final CalendarController calendarController = CalendarController();

  List<TimeRegion> regions = <TimeRegion>[];
//  late _DataSource events;

  late Stream<String> timeStream;
  late String currentTime;

  int activeStep = 5; // Initial step set to 5.

  int upperBound = 6;

  @override
  void initState() {
    calendarController.view = CalendarView.week;
    // events = _DataSource(_getAppointments());

    super.initState();
    // timeStream = getCurrentTime();
  }

  Stream<String> getCurrentTime() {
    return Stream.periodic(Duration(seconds: 1), (i) {
      final currentTime = DateTime.now();
      final formattedTime = DateFormat('hh:mm a').format(currentTime);
      return formattedTime;
    }).map((time) {
      setState(() {
        currentTime = time;
      });
      return time;
    });
  }

  void executeAfterBuild() {
    controller.datePickerController.animateToSelection();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 600), () {
      try {
        controller.manuallyFocusToItem(0);
      } catch (e) {}
    });
    Common().trasparent_statusbar();
    WidgetsBinding.instance.addPostFrameCallback((_) => executeAfterBuild());
    return CustomScaffold(
      floatingActionBtn: Container(
        width: 7.h,
        height: 7.h,
        margin: EdgeInsets.only(bottom: 10.h, right: 3.w),
        child: FloatingActionButton(
          backgroundColor: isDarkMode() ? white : black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          onPressed: () {
            // Get.to(ListScreen());
          },
          child: Icon(
            Icons.add,
            color: isDarkMode() ? black : white,
          ),
        ),
      ),
      body: SafeArea(
          child: GetBuilder<InternetController>(builder: (internetCtr) {
        // if (internetCtr.connectivity == ConnectivityResult.none) {
        //   return checkInternet();
        // }
        return Column(
          children: [
            FadeInDown(
              from: 50,
              child: HomeAppBar(
                openDrawer: controller.drawer_key,
                title: DashboardConstant.book,
                leading: Asset.backbutton,
                isfilter: true,
                isBack: false,
                onClick: () async {
                  Get.to(
                      NotificationScreen(controller.icon, controller.leading));
                },
                icon: Asset.filter,
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: [
                Container(
                  margin: EdgeInsets.only(top: 2.5.h, left: 3.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text("Today",
                                style: TextStyle(
                                    fontSize: 17.5.sp,
                                    color: isDarkMode() ? white : black,
                                    fontFamily: opensansMedium,
                                    fontWeight: FontWeight.w700)),
                          ),
                          Obx(
                            () {
                              return FadeInDown(
                                from: 70,
                                child: Text(
                                  (controller.picDate.value.toString()),
                                  style: TextStyle(
                                      fontSize: 16.5.sp,
                                      color: isDarkMode() ? white : black,
                                      fontFamily: opensansMedium,
                                      fontWeight: FontWeight.w700),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5.w, right: 2.w),
                  child: DatePicker(
                    DateTime.now(),
                    width: 7.h,
                    height: 12.h,
                    controller: controller.datePickerController,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: isDarkMode() ? white : black,
                    selectedTextColor: isDarkMode() ? black : white,
                    dayTextStyle: TextStyle(
                        color: isDarkMode() ? white : black,
                        fontFamily: fontRegular),
                    monthTextStyle: TextStyle(
                        color: isDarkMode() ? white : black,
                        fontFamily: fontRegular),
                    dateTextStyle: TextStyle(
                        color: isDarkMode() ? white : black,
                        fontFamily: fontRegular),
                    //   deactivatedColor: isDarkMode() ? Graycolor : black,
                    inactiveDates: [],
                    onDateChange: (date) {
                      setState(() {
                        controller.selectedValue = date;
                      });
                    },
                  ),
                ),
                Divider(
                  endIndent: 3.h,
                  indent: 3.h,
                  thickness: 0.5.sp,
                  height: 2.h,
                  color: Colors.grey,
                ),
                Container(
                  margin: EdgeInsets.only(left: 6.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Time Slot",
                          style: TextStyle(
                              color: isDarkMode() ? white : black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        )
                      ]),
                ),
              ]),
            ),
            SizedBox(
              height: 1.h,
            ),
            Expanded(child: ListScreen())
          ],
        );
      })),
    );
  }
}
