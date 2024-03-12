import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Models/HomeScreenModel.dart';
import 'package:booking_app/Screens/BookingAppointmentScreen/AppointmentBooking.dart';
import 'package:booking_app/Screens/DashLine.dart';
import 'package:booking_app/Screens/NotificationScreen/NotificationScreen.dart';
import 'package:booking_app/controllers/home_screen_controller.dart';
import 'package:booking_app/core/Common/Common.dart';
import 'package:booking_app/core/Common/appbar.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:sizer/sizer.dart';
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
//  late _DataSource events;
  String? formattedDate;

  @override
  void initState() {
    super.initState();
    formattedDate = Common().getCurrentDateFormate();
    controller.getHomeList(context, Common().getCurrentDate());
  }

  String formatTime(String dateTimeString) {
    // Parse the date string into a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format the DateTime object into the desired format
    String formattedDate = DateFormat('h:mm a').format(dateTime);
    return formattedDate;
  }

  void executeAfterBuild() {
    controller.datePickerController.animateToSelection();
  }

  @override
  void dispose() {
    controller.selectedDate = DateTime.now();
    String apiPassingDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    controller.picDate.value = Common().formatDate(apiPassingDate.toString());
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
      // floatingActionBtn: Container(
      //   width: 7.h,
      //   height: 7.h,
      //   margin: EdgeInsets.only(bottom: 10.h, right: 3.w),
      //   child: FloatingActionButton(
      //     backgroundColor: isDarkMode() ? white : black,
      //     shape:
      //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      //     onPressed: () {
      //       // Get.to(ListScreen());
      //     },
      //     child: Icon(
      //       Icons.add,
      //       color: isDarkMode() ? black : white,
      //     ),
      //   ),
      // ),
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
                      GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate:
                                  controller.selectedDate ?? DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100));
                          if (pickedDate != null) {
                            String apiPassingDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            controller.picDate.value =
                                Common().formatDate(apiPassingDate.toString());

                            DateTime parsedDate =
                                DateTime.parse(apiPassingDate);
                            controller.selectedValue = parsedDate;

                            //controller.updateDate(apiPassingDate);

                            controller.selectedDate = pickedDate;
                            controller.datePickerController
                                .setDateAndAnimate(pickedDate);

                            setState(() {});
                            controller.getHomeList(context, apiPassingDate);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            right: 3.5.h,
                          ),
                          height: 6.1.h,
                          width: 6.1.h,
                          decoration: BoxDecoration(
                              color: isDarkMode() ? white : black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            child: SvgPicture.asset(
                              Asset.calender,
                              color: isDarkMode() ? black : white,
                              height: 1.sp,
                              width: 1.sp,
                            ),
                          ),
                        ),
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
                    initialSelectedDate:
                        controller.selectedDate ?? DateTime.now(),
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
                        formattedDate = DateFormat('yyyy-MM-dd').format(date);
                        DateTime parsedDate = DateTime.parse(formattedDate!);
                        controller.selectedValue = parsedDate;
                        controller.picDate.value =
                            Common().formatDate(date.toString());
                        controller.getHomeList(context, formattedDate!);
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
            Expanded(
              child: Obx(() {
                switch (controller.state.value) {
                  case ScreenState.apiLoading:
                  case ScreenState.noNetwork:
                  case ScreenState.noDataFound:
                  case ScreenState.apiError:
                    return Container(
                      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                      height: SizerUtil.height / 1.5,
                      child: apiOtherStates(controller.state.value),
                    );
                  case ScreenState.apiSuccess:
                    return Container(
                        // margin: EdgeInsets.only(bottom: 3.h, top: 2.h),
                        child: apiSuccess(controller.state.value));
                  default:
                    Container();
                }
                return Container();
              }),
            )
          ],
        );
      })),
    );
  }

  Widget apiOtherStates(state) {
    if (state == ScreenState.apiLoading) {
      return Center(
        child: ClipOval(
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: isDarkMode() ? black : white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Image.asset(
              "assets/gif/apiloader.gif",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            controller.message.value,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: fontMedium, fontSize: 12.sp),
          ),
        ),
      ],
    );
  }

  Widget apiSuccess(ScreenState state) {
    logcat("LENGTH", controller.slotObjectList.length.toString());
    // ignore: unrelated_type_quality_checks
    if (controller.state == ScreenState.apiSuccess &&
        controller.slotObjectList.isNotEmpty) {
      return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: controller.slotObjectList.length,
          itemBuilder: (context, index) {
            // final data = hairserviceItems[index];
            AppointmentList selectedData = controller.slotObjectList[index];
            logcat("selectedData", selectedData.toString());
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IntrinsicHeight(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 6.w),
                              height: 5.5.h,
                              width: 15.w,
                              padding: EdgeInsets.only(
                                  left: 2.w, right: 2.w, top: 0.1.h),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: isDarkMode()
                                          ? Colors.white.withOpacity(0.2)
                                          : Colors.black.withOpacity(0.2),
                                      spreadRadius: 0.1,
                                      blurRadius: 10,
                                      offset: Offset(0.5, 0.5)),
                                ],
                                color: isDarkMode() ? black : black,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                    color: isDarkMode() ? white : black),
                              ),
                              child: Text(
                                controller.formatTime(
                                  selectedData.timeOfAppointment.toString(),
                                ),
                                textAlign: TextAlign
                                    .center, // Ensure item.time is not null
                                style: TextStyle(
                                  color: isDarkMode() ? white : white,
                                ),
                              ),
                            ),
                            if (index < controller.slotObjectList.length - 1)
                              Container(
                                margin: EdgeInsets.only(
                                  left: 5.5.w,
                                ),
                                height: 8.5.h,
                                color: Colors.grey,
                                width: 0.4.w,
                              )
                          ],
                        ),
                        Expanded(
                            child: Container(
                          height: 14.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount: selectedData.appointmentInfo.length,
                            itemBuilder: (BuildContext context, int index) {
                              AppointmentInfo item =
                                  selectedData.appointmentInfo[index];
                              logcat("selectedData", selectedData.toString());
                              logcat("SELECTED_DATA", item);
                              return Container(
                                child: GestureDetector(
                                  onTap: (() {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.symmetric(
                                              vertical: 25.h, horizontal: 4.h),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20.0), // Adjust the radius as needed
                                          ),
                                          elevation: 0.0, // No shadow
                                          //clipBehavior: Clip.antiAlias,
                                          backgroundColor:
                                              isDarkMode() ? black : white,
                                          content: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 3.h,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      item.service.length > 10
                                                          ? Container(
                                                              width: 55.w,
                                                              child: Marquee(
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      fontRegular,
                                                                  color: isDarkMode()
                                                                      ? white
                                                                      : black,
                                                                  fontSize: SizerUtil
                                                                              .deviceType ==
                                                                          DeviceType
                                                                              .mobile
                                                                      ? 16.sp
                                                                      : 10.sp,
                                                                ),
                                                                text: item
                                                                    .service,
                                                                scrollAxis: Axis
                                                                    .horizontal, // Use Axis.vertical for vertical scrolling
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start, // Adjust as needed
                                                                blankSpace:
                                                                    20.0, // Adjust the space between text repetitions
                                                                velocity:
                                                                    50.0, // Adjust the scrolling speed
                                                                pauseAfterRound:
                                                                    const Duration(
                                                                        seconds:
                                                                            1), // Time to pause after each scroll
                                                                startPadding: 2
                                                                    .w, // Adjust the initial padding
                                                                accelerationDuration:
                                                                    const Duration(
                                                                        seconds:
                                                                            1), // Duration for acceleration
                                                                accelerationCurve:
                                                                    Curves
                                                                        .linear, // Acceleration curve
                                                                decelerationDuration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            500), // Duration for deceleration
                                                                decelerationCurve:
                                                                    Curves
                                                                        .easeOut, // Deceleration curve
                                                              ),
                                                            )
                                                          : Text(
                                                              item.service,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    fontRegular,
                                                                color:
                                                                    isDarkMode()
                                                                        ? white
                                                                        : black,
                                                                fontSize: SizerUtil
                                                                            .deviceType ==
                                                                        DeviceType
                                                                            .mobile
                                                                    ? 16.sp
                                                                    : 10.sp,
                                                              ),
                                                            ),
                                                      Spacer(),
                                                      Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Icon(
                                                            Icons.cancel,
                                                            size: 24.0,
                                                            color: isDarkMode()
                                                                ? white
                                                                : black,
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              Divider(
                                                color: Colors.grey,
                                              ),
                                              Column(
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Customer Name : ",
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: isDarkMode()
                                                              ? white
                                                              : black,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          item.customerInfo.name
                                                              .capitalize
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .visible,
                                                          maxLines: 3,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              fontSize: SizerUtil
                                                                          .deviceType ==
                                                                      DeviceType
                                                                          .mobile
                                                                  ? 12.sp
                                                                  : 10.sp,
                                                              color:
                                                                  isDarkMode()
                                                                      ? white
                                                                      : black,
                                                              fontFamily:
                                                                  fontRegular),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Contact No : ",
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: isDarkMode()
                                                          ? white
                                                          : black,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller
                                                          .launchPhoneCall(item
                                                              .customerInfo
                                                              .contactNo);
                                                    },
                                                    child: Text(
                                                      item.customerInfo
                                                          .contactNo,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: SizerUtil
                                                                      .deviceType ==
                                                                  DeviceType
                                                                      .mobile
                                                              ? 12.sp
                                                              : 12.sp,
                                                          color: isDarkMode()
                                                              ? white
                                                              : black,
                                                          fontFamily:
                                                              fontRegular),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(
                                                        style: TextStyle(
                                                          fontSize: 8.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: isDarkMode()
                                                              ? white
                                                              : black,
                                                          fontFamily: fontBold,
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                            text: 'Duration : ',
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      item.duration.toString(),
                                                      style: TextStyle(
                                                          fontSize: SizerUtil
                                                                      .deviceType ==
                                                                  DeviceType
                                                                      .mobile
                                                              ? 12.sp
                                                              : 12.sp,
                                                          color: isDarkMode()
                                                              ? white
                                                              : black,
                                                          fontFamily:
                                                              fontRegular),
                                                    )
                                                  ]),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Appointment Type : ",
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: isDarkMode()
                                                          ? white
                                                          : black,
                                                    ),
                                                  ),
                                                  Text(
                                                    item.appointmentType,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: SizerUtil
                                                                    .deviceType ==
                                                                DeviceType
                                                                    .mobile
                                                            ? 12.sp
                                                            : 12.sp,
                                                        color: isDarkMode()
                                                            ? white
                                                            : black,
                                                        fontFamily:
                                                            fontRegular),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Amount : ",
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: isDarkMode()
                                                          ? white
                                                          : black,
                                                    ),
                                                  ),
                                                  Text(
                                                    '₹ ${item.amount.toString()}',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: SizerUtil
                                                                    .deviceType ==
                                                                DeviceType
                                                                    .mobile
                                                            ? 12.sp
                                                            : 12.sp,
                                                        color: isDarkMode()
                                                            ? white
                                                            : black,
                                                        fontFamily:
                                                            fontRegular),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Notes : ",
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: isDarkMode()
                                                          ? white
                                                          : black,
                                                    ),
                                                  ),
                                                  Text(
                                                    item.notes,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: SizerUtil
                                                                    .deviceType ==
                                                                DeviceType
                                                                    .mobile
                                                            ? 12.sp
                                                            : 12.sp,
                                                        color: isDarkMode()
                                                            ? white
                                                            : black,
                                                        fontFamily:
                                                            fontRegular),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 1.4.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: SvgPicture.asset(
                                                  Asset.clipArrow,
                                                  height: 2.5.h,
                                                  width: 2.5.w,
                                                  color: isDarkMode()
                                                      ? white
                                                      : black,
                                                ),
                                              ),
                                              Container(
                                                height:
                                                    1, // Set the height of the line
                                                width: 2.5
                                                    .w, // Set the width of the line (adjust as needed)
                                                child: CustomPaint(
                                                  painter: DashLinePainter(
                                                      color: isDarkMode()
                                                          ? white
                                                          : black,
                                                      dashLength: 2,
                                                      dashGap: 2),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                            margin:
                                                EdgeInsets.only(bottom: 2.8.h),
                                            // padding:
                                            //     EdgeInsets.only(bottom: 1.h),
                                            width: 55.w,
                                            child: DottedBorder(
                                              borderType: BorderType.RRect,
                                              color:
                                                  isDarkMode() ? white : black,
                                              dashPattern: [2, 2],
                                              radius: Radius.circular(
                                                  SizerUtil.deviceType ==
                                                          DeviceType.mobile
                                                      ? 4.w
                                                      : 2.5.w),
                                              child: Container(
                                                // height: 10.h,
                                                width: 55.w,
                                                padding: EdgeInsets.only(
                                                    right: 2.w,
                                                    left: 2.w,
                                                    top: 0.5.h,
                                                    bottom: 0.5.h),
                                                decoration: BoxDecoration(
                                                  color: isDarkMode()
                                                      ? black
                                                      : white,
                                                  border: Border(),
                                                  borderRadius: BorderRadius
                                                      .circular(SizerUtil
                                                                  .deviceType ==
                                                              DeviceType.mobile
                                                          ? 4.w
                                                          : 2.5.w),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        blurRadius: 10.0,
                                                        offset:
                                                            const Offset(0, 1),
                                                        spreadRadius: 3.0)
                                                  ],
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 0.5.h),
                                                        height: 6.h,
                                                        width: 0.5.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: isDarkMode()
                                                              ? white
                                                              : black,
                                                          borderRadius: BorderRadius
                                                              .circular(SizerUtil
                                                                          .deviceType ==
                                                                      DeviceType
                                                                          .mobile
                                                                  ? 4.w
                                                                  : 2.5.w),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      Container(
                                                        child: SvgPicture.asset(
                                                          Asset.time,
                                                          color: isDarkMode()
                                                              ? white
                                                              : black,
                                                          height: 1.8.h,
                                                        ),
                                                      ),
                                                      SizedBox(width: 2.w),
                                                    ]),
                                                    SizedBox(
                                                      width: 1.w,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  item.service,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        11.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    color: isDarkMode()
                                                                        ? white
                                                                        : black,
                                                                  ),
                                                                ),
                                                                // Spacer(),
                                                                // Container(
                                                                //   padding:
                                                                //       EdgeInsets.only(
                                                                //           left: 1.w,
                                                                //           right: 1.w,
                                                                //           top: 0.5.h,
                                                                //           bottom:
                                                                //               0.5.h),
                                                                //   decoration: BoxDecoration(
                                                                //       color: Color(
                                                                //           0XFF43C778),
                                                                //       borderRadius:
                                                                //           BorderRadius
                                                                //               .circular(
                                                                //                   5.w)),
                                                                //   child: Icon(
                                                                //     Icons
                                                                //         .edit_outlined,
                                                                //     size: 1.h,
                                                                //     color:
                                                                //         Colors.white,
                                                                //   ),
                                                                // ),
                                                                // SizedBox(
                                                                //   width: 1.w,
                                                                // ),
                                                                // Container(
                                                                //   padding:
                                                                //       EdgeInsets.only(
                                                                //           left: 0.5.w,
                                                                //           right:
                                                                //               0.5.w,
                                                                //           top: 0.3.h,
                                                                //           bottom:
                                                                //               0.3.h),
                                                                //   decoration: BoxDecoration(
                                                                //       color: Color(
                                                                //           0XFFFF5959),
                                                                //       borderRadius:
                                                                //           BorderRadius
                                                                //               .circular(
                                                                //                   5.w)),
                                                                //   child: Icon(
                                                                //     Icons
                                                                //         .delete_rounded,
                                                                //     color:
                                                                //         Colors.white,
                                                                //     size: 1.5.h,
                                                                //   ),
                                                                // ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Customer : ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        10.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    color: isDarkMode()
                                                                        ? white
                                                                        : black,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    item
                                                                        .customerInfo
                                                                        .name
                                                                        .capitalize
                                                                        .toString(),
                                                                    maxLines: 1,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize: SizerUtil.deviceType == DeviceType.mobile
                                                                            ? 9
                                                                                .sp
                                                                            : 7
                                                                                .sp,
                                                                        color: isDarkMode()
                                                                            ? white
                                                                            : black,
                                                                        fontFamily:
                                                                            fontRegular),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "Duration : ",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          10.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      color: isDarkMode()
                                                                          ? white
                                                                          : black,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    item.duration
                                                                        .toString(),
                                                                    maxLines:
                                                                        null,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize: SizerUtil.deviceType == DeviceType.mobile
                                                                            ? 9
                                                                                .sp
                                                                            : 7
                                                                                .sp,
                                                                        color: isDarkMode()
                                                                            ? white
                                                                            : black,
                                                                        fontFamily:
                                                                            fontRegular),
                                                                  ),
                                                                ]),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top: 0.5
                                                                              .h),
                                                                  child: Text(
                                                                    //  data.title,
                                                                    formatTime(selectedData
                                                                        .timeOfAppointment
                                                                        .toString()),

                                                                    style: TextStyle(
                                                                        color: isDarkMode()
                                                                            ? white
                                                                            : black,
                                                                        fontFamily:
                                                                            opensansMedium,
                                                                        fontSize: 10
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )),
                                      ]),
                                ),
                              );
                            },
                          ),
                        )),
                      ]),
                ),
              ],
            );
          });
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "No any appointment for this date",
            style: TextStyle(
                fontFamily: fontMedium,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode() ? white : black),
          ),
          SizedBox(
            height: 1.h,
          ),
          GestureDetector(
            onTap: () {
              Get.to(AppointmentBookingScreen(
                      selectedDate:
                          controller.homeFormatTime(formattedDate.toString())))
                  ?.then((value) {
                if (value == true) {
                  logcat("HOMEEE", "DONE");
                  controller.getHomeList(
                      context,
                      formattedDate != null
                          ? formattedDate.toString()
                          : Common().getCurrentDate());
                }
              });
            },
            child: Container(
              height: 5.h,
              width: 35.w,
              padding:
                  EdgeInsets.only(top: 1.h, bottom: 1.h, left: 1.w, right: 1.w),
              child: Center(
                  child: Text(
                "Add Appointment",
                style: TextStyle(
                    color: isDarkMode() ? white : white, fontSize: 10.sp),
              )),
              decoration: BoxDecoration(
                color: isDarkMode() ? black : black,
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(color: isDarkMode() ? white : black),
              ),
            ),
          )
        ],
      );
    }
  }
}
