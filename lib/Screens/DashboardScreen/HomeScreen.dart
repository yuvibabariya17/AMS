import 'dart:async';
import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Screens/DataSource.dart';
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
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
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
  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.day,
    CalendarView.week,
    CalendarView.workWeek,
    CalendarView.timelineDay,
    CalendarView.timelineWeek,
    CalendarView.timelineWorkWeek
  ];

  List<TimeRegion> regions = <TimeRegion>[];
  late _DataSource events;

  int _currentStep = 0;

  late Stream<String> timeStream;
  late String currentTime;

  int activeStep = 5; // Initial step set to 5.

  int upperBound = 6;

  @override
  void initState() {
    calendarController.view = CalendarView.week;
    events = _DataSource(_getAppointments());
    _updateRegions();
    super.initState();
    // timeStream = getCurrentTime();
  }

  void _updateRegions() {
    final DateTime date =
        DateTime.now().add(Duration(days: -DateTime.now().weekday));
    regions.add(TimeRegion(
      startTime: DateTime(date.year, date.month, date.day),
      endTime: DateTime(date.year, date.month, date.day, 9),
      enablePointerInteraction: false,
      textStyle: const TextStyle(color: Colors.black45, fontSize: 15),
      color: Colors.grey.withOpacity(0.2),
      recurrenceRule: 'FREQ=WEEKLY;INTERVAL=1;BYDAY=MO,TU,WE,TH,FR',
    ));

    regions.add(TimeRegion(
      startTime: DateTime(date.year, date.month, date.day, 18),
      endTime: DateTime(date.year, date.month, date.day, 23, 59, 59),
      enablePointerInteraction: false,
      textStyle: const TextStyle(color: Colors.black45, fontSize: 15),
      color: Colors.grey.withOpacity(0.2),
      recurrenceRule: 'FREQ=WEEKLY;INTERVAL=1;BYDAY=MO,TU,WE,TH,FR',
    ));

    regions.add(TimeRegion(
      startTime: DateTime(date.year, date.month, date.day, 10),
      endTime: DateTime(date.year, date.month, date.day, 11),
      enablePointerInteraction: false,
      textStyle: const TextStyle(color: Colors.black45, fontSize: 15),
      color: Colors.grey.withOpacity(0.2),
      text: 'Not Available',
      recurrenceRule: 'FREQ=WEEKLY;INTERVAL=1;BYDAY=TU',
    ));

    regions.add(TimeRegion(
      startTime: DateTime(date.year, date.month, date.day, 15),
      endTime: DateTime(date.year, date.month, date.day, 16),
      enablePointerInteraction: false,
      textStyle: const TextStyle(color: Colors.black45, fontSize: 15),
      color: Colors.grey.withOpacity(0.2),
      text: 'Not Available',
      recurrenceRule: 'FREQ=WEEKLY;INTERVAL=1;BYDAY=WE',
    ));

    regions.add(TimeRegion(
      startTime: DateTime(date.year, date.month, date.day, 13),
      endTime: DateTime(date.year, date.month, date.day, 14),
      enablePointerInteraction: false,
      textStyle: const TextStyle(color: Colors.black45, fontSize: 15),
      color: Colors.grey.withOpacity(0.2),
      text: 'Lunch',
      recurrenceRule: 'FREQ=WEEKLY;INTERVAL=1;BYDAY=MO,TU,WE,TH,FR',
    ));

    regions.add(TimeRegion(
      startTime: DateTime(date.year, date.month, date.day),
      endTime: DateTime(date.year, date.month, date.day, 23, 59, 59),
      enablePointerInteraction: false,
      textStyle: const TextStyle(color: Colors.black45, fontSize: 15),
      color: Colors.grey.withOpacity(0.2),
      recurrenceRule: 'FREQ=WEEKLY;INTERVAL=1;BYDAY=SA,SU',
    ));
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

  List<Appointment> _getAppointments() {
    final List<String> subjectCollection = <String>[];
    subjectCollection.add('General Meeting');
    subjectCollection.add('Plan Execution');
    subjectCollection.add('Project Plan');
    subjectCollection.add('Consulting');
    subjectCollection.add('Support');
    subjectCollection.add('Development Meeting');
    subjectCollection.add('Scrum');
    subjectCollection.add('Project Completion');
    subjectCollection.add('Release updates');
    subjectCollection.add('Performance Check');

    final List<Color> colorCollection = <Color>[];
    colorCollection.add(const Color(0xFF0F8644));
    colorCollection.add(const Color(0xFF8B1FA9));
    colorCollection.add(const Color(0xFFD20100));
    colorCollection.add(const Color(0xFFFC571D));
    colorCollection.add(const Color(0xFF36B37B));
    colorCollection.add(const Color(0xFF01A1EF));
    colorCollection.add(const Color(0xFF3D4FB5));
    colorCollection.add(const Color(0xFFE47C73));
    colorCollection.add(const Color(0xFF636363));
    colorCollection.add(const Color(0xFF0A8043));

    final Random random = Random();
    final DateTime rangeStartDate =
        DateTime.now().add(const Duration(days: -(365 ~/ 2)));
    final DateTime rangeEndDate = DateTime.now().add(const Duration(days: 365));
    final List<Appointment> appointments = <Appointment>[];

    for (DateTime i = rangeStartDate;
        i.isBefore(rangeEndDate);
        i = i.add(const Duration(days: 1))) {
      final DateTime date = i;
      if (date.weekday == 6 || date.weekday == 7) {
        continue;
      }

      final DateTime startDate = DateTime(date.year, date.month, date.day,
          (date.weekday.isEven ? 14 : 9) + random.nextInt(3));
      appointments.add(Appointment(
          subject: subjectCollection[random.nextInt(7)],
          startTime: startDate,
          endTime: startDate.add(const Duration(hours: 1)),
          color: colorCollection[random.nextInt(9)]));
      appointments.add(Appointment(
          subject: subjectCollection[random.nextInt(7)] + "4444",
          startTime: startDate,
          endTime: startDate.add(const Duration(hours: 1)),
          color: colorCollection[random.nextInt(9)]));
    }

    return appointments;
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
            // Get.to(const AddServiceScreen())?.then((value) {
            //   if (value == true) {
            //     logcat("ISDONE", "DONE");
            //     controller.getServiceList(
            //       context,
            //     );
            //   }
            // });
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
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5.h, top: 2.5.h, left: 3.h),
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
                  Container(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
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
                    height: 5.h,
                    color: Colors.grey,
                  ),
                  Column(children: [
                    Container(
                      margin: EdgeInsets.only(left: 7.w),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Time Slot",
                              style: TextStyle(
                                  color: isDarkMode() ? white : black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700),
                            )
                          ]),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Row(
                      children: [
                        Obx(() {
                          var data = Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 5.w),
                                  height: SizerUtil.height,
                                  alignment: Alignment.topLeft,
                                  width:
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? 70
                                          : 150,
                                  child: ScrollSnapList(
                                    listViewPadding: EdgeInsets.only(
                                        bottom: SizerUtil.deviceType ==
                                                DeviceType.mobile
                                            ? 700
                                            : 700),
                                    key: controller.keydata,
                                    initialIndex: 0,
                                    focusToItem: (p0) {
                                      controller.manuallyFocusToItem(0);
                                    },
                                    scrollDirection: Axis.vertical,
                                    selectedItemAnchor:
                                        SelectedItemAnchor.START,
                                    onItemFocus: (p0) {
                                      controller.onItemFocus(p0);
                                    },
                                    itemSize: SizerUtil.deviceType ==
                                            DeviceType.mobile
                                        ? 90
                                        : 150,
                                    itemBuilder: _buildListItem,
                                    itemCount: controller.times.length,
                                  ),
                                ),
                              ]);
                          return data;
                        }),
                        Expanded(
                            flex: 2,
                            child: 
                            AnimatedSize(
                              duration: Duration(milliseconds: 1000),
                              child: Stack(children: [
                                AnimatedContainer(
                                  width: double.infinity,
                                  duration: Duration(milliseconds: 1000),
                                  margin: EdgeInsets.only(left: 1.h),
                                  child: Row(
                                    children: [
                                      Container(
                                    child: SvgPicture.asset(
                                      Asset.clipArrow,
                                      height: 3.h,
                                      width: 3.h,
                                    ),
                                  ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            DottedBorder(
                                              borderType: BorderType.RRect,
                                              color: primaryColor,
                                              dashPattern: [2, 2],
                                              radius: Radius.circular(
                                                  SizerUtil.deviceType ==
                                                          DeviceType.mobile
                                                      ? 4.w
                                                      : 2.5.w),
                                              child: Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5.w, vertical: 2.h),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border(),
                                                  borderRadius: BorderRadius.circular(
                                                      SizerUtil.deviceType ==
                                                              DeviceType.mobile
                                                          ? 4.w
                                                          : 2.5.w),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        blurRadius: 10.0,
                                                        offset: const Offset(0, 1),
                                                        spreadRadius: 3.0)
                                                  ],
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 1.5.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "Book Appointment",
                                                            style: TextStyle(
                                                                fontSize: SizerUtil
                                                                            .deviceType ==
                                                                        DeviceType
                                                                            .mobile
                                                                    ? 15.sp
                                                                    : 17.sp,
                                                                color: Colors.black,
                                                                fontFamily: fontBold),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            // addLifeStory(
                                                            //     context, false,
                                                            //     model: lifeStoryController
                                                            //             .data.value[
                                                            //         lifeStoryController
                                                            //             .focusedIndex
                                                            //             .value],
                                                            //     uuid: lifeStoryController
                                                            //         .profileController
                                                            //         .profileUniqueId);
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.symmetric(
                                                                    horizontal: 1.w,
                                                                    vertical: 1.w),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    Color(0XFF43C778),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.w)),
                                                            child: Icon(
                                                              Icons.edit_outlined,
                                                              size: SizerUtil
                                                                          .deviceType ==
                                                                      DeviceType
                                                                          .mobile
                                                                  ? 3.w
                                                                  : 2.w,
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 1.5.w,
                                                        ),
                                                        InkWell(
                                                          // onTap: () {
                                                          //   controller.deleteLifeStory(
                                                          //       context,
                                                          //       lifeStory: lifeStoryController
                                                          //               .data.value[
                                                          //           lifeStoryController
                                                          //               .focusedIndex
                                                          //               .value]);
                                                          // },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.symmetric(
                                                                    horizontal: 1.1.w,
                                                                    vertical: 1.1.w),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    Color(0XFFFF5959),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.w)),
                                                            child: Icon(
                                                              Icons.delete_rounded,
                                                              color: isDarkMode()
                                                                  ? Colors.grey
                                                                  : Colors.grey,
                                                              size: 3.h,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 2.h,
                                                    ),
                                                    Text(
                                                      "Description",
                                                      style: TextStyle(
                                                          fontSize: SizerUtil
                                                                      .deviceType ==
                                                                  DeviceType.mobile
                                                              ? 9.sp
                                                              : 7.sp,
                                                          color: Colors.black,
                                                          fontFamily: fontRegular),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Positioned(
                                //   top: 2
                                //       .h, 
                                //   left: 0.5.h,
                                //   child: Container(
                                //     child: SvgPicture.asset(
                                //       Asset.clipArrow,
                                //       height: 3.h,
                                //       width: 3.h,
                                //     ),
                                //   ),
                                // )
                              ]),

                              // Stepper(
                              //   currentStep: 0,
                              //   type: StepperType.vertical,
                              //   steps: [
                              //     Step(
                              //       label:Text("Hey") ,
                              //       subtitle: Text("Hey"),
                              //       title: Text("10:00 AM"),
                              //       content: Container(
                              //         decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.grey),
                              //         width: 200, // Adjust the width as needed
                              //         child: Text("Good Morning"),
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              // SpecialRegionsCalendar(),

                              // SfCalendar(
                              //   view: CalendarView.timelineDay,
                              //   dataSource: MeetingDataSource(_getDataSource()),
                              //   timeSlotViewSettings: TimeSlotViewSettings(
                              //     timeInterval: Duration(minutes: 30),
                              //     timelineAppointmentHeight: 50,
                              //     timeFormat: 'h:mm a',
                              //   ),
                              //   // controller: ,
                              // ),
                            ))
                      ],
                    ),
                  ])
                ]),
              ),
            )
          ],
        );
      })),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Obx(() {
      return Row(
        children: [
          SizedBox(
            height: SizerUtil.deviceType == DeviceType.mobile ? 90 : 150,
            width: SizerUtil.deviceType == DeviceType.mobile ? 70 : 130,
            child: GestureDetector(
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: controller.data.length - 1 == index
                        ? SizerUtil.deviceType == DeviceType.mobile
                            ? 30
                            : 50
                        : 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: index == 0 ? 50 : 0,
                              bottom: index == 29 ? 50 : 0),
                          height: SizerUtil.deviceType == DeviceType.mobile
                              ? 100
                              : 150,
                          width: 2.5,
                          color: !isDarkMode()
                              ? Color(0xFFE1EAEE)
                              : Colors.grey[600],
                        ),
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: controller.focusedIndex == index
                        ? SizerUtil.deviceType == DeviceType.mobile
                            ? 65
                            : 70
                        : SizerUtil.deviceType == DeviceType.mobile
                            ? 65
                            : 70,
                    width: controller.focusedIndex == index
                        ? SizerUtil.deviceType == DeviceType.mobile
                            ? 65
                            : 70
                        : SizerUtil.deviceType == DeviceType.mobile
                            ? 65
                            : 70,
                    padding: EdgeInsets.only(
                      bottom: controller.focusedIndex == index ? 2.h : 0.2.h,
                      top: controller.focusedIndex == index ? 2.h : 0.2.h,
                    ),
                    decoration: BoxDecoration(
                      color: controller.focusedIndex == index
                          ? primaryColor
                          : !isDarkMode()
                              ? Color(0xFFE1EAEE)
                              : Colors.grey[600],
                      borderRadius: BorderRadius.circular(
                          SizerUtil.deviceType == DeviceType.mobile
                              ? controller.focusedIndex == index
                                  ? 5.w
                                  : 3.w
                              : 2.5.w),
                      boxShadow: [
                        BoxShadow(
                            color: controller.focusedIndex == index
                                ? primaryColor.withOpacity(0.3)
                                : primaryColor.withOpacity(0.01),
                            blurRadius: 10.0,
                            offset: const Offset(0, 1))
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      textAlign: TextAlign.center,
                      controller.times[index].toString(),
                      // ignore: invalid_use_of_protected_member
                      // "${LifeStoryController.data.value[index].year}",
                      style: TextStyle(
                        fontFamily: controller.focusedIndex == index
                            ? fontMedium
                            : fontBold,
                        color: controller.focusedIndex == index
                            ? Colors.white
                            : !isDarkMode()
                                ? Colors.black
                                : Colors.white,
                        fontSize: controller.focusedIndex == index
                            ? SizerUtil.deviceType == DeviceType.mobile
                                ? 11.sp
                                : 8.sp
                            : SizerUtil.deviceType == DeviceType.mobile
                                ? 8.sp
                                : 6.sp,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                controller.manuallyFocusToItem(index);
              },
            ),
          ),
        ],
      );
    });
  }

  SfCalendar _getSpecialRegionCalendar(
      {List<TimeRegion>? regions, _DataSource? dataSource}) {
    return SfCalendar(
      // showNavigationArrow: model.isWebFullView,
      controller: calendarController,
      showDatePickerButton: true,
      allowedViews: _allowedViews,
      specialRegions: regions,

      allowAppointmentResize: true,
      timeRegionBuilder: _getSpecialRegionWidget,
      timeSlotViewSettings: const TimeSlotViewSettings(
          minimumAppointmentDuration: Duration(minutes: 30)),
      dataSource: dataSource,
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
}

_getCalendarDataSource() {
  List<Appointment> appointments = <Appointment>[];
  appointments.add(Appointment(
    startTime: DateTime.now(),
    endTime: DateTime.now().add(Duration(hours: 2)),
    subject: 'Meeting with client',
    color: Colors.blue,
  ));

  return (appointments);
}

Widget _getSpecialRegionWidget(
    BuildContext context, TimeRegionDetails details) {
  if (details.region.text == 'Lunch') {
    return Container(
      color: details.region.color,
      alignment: Alignment.center,
      child: Icon(
        Icons.restaurant,
        color: Colors.grey.withOpacity(0.5),
      ),
    );
  } else if (details.region.text == 'Not Available') {
    return Container(
      color: details.region.color,
      alignment: Alignment.center,
      child: Icon(
        Icons.block,
        color: Colors.grey.withOpacity(0.5),
      ),
    );
  }

  return Container(color: details.region.color);
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> appointments) {
    this.appointments = appointments;
  }
}
