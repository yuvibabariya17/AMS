import 'package:booking_app/Models/AppointmentListModel.dart';
import 'package:booking_app/Screens/BookingAppointmentScreen/AppointmentBooking.dart';
import 'package:booking_app/controllers/UpcomingAppointment_controller.dart';
import 'package:booking_app/core/Common/Common.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../core/constants/assets.dart';
import '../../core/themes/color_const.dart';
import '../../core/themes/font_constant.dart';

class UpcomingAppointment extends StatefulWidget {
  UpcomingAppointment({
    super.key,
  });

  @override
  State<UpcomingAppointment> createState() => _UpcomingAppointmentState();
}

class _UpcomingAppointmentState extends State<UpcomingAppointment> {
  var controller = Get.put(UpcomingAppointmentController());
  bool btn = false;

  @override
  void initState() {
    logcat("CLEARLIST", "data");
    controller.appointmentObjectList.clear();
    controller.getAppointmentList(
      context,
      true,
    );
    logcat("APPOINTMENT_LENGTH",
        controller.appointmentObjectList.length.toString());
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    logcat("DISPOSE", "DISPOSE");
    controller.appointmentObjectList.clear();
    setState(() {});
    super.dispose();
  }

  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }

  String formatTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('h:mm a').format(dateTime);
    return formattedDate;
  }

  void main() {
    String backendFromDate = '2023-07-01T00:00:00.704Z';
    String backendToDate = '2023-08-15T00:00:00.704Z';
    String formattedFromDate = formatDate(backendFromDate);
    String formattedToDate = formatDate(backendToDate);
    String formattedDates = '$formattedFromDate To $formattedToDate';
    print(formattedDates); // Output: 01-07-2023 To 15-08-2023
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        controller.hideKeyboard(context);
      }),
      child: Container(
        child: RefreshIndicator(
          color: isDarkMode() ? white : black,
          onRefresh: () {
            return Future.delayed(
              const Duration(seconds: 1),
              () {
                //controller.appointmentObjectList.clear();
                controller.getAppointmentList(context, true);
              },
            );
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Obx(() {
                  switch (controller.state.value) {
                    case ScreenState.apiLoading:
                    case ScreenState.noNetwork:
                    case ScreenState.noDataFound:
                    case ScreenState.apiError:
                      return Container(
                        // margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                        height: SizerUtil.height / 1.5,
                        child: apiOtherStates(controller.state.value),
                      );
                    case ScreenState.apiSuccess:
                      return Container(
                          // margin:
                          //     EdgeInsets.only(bottom: 3.h, top: 2.h),
                          child: apiSuccess(controller.state.value));
                    default:
                      Container();
                  }
                  return Container();
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget apiSuccess(ScreenState state) {
    logcat("LENGTH", controller.appointmentObjectList.length.toString());
    // ignore: unrelated_type_quality_checks
    if (controller.state == ScreenState.apiSuccess &&
        controller.appointmentObjectList.isNotEmpty) {
      return controller.appointmentObjectList.isNotEmpty
          ? Container(
              child: SizedBox(
              height: SizerUtil.height,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                      bottom: SizerUtil.deviceType == DeviceType.mobile
                          ? 35.h
                          : 32.h),
                  clipBehavior: Clip.antiAlias,
                  itemBuilder: (context, index) {
                    //ProductItem data = controller.staticData[index];
                    ListofAppointment data =
                        controller.appointmentObjectList[index];
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: SizerUtil.deviceType == DeviceType.mobile
                                  ? 7.w
                                  : 10.w,
                              right: SizerUtil.deviceType == DeviceType.mobile
                                  ? 7.w
                                  : 10.w,
                              bottom: SizerUtil.deviceType == DeviceType.mobile
                                  ? 1.h
                                  : 2.h,
                              top: SizerUtil.deviceType == DeviceType.mobile
                                  ? 1.h
                                  : 2.h),
                          padding: EdgeInsets.only(
                              top: SizerUtil.deviceType == DeviceType.mobile
                                  ? 2.h
                                  : 1.h,
                              left: SizerUtil.deviceType == DeviceType.mobile
                                  ? 4.w
                                  : 3.w,
                              right: SizerUtil.deviceType == DeviceType.mobile
                                  ? 4.w
                                  : 3.w,
                              bottom: SizerUtil.deviceType == DeviceType.mobile
                                  ? 2.h
                                  : 1.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(children: [
                                Text(
                                  //  data.title,
                                  Details.date,
                                  style: TextStyle(
                                      color: isDarkMode() ? white : black,
                                      fontFamily: opensansMedium,
                                      fontSize: SizerUtil.deviceType ==
                                              DeviceType.mobile
                                          ? 12.sp
                                          : 8.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                Container(
                                  child: Text(
                                    formatDate(
                                        data.dateOfAppointment.toString()),
                                    style: TextStyle(
                                        color: isDarkMode() ? white : black,
                                        fontFamily: opensansMedium,
                                        fontSize: SizerUtil.deviceType ==
                                                DeviceType.mobile
                                            ? 10.sp
                                            : 7.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(AppointmentBookingScreen(
                                            isEdit: true,
                                            editAppointment: data))
                                        ?.then((value) {
                                      if (value == true) {
                                        controller.getAppointmentList(
                                            context, false,
                                            isClearList: true);
                                      }
                                    });
                                  },
                                  child: Container(
                                    child: SvgPicture.asset(
                                      Asset.edit,
                                      height: SizerUtil.deviceType ==
                                              DeviceType.mobile
                                          ? 2.3.h
                                          : 2.5.h,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ]),
                              // SizedBox(
                              //   height: 1.h,
                              // ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              Details.time,
                                              style: TextStyle(
                                                  color: isDarkMode()
                                                      ? white
                                                      : black,
                                                  fontFamily: opensansMedium,
                                                  fontSize:
                                                      SizerUtil.deviceType ==
                                                              DeviceType.mobile
                                                          ? 12.sp
                                                          : 8.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Container(
                                              child: Text(
                                                formatTime(data
                                                    .appointmentSlotInfo
                                                    .timeOfAppointment
                                                    .toString()),
                                                style: TextStyle(
                                                    color: isDarkMode()
                                                        ? white
                                                        : black,
                                                    fontFamily: opensansMedium,
                                                    fontSize: SizerUtil
                                                                .deviceType ==
                                                            DeviceType.mobile
                                                        ? 10.sp
                                                        : 7.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              Details.customer,
                                              style: TextStyle(
                                                  color: isDarkMode()
                                                      ? white
                                                      : black,
                                                  fontFamily: opensansMedium,
                                                  fontSize:
                                                      SizerUtil.deviceType ==
                                                              DeviceType.mobile
                                                          ? 12.sp
                                                          : 8.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Expanded(
                                              child: Text(
                                                data.customerInfo.name
                                                    .capitalize
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: isDarkMode()
                                                        ? white
                                                        : black,
                                                    fontFamily: opensansMedium,
                                                    fontSize: SizerUtil
                                                                .deviceType ==
                                                            DeviceType.mobile
                                                        ? 10.sp
                                                        : 7.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                Details.appointment_type,
                                                style: TextStyle(
                                                    color: isDarkMode()
                                                        ? white
                                                        : black,
                                                    fontFamily: opensansMedium,
                                                    fontSize: SizerUtil
                                                                .deviceType ==
                                                            DeviceType.mobile
                                                        ? 12.sp
                                                        : 8.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Expanded(
                                                child: Container(
                                                    child: Text(
                                                  data.appointmentType
                                                      .capitalize
                                                      .toString(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: isDarkMode()
                                                          ? white
                                                          : black,
                                                      fontFamily:
                                                          opensansMedium,
                                                      fontSize: SizerUtil
                                                                  .deviceType ==
                                                              DeviceType.mobile
                                                          ? 10.sp
                                                          : 7.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                              ),
                                            ]),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: 1.h,
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    color: isDarkMode() ? white : black,
                                    Asset.user,
                                    height: SizerUtil.deviceType ==
                                            DeviceType.mobile
                                        ? 1.8.h
                                        : 2.h,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    data.vendorInfo.userName,
                                    style: TextStyle(
                                        color: isDarkMode() ? white : black,
                                        fontFamily: opensansMedium,
                                        fontSize: SizerUtil.deviceType ==
                                                DeviceType.mobile
                                            ? 12.sp
                                            : 8.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Common().commonDeleteDialog(
                                          context, "Appointment", () {
                                        controller.deleteAppointment(
                                            context, data.id);
                                      });
                                    },
                                    child: Container(
                                      height: SizerUtil.deviceType ==
                                              DeviceType.mobile
                                          ? 4.h
                                          : 3.5.h,
                                      width: SizerUtil.deviceType ==
                                              DeviceType.mobile
                                          ? 20.w
                                          : 15.w,
                                      child: Center(
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            fontSize: SizerUtil.deviceType ==
                                                    DeviceType.mobile
                                                ? 12.sp
                                                : 7.sp,
                                            color: isDarkMode() ? black : white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: isDarkMode() ? white : black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: isDarkMode()
                                                  ? Colors.white
                                                      .withOpacity(0.2)
                                                  : Colors.black
                                                      .withOpacity(0.2),
                                              spreadRadius: 0.1,
                                              blurRadius: 10,
                                              offset: Offset(0.5, 0.5)),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Container(
                                  //   child: CupertinoSwitch(
                                  //     value: btn,
                                  //     onChanged: (value) {
                                  //       btn = value;
                                  //       setState(
                                  //         () {},
                                  //       );
                                  //     },
                                  //     thumbColor: CupertinoColors.white,
                                  //     activeColor: CupertinoColors.black,
                                  //     trackColor: Colors.grey,
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   width: 1.w,
                                  // ),
                                  // Text(
                                  //   'Remind me',
                                  //   style: TextStyle(
                                  //     color: isDarkMode() ? white : black,
                                  //   ),
                                  // ),
                                  // Container(
                                  //   child: Icon(
                                  //     Icons.arrow_drop_down,
                                  //     color: isDarkMode() ? white : black,
                                  //   ),
                                  // ),
                                  // Spacer(),
                                ],
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: isDarkMode() ? black : white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: isDarkMode()
                                      ? Colors.white.withOpacity(0.2)
                                      : Colors.black.withOpacity(0.2),
                                  spreadRadius: 0.1,
                                  blurRadius: 10,
                                  offset: Offset(0.5, 0.5)),
                            ],
                          ),
                        ),
                        // index == controller.appointmentObjectList.length - 1 &&
                        //         controller.currentPags.value <
                        //             controller.totalPages.value
                        //     ? ElevatedButton(
                        //         onPressed: () {
                        //           controller.currentPags.value++;
                        //           controller.getAppointmentList(context,
                        //                false);
                        //           setState(() {});
                        //         },
                        //         child: Text(Details.loadMore),
                        //       )
                        //     : Container()
                      ],
                    );
                  },
                  itemCount: controller.appointmentObjectList.length),
            ))
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 31.h),
                  child: Text(
                    CommonConstant.noDataFound,
                    style: TextStyle(
                        fontFamily: fontMedium,
                        fontSize: 12.sp,
                        color: isDarkMode() ? white : black),
                  ),
                ),
              ],
            ));
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 31.h),
            child: Text(
              CommonConstant.noDataFound,
              style: TextStyle(
                  fontFamily: fontMedium,
                  fontSize: 12.sp,
                  color: isDarkMode() ? white : black),
            ),
          ),
        ],
      );
    }
  }

  Widget apiOtherStates(state) {
    if (state == ScreenState.apiLoading) {
      // SHIMMER EFFECT

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

    Widget? button;
    // if (controller.filterList.isEmpty) {
    //   Container();
    // }
    if (state == ScreenState.noDataFound) {
      button = getMiniButton(() {
        Get.back();
      }, "Back");
    }
    if (state == ScreenState.noNetwork) {
      button = getMiniButton(() {
        controller.appointmentObjectList.clear();
        controller.getAppointmentList(context, true);
      }, "Try Again");
    }

    if (state == ScreenState.apiError) {
      button = getMiniButton(() {
        Get.back();
      }, "Back");
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

  getMiniButton(
    Function fun,
    str,
  ) {
    return InkWell(
      onTap: () {
        fun();
      },
      child: Container(
        height: SizerUtil.deviceType == DeviceType.mobile ? 5.h : 4.5.h,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 1),
        width: SizerUtil.width / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: lightPrimaryColor,
          boxShadow: [
            BoxShadow(
                color: primaryColor.withOpacity(0.2),
                blurRadius: 10.0,
                offset: const Offset(0, 1),
                spreadRadius: 3.0)
          ],
        ),
        child: Text(
          str,
          style: TextStyle(
              color: Colors.white,
              fontFamily: fontBold,
              fontSize:
                  SizerUtil.deviceType == DeviceType.mobile ? 11.sp : 8.sp),
        ),
      ),
    );
  }

  Future<void> showDeleteConfirmationDialog(String serviceId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoTheme(
          data: CupertinoThemeData(
            brightness: isDarkMode()
                ? Brightness.dark
                : Brightness.light, // Set the brightness to light
            scaffoldBackgroundColor:
                Colors.white, // Set the background color to white
            textTheme: CupertinoTextThemeData(
              textStyle:
                  TextStyle(color: Colors.black), // Set text color to black
            ),
          ),
          child: CupertinoAlertDialog(
            title: Text('Confirm Delete',
                style: TextStyle(
                    fontSize: 17.sp, color: isDarkMode() ? white : black)),
            content: Text('Are you sure you want to cancel this Appointment?',
                style: TextStyle(
                    fontSize: 12.sp, color: isDarkMode() ? white : black)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('No',
                    style: TextStyle(
                        fontSize: 11.sp, color: isDarkMode() ? white : black)),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    if (mounted) {
                      await Future.delayed(const Duration(seconds: 0))
                          .then((value) {
                        controller.deleteAppointment(context, serviceId);
                      });
                    }
                  } catch (e) {
                    logcat("ERROR", e);
                  }

                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  'Yes',
                  style: TextStyle(
                      color: isDarkMode() ? white : black, fontSize: 11.sp),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
