import 'package:booking_app/Models/notification_model.dart';
import 'package:booking_app/Models/notification_Static.dart';
import 'package:booking_app/Screens/BookingAppointmentScreen/AppointmentBooking.dart';
import 'package:booking_app/Screens/AppointmentScreen/PreviousAppointmentScreen.dart';
import 'package:booking_app/Screens/AppointmentScreen/Upcoming_Appointment.dart';
import 'package:booking_app/controllers/Appointment_screen_controller.dart';
import 'package:booking_app/controllers/PreviousAppointment_controller.dart';
import 'package:booking_app/controllers/UpcomingAppointment_controller.dart';
import 'package:booking_app/core/Common/appbar.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../core/Common/Common.dart';
import '../../core/themes/color_const.dart';

// ignore: must_be_immutable
class AppointmentScreen extends StatefulWidget {
  AppointmentScreen({
    super.key,
    this.openDrawer,
    required this.isfromNav,
    this.callBack,
  });
  bool isfromNav;
  Function? callBack;

  GlobalKey<ScaffoldState>? openDrawer;

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen>
    with TickerProviderStateMixin {
  var controller = Get.put(AppointmentScreenController());

  List<NotificationItem> staticData = notificationItems;
  late TabController tabController;
  var currentPage = 0;

  bool state = false;

  DateTime? selectedDate = DateTime.now();
  DatePickerController datePickerController = DatePickerController();
  DateTime selectedValue = DateTime.now();
  RxString picDate = "".obs;

  @override
  void initState() {
    //   controller.getAppointmentList(context);
    tabController = TabController(vsync: this, length: 2, initialIndex: 0);

    super.initState();
  }

  @override
  void dispose() {
    Get.find<UpcomingAppointmentController>().appointmentObjectList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Common().trasparent_statusbar();
    return CustomScaffold(
      floatingActionBtn: Container(
        width: 7.h,
        height: 7.h,
        margin: EdgeInsets.only(bottom: 10.h, right: 3.5.w),
        child: FloatingActionButton(
            backgroundColor: isDarkMode() ? white : black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            onPressed: () {
              Get.to(AppointmentBookingScreen())?.then((value) {
                logcat("VALUE", value.toString());
                if (value == true) {
                  currentPage = 0;
                  Get.find<UpcomingAppointmentController>()
                      .appointmentObjectList
                      .clear();
                  Get.find<UpcomingAppointmentController>().getAppointmentList(
                    context,
                    1,
                    true,
                  );
                  setState(() {});
                }
              });
            },
            child: isDarkMode()
                ? Icon(
                    Icons.add,
                    color: black,
                  )
                : Icon(
                    Icons.add,
                    color: white,
                  )),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 1.5.w, right: 1.5.w),
        child: Column(
          children: [
            HomeAppBar(
              title: "Appointment",
              isfilter: false,
              icon: Asset.filter,
              onClick: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: controller.isFromPrevious == true
                        ? selectedDate ?? DateTime.now()
                        : DateTime.now(),
                    firstDate: controller.isFromPrevious == true
                        ? DateTime(1900)
                        : DateTime.now(),
                    lastDate: DateTime(2100));
                if (pickedDate != null) {
                  String apiPassingDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  picDate.value =
                      Common().formatDate(apiPassingDate.toString());

                  controller.isFromPrevious == true
                      ? Get.find<PreviousAppointmentController>()
                          .getAppointmentList(context,
                              selectedDateString: apiPassingDate)
                      : Get.find<UpcomingAppointmentController>()
                          .getAppointmentList(context, 1, true,
                              isClearList: true,
                              selectedDateString: apiPassingDate);
                }
              },
            ),

            // getAppbar(
            //   ScreenTitle.appointment,
            // ),
            Expanded(
              child: getListViewItem(),
            ),
          ],
        ),
      ),
    );
  }

  getListViewItem() {
    return DefaultTabController(
        length: 2,
        child: Column(children: [
          SizedBox(
            height: 2.5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getTab(ScreenTitle.upcomingAppointment, 30, 0),
              getTab(ScreenTitle.previousAppointment, 30, 1),
            ],
          ),
          Expanded(
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                UpcomingAppointment(),
                PreviousAppointmentScreen(),
              ]))
        ]));
  }

  getTab(str, pad, index) {
    return Bounce(
      duration: Duration(milliseconds: 200),
      onPressed: (() {
        currentPage = index;
        if (tabController.indexIsChanging == false) {
          tabController.index = index;
        }
        setState(() {});
      }),
      child: AnimatedContainer(
        width: 40.w,
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(
          horizontal: 3.5.w,
        ),
        padding:
            EdgeInsets.only(left: 5.w, right: 5.w, top: 1.3.h, bottom: 1.3.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: currentPage == index ? Colors.black : Colors.white,
            border: Border.all(
                color: isDarkMode() ? Colors.white : Colors.transparent),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 0.1,
                color: Colors.black.withOpacity(.1),
              )
            ],
            borderRadius: BorderRadius.circular(50)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              str,
              style: TextStyle(
                  fontSize: 12.5.sp,
                  fontFamily: opensans_Bold,
                  fontWeight: FontWeight.w700,
                  color:
                      currentPage == index ? Colors.white : Colors.grey[850]),
            ),
            SizedBox(
              width: currentPage == index ? 4.w : 0,
            ),
            // currentPage == index
            //     ? Container(
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10),
            //           color:
            //               currentPage == index || isDarkMode() ? white : black,
            //           boxShadow: [
            //             BoxShadow(
            //                 color: isDarkMode()
            //                     ? Colors.white.withOpacity(0.2)
            //                     : Colors.black.withOpacity(0.2),
            //                 spreadRadius: 0.1,
            //                 blurRadius: 10,
            //                 offset: Offset(0.5, 0.5)),
            //           ],
            //         ),
            //         padding:
            //             EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
            //         child: currentPage == index
            //             ? Text("6",
            //                 style: TextStyle(
            //                   fontSize: 12.5.sp,
            //                   color: isDarkMode() ? black : null,
            //                 ))
            //             : null,
            //       )
            //     : Container()
          ],
        ),
      ),
    );
  }

  Future showbottomsheetdialog(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(30.0),
      )),
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.0),
          ),
          child: Container(
            height: 40.h,
            color: isDarkMode() ? black : white,
            padding: EdgeInsets.only(
                left: 3.5.h, right: 3.5.h, top: 2.h, bottom: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                    child: Text(
                  'Filter',
                  style: TextStyle(
                    fontFamily: opensans_Bold,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                    color: isDarkMode() ? white : black,
                  ),
                )),
                SizedBox(
                  height: 0.5.h,
                ),
                Divider(
                  height: 3.h,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
                Wrap(
                  children: [
                    StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Column(
                          children: [],
                        );
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3.5.h),
                      child: SizedBox(
                        width: 150.h,
                        height: 5.5.h,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            child: Center(
                              child: Text(
                                'Apply',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.5.sp,
                                    fontFamily: opensans_Bold,
                                    fontWeight: FontWeight.w700),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
