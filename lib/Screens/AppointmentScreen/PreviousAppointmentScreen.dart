import 'package:booking_app/Models/AppointmentListModel.dart';
import 'package:booking_app/controllers/PreviousAppointment_controller.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../Models/notification_model.dart';
import '../../Models/notification_Static.dart';
import '../../core/constants/assets.dart';
import '../../core/themes/font_constant.dart';
import '../../core/utils/helper.dart';

class PreviousAppointmentScreen extends StatefulWidget {
  const PreviousAppointmentScreen({super.key});

  @override
  State<PreviousAppointmentScreen> createState() =>
      _PreviousAppointmentScreenState();
}

class _PreviousAppointmentScreenState extends State<PreviousAppointmentScreen> {
  var controller = Get.put(PreviousAppointmentController());
  List<NotificationItem> staticData = notificationItems;
  bool btn = false;

  @override
  void initState() {
    controller.getAppointmentList(context);
    super.initState();
  }

  String formatDate(String dateTimeString) {
    // Parse the date string into a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format the DateTime object into the desired format
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

    return formattedDate;
  }

  String formatTime(String dateTimeString) {
    // Parse the date string into a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format the DateTime object into the desired format
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
                controller.getAppointmentList(context);
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
              // margin: EdgeInsets.only(
              //   left: 5.w,
              //   right: 5.w,
              // ),
              // padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
              child: SizedBox(
              height: SizerUtil.height,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 35.h),
                  clipBehavior: Clip.antiAlias,
                  itemBuilder: (context, index) {
                    //ProductItem data = controller.staticData[index];
                    ListofAppointment data =
                        controller.appointmentObjectList[index];
                    return Container(
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
                              ? 3.h
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
                              "Date : ",
                              style: TextStyle(
                                  color: isDarkMode() ? white : black,
                                  fontFamily: opensansMedium,
                                  fontSize:
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? 12.sp
                                          : 8.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                            Container(
                              child: Text(
                                //  data.title,
                                formatDate(data.dateOfAppointment.toString()),

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
                          ]),

                          // Text(
                          //   "Date : " +
                          //       formatDate(data.dateOfAppointment.toString()),
                          //   style: TextStyle(
                          //     fontFamily: opensansMedium,
                          //     fontWeight: FontWeight.w700,
                          //     fontSize: 14.sp,
                          //     color: isDarkMode() ? white : black,
                          //   ),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          //  data.title,
                                          "Time : ",
                                          style: TextStyle(
                                              color:
                                                  isDarkMode() ? white : black,
                                              fontFamily: opensansMedium,
                                              fontSize: SizerUtil.deviceType ==
                                                      DeviceType.mobile
                                                  ? 12.sp
                                                  : 8.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Container(
                                          child: Text(
                                            //  data.title,
                                            formatTime(data.appointmentSlotInfo
                                                .timeOfAppointment
                                                .toString()),

                                            style: TextStyle(
                                                color: isDarkMode()
                                                    ? white
                                                    : black,
                                                fontFamily: opensansMedium,
                                                fontSize:
                                                    SizerUtil.deviceType ==
                                                            DeviceType.mobile
                                                        ? 10.sp
                                                        : 7.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          //  data.title,
                                          "Customer : ",
                                          style: TextStyle(
                                              color:
                                                  isDarkMode() ? white : black,
                                              fontFamily: opensansMedium,
                                              fontSize: SizerUtil.deviceType ==
                                                      DeviceType.mobile
                                                  ? 12.sp
                                                  : 8.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Container(
                                          child: Text(
                                            //  data.title,
                                            data.customerInfo.name,

                                            style: TextStyle(
                                                color: isDarkMode()
                                                    ? white
                                                    : black,
                                                fontFamily: opensansMedium,
                                                fontSize:
                                                    SizerUtil.deviceType ==
                                                            DeviceType.mobile
                                                        ? 10.sp
                                                        : 7.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(children: [
                                      Text(
                                        //  data.title,
                                        "Appointment Type : ",
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
                                        //  data.title,
                                        data.appointmentType,
                                        // data.vendorInfo != null
                                        //     ? data.vendorInfo.emailId.toString()
                                        //     : "",
                                        style: TextStyle(
                                            color: isDarkMode() ? white : black,
                                            fontFamily: opensansMedium,
                                            fontSize: SizerUtil.deviceType ==
                                                    DeviceType.mobile
                                                ? 10.sp
                                                : 7.sp,
                                            fontWeight: FontWeight.w500),
                                      )),
                                    ]),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                color: isDarkMode() ? white : black,
                                Asset.user,
                                height:
                                    SizerUtil.deviceType == DeviceType.mobile
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
                              data.isFinished == true
                                  ? GestureDetector(
                                      onTap: () {
                                        showDeleteConfirmationDialog(data.id);
                                      },
                                      child: Container(
                                        height: SizerUtil.deviceType ==
                                                DeviceType.mobile
                                            ? 4.h
                                            : 4.5.h,
                                        width: 20.w,
                                        child: Center(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                              color:
                                                  isDarkMode() ? black : white,
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
                                  : Container()
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

      // return Shimmer.fromColors(
      //   baseColor: Colors.grey[300]!,
      //   highlightColor: Colors.grey[100]!,
      //   child: Column(
      //     children: [
      //       Container(
      //         // margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
      //         height: SizerUtil.height / 1.5, // Adjust the height as needed
      //         color: Colors.white, // Placeholder color
      //       ),
      //     ],
      //   ),
      // );

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
        controller.getAppointmentList(
          context,
        );
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
        return CupertinoAlertDialog(
          title: Text('Confirm Delete', style: TextStyle(fontSize: 17.sp)),
          content: Text('Are you sure you want to cancel this Appointment?',
              style: TextStyle(
                  fontSize: 12.sp, color: isDarkMode() ? white : white)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No',
                  style: TextStyle(
                      fontSize: 11.sp, color: isDarkMode() ? white : white)),
            ),
            TextButton(
              onPressed: () {
                controller.deleteAppointment(context, serviceId);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Yes',
                style: TextStyle(
                    color: isDarkMode() ? white : white, fontSize: 11.sp),
              ),
            ),
          ],
        );
      },
    );
  }
}
