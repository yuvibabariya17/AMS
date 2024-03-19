import 'package:booking_app/Models/HomeScreenModel.dart';
import 'package:booking_app/Screens/model.dart';
import 'package:booking_app/controllers/home_screen_controller.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ListScreen extends StatefulWidget {
  final HomeScreenController controller;
  ListScreen({Key? key, required this.controller}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    logcat("LISTTTT", hairserviceItems.length);
    super.initState();
    for (int index = 0;
        index < widget.controller.slotObjectList.length;
        index++) {
      String timeOfAppointment =
          widget.controller.slotObjectList[index].timeOfAppointment.toString();
      logcat("TIMEEEEE:::::", timeOfAppointment);
    }
  }

  String formatTime(String timeString) {
    // Parse the time string into a DateTime object
    DateTime dateTime = DateTime.parse(timeString);
    // Format the time into the desired format
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: widget.controller.slotObjectList.length,
      itemBuilder: (context, index) {
        // final data = hairserviceItems[index];
        AppointmentList selectedData = widget.controller.slotObjectList[index];
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
                            border:
                                Border.all(color: isDarkMode() ? white : black),
                          ),
                          child: Text(
                            formatTime(
                              widget.controller.slotObjectList[index]
                                  .timeOfAppointment
                                  .toString(),
                            ),

                            textAlign: TextAlign
                                .center, // Ensure item.time is not null
                            style: TextStyle(
                              color: isDarkMode() ? white : white,
                            ),
                          ),
                        ),
                        if (index < hairserviceItems.length - 1)
                          Container(
                            margin: EdgeInsets.only(
                              left: 5.5.w,
                            ),
                            height: 8.h,
                            color: Colors.grey,
                            width: 0.4.w,
                          )
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [Container()]
                            // data.details.map((serviceDetailData) {
                            //   return GestureDetector(
                            //     onTap: (() {
                            //       showDialog(
                            //         context: context,
                            //         builder: (BuildContext context) {
                            //           return AlertDialog(
                            //             insetPadding: EdgeInsets.symmetric(
                            //                 vertical: 20.h, horizontal: 5.h),
                            //             shape: RoundedRectangleBorder(
                            //               borderRadius: BorderRadius.circular(
                            //                   20.0), // Adjust the radius as needed
                            //             ),
                            //             elevation: 0.0, // No shadow
                            //             //clipBehavior: Clip.antiAlias,
                            //             backgroundColor:
                            //                 isDarkMode() ? black : white,
                            //             content: Column(
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.start,
                            //               children: [
                            //                 Row(
                            //                     mainAxisAlignment:
                            //                         MainAxisAlignment.center,
                            //                     children: [
                            //                       Expanded(
                            //                         child: Center(
                            //                           child: Text(
                            //                             // textAlign: TextAlign.center,
                            //                             serviceDetailData.title,
                            //                             style: TextStyle(
                            //                                 fontSize: 20.sp,
                            //                                 color: isDarkMode()
                            //                                     ? white
                            //                                     : black,
                            //                                 fontWeight:
                            //                                     FontWeight.bold),
                            //                           ),
                            //                         ),
                            //                       ),
                            //                       Align(
                            //                         alignment: Alignment.topRight,
                            //                         child: GestureDetector(
                            //                           onTap: () {
                            //                             Navigator.of(context)
                            //                                 .pop();
                            //                           },
                            //                           child: Icon(
                            //                             Icons.cancel,
                            //                             size: 24.0,
                            //                             color: isDarkMode()
                            //                                 ? white
                            //                                 : black,
                            //                           ),
                            //                         ),
                            //                       ),
                            //                     ]),
                            //                 Divider(
                            //                   color: Colors.grey,
                            //                 ),
                            //                 Column(
                            //                   // mainAxisAlignment: MainAxisAlignment.start,
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment.center,
                            //                   children: [
                            //                     Row(
                            //                       children: [
                            //                         Text(
                            //                           "Description : ",
                            //                           style: TextStyle(
                            //                             decoration: TextDecoration
                            //                                 .underline,
                            //                             fontSize: 12.sp,
                            //                             fontWeight:
                            //                                 FontWeight.w800,
                            //                             color: isDarkMode()
                            //                                 ? white
                            //                                 : black,
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                     Text(
                            //                       maxLines:
                            //                           null, // Allow unlimited lines
                            //                       softWrap: true,
                            //                       textAlign: TextAlign.justify,
                            //                       serviceDetailData.description,
                            //                       style: TextStyle(
                            //                           fontSize: SizerUtil
                            //                                       .deviceType ==
                            //                                   DeviceType.mobile
                            //                               ? 10.sp
                            //                               : 7.sp,
                            //                           color: isDarkMode()
                            //                               ? white
                            //                               : black,
                            //                           fontFamily: fontRegular),
                            //                     ),
                            //                   ],
                            //                 ),
                            //                 SizedBox(
                            //                   height: 1.h,
                            //                 ),
                            //                 Row(
                            //                     mainAxisAlignment:
                            //                         MainAxisAlignment.start,
                            //                     crossAxisAlignment:
                            //                         CrossAxisAlignment.center,
                            //                     children: [
                            //                       RichText(
                            //                         text: TextSpan(
                            //                           style: TextStyle(
                            //                             fontSize: 8.sp,
                            //                             fontWeight:
                            //                                 FontWeight.w700,
                            //                             color: isDarkMode()
                            //                                 ? white
                            //                                 : black,
                            //                             fontFamily: fontBold,
                            //                           ),
                            //                           children: [
                            //                             TextSpan(
                            //                               text: 'Duration : ',
                            //                               style: TextStyle(
                            //                                 fontSize: 12.sp,
                            //                                 decoration:
                            //                                     TextDecoration
                            //                                         .underline,
                            //                                 fontWeight:
                            //                                     FontWeight.w800,
                            //                               ),
                            //                             ),
                            //                           ],
                            //                         ),
                            //                       ),
                            //                       Text(
                            //                         serviceDetailData.duration,
                            //                         style: TextStyle(
                            //                             fontSize: SizerUtil
                            //                                         .deviceType ==
                            //                                     DeviceType.mobile
                            //                                 ? 10.sp
                            //                                 : 7.sp,
                            //                             color: isDarkMode()
                            //                                 ? white
                            //                                 : black,
                            //                             fontFamily: fontRegular),
                            //                       )
                            //                     ]),
                            //               ],
                            //             ),
                            //           );
                            //         },
                            //       );
                            //     }),
                            //     child: Row(children: [
                            //       Container(
                            //         margin: EdgeInsets.only(bottom: 7.h),
                            //         child: Row(
                            //           mainAxisAlignment: MainAxisAlignment.start,
                            //           children: [
                            //             Container(
                            //               child: SvgPicture.asset(
                            //                 Asset.clipArrow,
                            //                 height: 2.5.h,
                            //                 width: 2.5.w,
                            //                 color: isDarkMode() ? white : black,
                            //               ),
                            //             ),
                            //             Container(
                            //               height: 1, // Set the height of the line
                            //               width: 2.5
                            //                   .w, // Set the width of the line (adjust as needed)
                            //               child: CustomPaint(
                            //                 painter: DashLinePainter(
                            //                     color:
                            //                         isDarkMode() ? white : black,
                            //                     dashLength: 2,
                            //                     dashGap: 2),
                            //               ),
                            //             )
                            //           ],
                            //         ),
                            //       ),
                            //       Container(
                            //           margin: EdgeInsets.only(bottom: 2.h),
                            //           padding: EdgeInsets.only(bottom: 2.h),
                            //           width: 45.w,
                            //           child: DottedBorder(
                            //             borderType: BorderType.RRect,
                            //             color: isDarkMode() ? white : black,
                            //             dashPattern: [2, 2],
                            //             radius: Radius.circular(
                            //                 SizerUtil.deviceType ==
                            //                         DeviceType.mobile
                            //                     ? 4.w
                            //                     : 2.5.w),
                            //             child: Container(
                            //               // height: 10.h,
                            //               width: 45.w,
                            //               padding: EdgeInsets.only(
                            //                   right: 2.w,
                            //                   left: 2.w,
                            //                   top: 0.5.h,
                            //                   bottom: 0.5.h),
                            //               decoration: BoxDecoration(
                            //                 color: isDarkMode() ? black : white,
                            //                 border: Border(),
                            //                 borderRadius: BorderRadius.circular(
                            //                     SizerUtil.deviceType ==
                            //                             DeviceType.mobile
                            //                         ? 4.w
                            //                         : 2.5.w),
                            //                 boxShadow: [
                            //                   BoxShadow(
                            //                       color: Colors.black
                            //                           .withOpacity(0.1),
                            //                       blurRadius: 10.0,
                            //                       offset: const Offset(0, 1),
                            //                       spreadRadius: 3.0)
                            //                 ],
                            //               ),
                            //               child: Column(
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment.center,
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment.start,
                            //                   children: [
                            //                     Row(
                            //                       mainAxisAlignment:
                            //                           MainAxisAlignment.end,
                            //                       children: [],
                            //                     ),
                            //                     Row(
                            //                       children: [
                            //                         Text(
                            //                           maxLines: 1,
                            //                           overflow:
                            //                               TextOverflow.ellipsis,
                            //                           serviceDetailData.title,
                            //                           style: TextStyle(
                            //                             fontSize: 12.sp,
                            //                             fontWeight:
                            //                                 FontWeight.w800,
                            //                             color: isDarkMode()
                            //                                 ? white
                            //                                 : black,
                            //                           ),
                            //                         ),
                            //                         Spacer(),
                            //                         Container(
                            //                           padding: EdgeInsets.only(
                            //                               left: 1.w,
                            //                               right: 1.w,
                            //                               top: 0.5.h,
                            //                               bottom: 0.5.h),
                            //                           decoration: BoxDecoration(
                            //                               color:
                            //                                   Color(0XFF43C778),
                            //                               borderRadius:
                            //                                   BorderRadius
                            //                                       .circular(5.w)),
                            //                           child: Icon(
                            //                             Icons.edit_outlined,
                            //                             size: 1.h,
                            //                             color: Colors.white,
                            //                           ),
                            //                         ),
                            //                         SizedBox(
                            //                           width: 1.w,
                            //                         ),
                            //                         Container(
                            //                           padding: EdgeInsets.only(
                            //                               left: 0.5.w,
                            //                               right: 0.5.w,
                            //                               top: 0.3.h,
                            //                               bottom: 0.3.h),
                            //                           decoration: BoxDecoration(
                            //                               color:
                            //                                   Color(0XFFFF5959),
                            //                               borderRadius:
                            //                                   BorderRadius
                            //                                       .circular(5.w)),
                            //                           child: Icon(
                            //                             Icons.delete_rounded,
                            //                             color: Colors.white,
                            //                             size: 1.5.h,
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                     Row(
                            //                       mainAxisAlignment:
                            //                           MainAxisAlignment.center,
                            //                       crossAxisAlignment:
                            //                           CrossAxisAlignment.center,
                            //                       children: [
                            //                         Text(
                            //                           "Description : ",
                            //                           style: TextStyle(
                            //                             fontSize: 10.sp,
                            //                             fontWeight:
                            //                                 FontWeight.w800,
                            //                             color: isDarkMode()
                            //                                 ? white
                            //                                 : black,
                            //                           ),
                            //                         ),
                            //                         Expanded(
                            //                           child: Text(
                            //                             serviceDetailData
                            //                                 .description,
                            //                             maxLines: 1,
                            //                             overflow:
                            //                                 TextOverflow.ellipsis,
                            //                             style: TextStyle(
                            //                                 fontSize: SizerUtil
                            //                                             .deviceType ==
                            //                                         DeviceType
                            //                                             .mobile
                            //                                     ? 9.sp
                            //                                     : 7.sp,
                            //                                 color: isDarkMode()
                            //                                     ? white
                            //                                     : black,
                            //                                 fontFamily:
                            //                                     fontRegular),
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                     SizedBox(
                            //                       height: 0.5.h,
                            //                     ),
                            //                     Row(
                            //                         mainAxisAlignment:
                            //                             MainAxisAlignment.start,
                            //                         crossAxisAlignment:
                            //                             CrossAxisAlignment.center,
                            //                         children: [
                            //                           Text(
                            //                             "Duration : ",
                            //                             style: TextStyle(
                            //                               fontSize: 9.sp,
                            //                               fontWeight:
                            //                                   FontWeight.w800,
                            //                               color: isDarkMode()
                            //                                   ? white
                            //                                   : black,
                            //                             ),
                            //                           ),
                            //                           Expanded(
                            //                             child: Text(
                            //                               serviceDetailData
                            //                                   .duration,
                            //                               maxLines: null,
                            //                               overflow: TextOverflow
                            //                                   .ellipsis,
                            //                               style: TextStyle(
                            //                                   fontSize: SizerUtil
                            //                                               .deviceType ==
                            //                                           DeviceType
                            //                                               .mobile
                            //                                       ? 9.sp
                            //                                       : 7.sp,
                            //                                   color: isDarkMode()
                            //                                       ? white
                            //                                       : black,
                            //                                   fontFamily:
                            //                                       fontRegular),
                            //                             ),
                            //                           ),
                            //                         ]),
                            //                   ]),
                            //             ),
                            //           )),
                            //     ]),
                            //   );
                            // }).toList(),
                            ),
                      ),
                    ),
                  ]),
            ),
          ],
        );
      },
    );
 
 
  }
}
