import 'package:booking_app/Config/apicall_constant.dart';
import 'package:booking_app/Models/StudentCourseListModel.dart';
import 'package:booking_app/Screens/StudentScreen/AddStudentCourseScreen.dart';
import 'package:booking_app/controllers/StudentCourse_controller.dart';
import 'package:booking_app/core/Common/Common.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:booking_app/preference/UserPreference.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:sizer/sizer.dart';
import '../../core/Common/toolbar.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/strings.dart';
import '../../core/themes/color_const.dart';
import '../../core/themes/font_constant.dart';
import '../../core/utils/helper.dart';
import '../../core/utils/log.dart';

class StudentCourseScreen extends StatefulWidget {
  const StudentCourseScreen({super.key});

  @override
  State<StudentCourseScreen> createState() => _StudentCourseScreenState();
}

class _StudentCourseScreenState extends State<StudentCourseScreen> {
  final controller = Get.put(StudentCourseController());

  TextEditingController search = TextEditingController();

  @override
  void initState() {
    controller.getStudentCourseList(context, true);
    controller.filteredStudentObjectList = controller.studentObjectList;
    getIp();
    super.initState();
  }

  String ip = '';

  getIp() async {
    ip = await UserPreferences().getBuildIP();
    logcat("IMAGE_URL", ip.toString());
    setState(() {});
  }

  void filterServiceList(String query) {
    setState(() {
      if (query.isEmpty) {
        controller.filteredStudentObjectList = controller.studentObjectList;
      } else {
        controller.filteredStudentObjectList = controller.studentObjectList
            .where((data) =>
                data.fees
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                data.courseInfo.name
                    .toString()
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  // void filterServiceList(String query) {
  //   setState(() {
  //     if (query.isEmpty) {
  //       controller.filteredServiceObjectList = controller.serviceObjectList;
  //     } else {
  //       controller.filteredServiceObjectList = controller.serviceObjectList
  //           .where((data) =>
  //               data.categoryInfo!.name
  //                   .toLowerCase()
  //                   .contains(query.toLowerCase()) ||
  //               data.vendorInfo.userName
  //                   .toString()
  //                   .toLowerCase()
  //                   .contains(query.toLowerCase()))
  //           .toList();
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        controller.hideKeyboard(context);
      }),
      child: CustomScaffold(
          isListScreen: true,
          floatingActionBtn: Container(
            width: 7.h,
            height: 7.h,
            margin: EdgeInsets.only(bottom: 2.h, right: 3.5.w),
            child: FloatingActionButton(
                backgroundColor: isDarkMode() ? white : black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                onPressed: () {
                  Get.to(AddStudentCourseScreen())?.then((value) {
                    if (value == true) {
                      logcat("ISDONE", "DONE");
                      controller.getStudentCourseList(context, false);
                    }
                  });
                },
                child: Icon(
                  Icons.add,
                  color: isDarkMode() ? black : white,
                  size: SizerUtil.deviceType == DeviceType.mobile ? null : 3.h,
                )),
          ),
          body: Column(children: [
            getCommonToolbar("Student Course", () {
              Get.back();
            }),
            Container(
              margin: EdgeInsets.only(
                top: SizerUtil.deviceType == DeviceType.mobile ? 3.h : 2.5.h,
                left: SizerUtil.deviceType == DeviceType.mobile ? 1.0.w : 0.3.w,
                right:
                    SizerUtil.deviceType == DeviceType.mobile ? 1.0.w : 0.3.w,
              ),
              padding: EdgeInsets.only(
                left: SizerUtil.deviceType == DeviceType.mobile ? 7.0.w : 6.w,
                right: SizerUtil.deviceType == DeviceType.mobile ? 7.0.w : 6.w,
              ),
              child: Container(
                height: 5.5.h,
                child: TextField(
                  onChanged: ((value) {
                    filterServiceList(value);
                  }),
                  style: TextStyle(color: isDarkMode() ? white : black),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        top: SizerUtil.deviceType == DeviceType.mobile
                            ? 1.h
                            : 1.2.h,
                        left: 2.h,
                        bottom: SizerUtil.deviceType == DeviceType.mobile
                            ? 1.h
                            : 1.2.h,
                      ),
                      hintText: CommonConstant.search,
                      hintStyle: TextStyle(
                        color: isDarkMode() ? white : black,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: isDarkMode() ? white : black)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: isDarkMode() ? white : black)),
                      suffixIcon: Padding(
                          padding: EdgeInsets.only(
                            right: SizerUtil.deviceType == DeviceType.mobile
                                ? 0.0
                                : 2.w,
                          ),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.search_sharp,
                                color: isDarkMode() ? white : black,
                                size: SizerUtil.deviceType == DeviceType.mobile
                                    ? null
                                    : 3.h,
                              )))),
                  controller: search,
                  cursorColor: isDarkMode() ? white : black,
                  keyboardType: TextInputType.name,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: RefreshIndicator(
                  color: isDarkMode() ? white : black,
                  onRefresh: () {
                    return Future.delayed(
                      const Duration(seconds: 1),
                      () {
                        controller.getStudentCourseList(context, true);
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
                                margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                                height: SizerUtil.height / 1.5,
                                child: apiOtherStates(controller.state.value),
                              );
                            case ScreenState.apiSuccess:
                              return Container(
                                  margin:
                                      EdgeInsets.only(bottom: 3.h, top: 2.h),
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
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         Container(
            //           width: 6.1.h,
            //           height: 6.1.h,
            //           margin: EdgeInsets.only(bottom: 5.h, right: 7.w),
            //           child: RawMaterialButton(
            //             fillColor: isDarkMode() ? white : black,
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.all(Radius.circular(15))),
            //             onPressed: () {
            //               Get.to(const AddServiceScreen())?.then((value) {
            //                 if (value == true) {
            //                   controller.getServiceList(
            //                     context,
            //                   );
            //                 }
            //               });
            //             },
            //             child: Icon(
            //               Icons.add,
            //               size: 3.5.h,
            //               color: isDarkMode() ? black : white,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ],
            // )
          ])),
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
            content: Text(
                'Are you sure you want to delete this Student Course?',
                style: TextStyle(
                    fontSize: 12.sp, color: isDarkMode() ? white : black)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Cancel',
                    style: TextStyle(
                        fontSize: 11.sp, color: isDarkMode() ? white : black)),
              ),
              TextButton(
                onPressed: () {
                  controller.deleteStudentCourseList(context, serviceId);
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

  Widget apiSuccess(ScreenState state) {
    logcat("LENGTH", controller.studentObjectList.length.toString());
    // ignore: unrelated_type_quality_checks
    if (controller.state == ScreenState.apiSuccess &&
        controller.filteredStudentObjectList.isNotEmpty) {
      return Container(
          margin: EdgeInsets.only(
            left: SizerUtil.deviceType == DeviceType.mobile ? 8.w : 6.3.w,
            right: SizerUtil.deviceType == DeviceType.mobile ? 8.w : 6.3.w,
          ),
          child: getStudentCourseList());
    } else {
      return Container(
        height: SizerUtil.height / 1.3,
        child: Center(
          child: Container(
            child: Text(
              CommonConstant.noDataFound,
              style: TextStyle(
                  fontFamily: fontMedium,
                  fontSize: 12.sp,
                  color: isDarkMode() ? white : black),
            ),
          ),
        ),
      );
    }
  }

  getStudentCourseList() {
    return GridView.builder(
      shrinkWrap: true,
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.only(bottom: 35.h),
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Adjust the number of columns as needed
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: SizerUtil.deviceType == DeviceType.mobile ? 1.0 : 1.3,
      ),
      itemBuilder: (context, index) {
        ListofStudentCourse data = controller.filteredStudentObjectList[index];
        return Container(
          padding: EdgeInsets.only(
            left: SizerUtil.deviceType == DeviceType.mobile ? 1.5.w : 1.w,
            right: SizerUtil.deviceType == DeviceType.mobile ? 1.5.w : 1.w,
          ),
          decoration: BoxDecoration(
            color: isDarkMode() ? black : white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: isDarkMode()
                    ? Colors.white.withOpacity(0.2)
                    : Colors.black.withOpacity(0.2),
                spreadRadius: 0.1,
                blurRadius: 10,
                offset: Offset(0.5, 0.5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      getStudentCourseDetails(context, data);

                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return AlertDialog(
                      //       insetPadding: EdgeInsets.symmetric(
                      //           vertical: 15.h, horizontal: 4.h),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(
                      //             20.0), // Adjust the radius as needed
                      //       ),
                      //       elevation: 0.0, // No shadow
                      //       //clipBehavior: Clip.antiAlias,
                      //       backgroundColor: isDarkMode() ? black : white,
                      //       content: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Container(
                      //             height: 3.h,
                      //             child: Row(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.center,
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.center,
                      //                 children: [
                      //                   Container(
                      //                     width: 55.w,
                      //                     child: Marquee(
                      //                       style: TextStyle(
                      //                         fontFamily: fontRegular,
                      //                         color:
                      //                             isDarkMode() ? white : black,
                      //                         fontSize: SizerUtil.deviceType ==
                      //                                 DeviceType.mobile
                      //                             ? 16.sp
                      //                             : 10.sp,
                      //                       ),
                      //                       text: "STUDENT COURSE DETAILS",
                      //                       scrollAxis: Axis
                      //                           .horizontal, // Use Axis.vertical for vertical scrolling
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment
                      //                               .start, // Adjust as needed
                      //                       blankSpace:
                      //                           20.0, // Adjust the space between text repetitions
                      //                       velocity:
                      //                           50.0, // Adjust the scrolling speed
                      //                       pauseAfterRound: const Duration(
                      //                           seconds:
                      //                               1), // Time to pause after each scroll
                      //                       startPadding: 2
                      //                           .w, // Adjust the initial padding
                      //                       accelerationDuration: const Duration(
                      //                           seconds:
                      //                               1), // Duration for acceleration
                      //                       accelerationCurve: Curves
                      //                           .linear, // Acceleration curve
                      //                       decelerationDuration: const Duration(
                      //                           milliseconds:
                      //                               500), // Duration for deceleration
                      //                       decelerationCurve: Curves
                      //                           .easeOut, // Deceleration curve
                      //                     ),
                      //                   ),
                      //                   Spacer(),
                      //                   Align(
                      //                     alignment: Alignment.topRight,
                      //                     child: GestureDetector(
                      //                       onTap: () {
                      //                         Navigator.of(context).pop();
                      //                       },
                      //                       child: Icon(
                      //                         Icons.cancel,
                      //                         size: 24.0,
                      //                         color:
                      //                             isDarkMode() ? white : black,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ]),
                      //           ),
                      //           Divider(
                      //             color: Colors.grey,
                      //           ),
                      //           SizedBox(
                      //             height: 1.h,
                      //           ),
                      //           Column(
                      //             // mainAxisAlignment: MainAxisAlignment.start,
                      //             crossAxisAlignment: CrossAxisAlignment.center,
                      //             children: [
                      //               Container(
                      //                   height: 20.h,
                      //                   width: 60.w,
                      //                   // padding: EdgeInsets.all(
                      //                   //   SizerUtil.deviceType == DeviceType.mobile
                      //                   //       ? 1.2.w
                      //                   //       : 1.0.w,
                      //                   // ),
                      //                   child: ClipRRect(
                      //                     borderRadius: const BorderRadius.all(
                      //                         Radius.circular(15)),
                      //                     child: CachedNetworkImage(
                      //                       fit: BoxFit.cover,
                      //                       imageUrl: data
                      //                                   .idProofUrlInfo.image !=
                      //                               null
                      //                           ? '${ApiUrl.ImgUrl}${data.idProofUrlInfo.image}'
                      //                           // '${ip}${data.photoUrlInfo.image}'
                      //                           : "",
                      //                       placeholder: (context, url) =>
                      //                           const Center(
                      //                         child: CircularProgressIndicator(
                      //                             color: primaryColor),
                      //                       ),
                      //                       errorWidget:
                      //                           (context, url, error) =>
                      //                               Image.asset(
                      //                         Asset.placeholder,
                      //                         height: 11.h,
                      //                         fit: BoxFit.cover,
                      //                       ),
                      //                     ),
                      //                   )),
                      //               SizedBox(
                      //                 height: 2.h,
                      //               ),
                      //               Row(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.start,
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text(
                      //                     "Course Name : ",
                      //                     style: TextStyle(
                      //                       fontSize: 12.sp,
                      //                       fontWeight: FontWeight.w800,
                      //                       color: isDarkMode() ? white : black,
                      //                     ),
                      //                   ),
                      //                   Expanded(
                      //                     child: Text(
                      //                       data.courseInfo.name.capitalize
                      //                           .toString(),
                      //                       overflow: TextOverflow.ellipsis,
                      //                       maxLines: 3,
                      //                       textAlign: TextAlign.start,
                      //                       style: TextStyle(
                      //                           fontSize:
                      //                               SizerUtil.deviceType ==
                      //                                       DeviceType.mobile
                      //                                   ? 12.sp
                      //                                   : 10.sp,
                      //                           color: isDarkMode()
                      //                               ? white
                      //                               : black,
                      //                           fontFamily: fontRegular),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ],
                      //           ),
                      //           SizedBox(
                      //             height: 1.h,
                      //           ),
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             crossAxisAlignment: CrossAxisAlignment.center,
                      //             children: [
                      //               Text(
                      //                 "Course Fee : ",
                      //                 style: TextStyle(
                      //                   fontSize: 12.sp,
                      //                   fontWeight: FontWeight.w800,
                      //                   color: isDarkMode() ? white : black,
                      //                 ),
                      //               ),
                      //               GestureDetector(
                      //                 onTap: () {
                      //                   // controller.launchPhoneCall(
                      //                   //     data.customerInfo.contactNo);
                      //                 },
                      //                 child: Text(
                      //                   '₹ ${data.courseInfo.fees.toString()}',
                      //                   maxLines: 1,
                      //                   overflow: TextOverflow.ellipsis,
                      //                   style: TextStyle(
                      //                       fontSize: SizerUtil.deviceType ==
                      //                               DeviceType.mobile
                      //                           ? 12.sp
                      //                           : 12.sp,
                      //                       color: isDarkMode() ? white : black,
                      //                       fontFamily: fontRegular),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //           SizedBox(
                      //             height: 1.h,
                      //           ),
                      //           Row(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.center,
                      //               children: [
                      //                 RichText(
                      //                   text: TextSpan(
                      //                     style: TextStyle(
                      //                       fontSize: 8.sp,
                      //                       fontWeight: FontWeight.w700,
                      //                       color: isDarkMode() ? white : black,
                      //                       fontFamily: fontBold,
                      //                     ),
                      //                     children: [
                      //                       TextSpan(
                      //                         text: 'Duration : ',
                      //                         style: TextStyle(
                      //                           fontSize: 12.sp,
                      //                           fontWeight: FontWeight.w800,
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 Text(
                      //                   data.courseInfo.duration.toString(),
                      //                   style: TextStyle(
                      //                       fontSize: SizerUtil.deviceType ==
                      //                               DeviceType.mobile
                      //                           ? 12.sp
                      //                           : 12.sp,
                      //                       color: isDarkMode() ? white : black,
                      //                       fontFamily: fontRegular),
                      //                 )
                      //               ]),
                      //           SizedBox(
                      //             height: 1.h,
                      //           ),
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Text(
                      //                 "Other Notes : ",
                      //                 style: TextStyle(
                      //                   fontSize: 12.sp,
                      //                   fontWeight: FontWeight.w800,
                      //                   color: isDarkMode() ? white : black,
                      //                 ),
                      //               ),
                      //               Expanded(
                      //                 child: Text(
                      //                   data.otherNotes.toString(),
                      //                   maxLines: 3,
                      //                   overflow: TextOverflow.ellipsis,
                      //                   textAlign: TextAlign.start,
                      //                   style: TextStyle(
                      //                       fontSize: SizerUtil.deviceType ==
                      //                               DeviceType.mobile
                      //                           ? 12.sp
                      //                           : 12.sp,
                      //                       color: isDarkMode() ? white : black,
                      //                       fontFamily: fontRegular),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // );

                      // // Get.to(FullScreenImage(
                      //   imageUrl:
                      //       '${ApiUrl.ImgUrl}${data.idProofUrlInfo.image}',
                      //   title: ScreenTitle.expert,
                      // ))!
                      //     .then(
                      //         (value) => {Common().trasparent_statusbar()});
                    },
                    child: Container(
                        height: SizerUtil.deviceType == DeviceType.mobile
                            ? 11.h
                            : 12.h,
                        width: 60.w,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: data.idProofUrlInfo.image != null
                                ? '${ApiUrl.ImgUrl}${data.idProofUrlInfo.image}'
                                : "",
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                  color: primaryColor),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              Asset.placeholder,
                              height: 11.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                  )
                ],
              ),
              // SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      data.courseInfo.name.capitalize.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDarkMode() ? white : black,
                        fontFamily: opensansMedium,
                        fontSize: SizerUtil.deviceType == DeviceType.mobile
                            ? 12.sp
                            : 10.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '₹ ${data.fees.toString()}',
                    style: TextStyle(
                      color: isDarkMode() ? white : black,
                      fontFamily: opensansMedium,
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? 11.sp
                          : 9.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.to(AddStudentCourseScreen(
                              isEdit: true, editStudentCourse: data))
                          ?.then((value) {
                        if (value == true) {
                          controller.getStudentCourseList(context, false);
                        }
                      });
                    },
                    child: Container(
                      child: SvgPicture.asset(
                        Asset.edit,
                        height: 2.3.h,
                        color: isDarkMode() ? Colors.grey : Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  GestureDetector(
                    onTap: () {
                      showDeleteConfirmationDialog(data.id);
                    },
                    child: Container(
                      child: Icon(
                        Icons.delete_rounded,
                        color: isDarkMode() ? Colors.grey : Colors.grey,
                        size: 3.h,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      itemCount: controller.filteredStudentObjectList.length,
    );
  }

  getStudentCourseDetails(BuildContext context, ListofStudentCourse data) {
    return Common().commonDetailsDialog(
      isDescription: true,
      context,
      "STUDENT COURSE DETAILS",
      Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 20.h,
              width: 60.w,
              // padding: EdgeInsets.all(
              //   SizerUtil.deviceType == DeviceType.mobile
              //       ? 1.2.w
              //       : 1.0.w,
              // ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: data.idProofUrlInfo.image != null
                      ? '${ApiUrl.ImgUrl}${data.idProofUrlInfo.image}'
                      // '${ip}${data.photoUrlInfo.image}'
                      : "",
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    Asset.placeholder,
                    height: 11.h,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Course Name : ",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  color: isDarkMode() ? white : black,
                ),
              ),
              Expanded(
                child: Text(
                  data.courseInfo.name.capitalize.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? 12.sp
                          : 10.sp,
                      color: isDarkMode() ? white : black,
                      fontFamily: fontRegular),
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
              Text(
                "Course Fee : ",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  color: isDarkMode() ? white : black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // controller.launchPhoneCall(
                  //     data.customerInfo.contactNo);
                },
                child: Text(
                  '₹ ${data.courseInfo.fees.toString()}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? 12.sp
                          : 12.sp,
                      color: isDarkMode() ? white : black,
                      fontFamily: fontRegular),
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
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode() ? white : black,
                      fontFamily: fontBold,
                    ),
                    children: [
                      TextSpan(
                        text: 'Duration : ',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  data.courseInfo.duration.toString(),
                  style: TextStyle(
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? 12.sp
                          : 12.sp,
                      color: isDarkMode() ? white : black,
                      fontFamily: fontRegular),
                )
              ]),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Other Notes : ",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  color: isDarkMode() ? white : black,
                ),
              ),
              Expanded(
                child: Container(
                  height: 10.h,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      data.otherNotes.toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: SizerUtil.deviceType == DeviceType.mobile
                              ? 12.sp
                              : 12.sp,
                          color: isDarkMode() ? white : black,
                          fontFamily: fontRegular),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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
      ));
    }

    // if (controller.filterList.isEmpty) {
    //   Container();
    // }
    if (state == ScreenState.noDataFound) {}
    if (state == ScreenState.noNetwork) {}

    if (state == ScreenState.apiError) {}
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
}
