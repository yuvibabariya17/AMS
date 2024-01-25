import 'package:booking_app/Screens/model.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    logcat("LISTTTT", hairserviceItems.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hairserviceItems.length,
      itemBuilder: (context, index) {
        // final data = hairserviceItems[index];
        final ServiceSlot data = hairserviceItems[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 6.w),
                        height: 5.5.h,
                        width: 23.w,
                        padding: EdgeInsets.only(
                          left: 1.w,
                          right: 0.5.w,
                          top: 1.5.h,
                        ),
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
                          data.time,
                          textAlign:
                              TextAlign.center, // Ensure item.time is not null
                          style: TextStyle(
                            color: isDarkMode() ? white : white,
                          ),
                        ),
                      ),
                      if (index < hairserviceItems.length - 1)
                        Container(
                          margin: EdgeInsets.only(left: 4.w),
                          height: 10.h,
                          color: Colors.grey,
                          width: 0.4.w,
                        )
                    ],
                  ),
                  // SizedBox(width: 4.w),
                  // Container(
                  //   margin: EdgeInsets.only(bottom: 5.h),
                  //   child: SvgPicture.asset(
                  //     Asset.clipArrow,
                  //     height: 2.5.h,
                  //     width: 2.5.h,
                  //     color: isDarkMode() ? white : black,
                  //   ),
                  // ),
                  CustomPaint(painter: DrawDottedhorizontalline()),
                  SizedBox(
                    width: 3.w,
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              // title: Center(child: Text('Details')),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: data.details.map((serviceDetailData) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          serviceDetailData.title,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        'Description: ${serviceDetailData.description}',
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        'Duration: ${serviceDetailData.duration}',
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                      // Add more details as needed
                                      SizedBox(height: 16.0),
                                    ],
                                  );
                                }).toList(),
                              ),
                            );
                          },
                        );
                      },
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: data.details.map((serviceDetailData) {
                            return Container(
                                margin: EdgeInsets.only(
                                  right: 10.w,
                                ),
                                width: 50.w,
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  color: isDarkMode() ? white : black,
                                  dashPattern: [2, 2],
                                  radius: Radius.circular(
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? 4.w
                                          : 2.5.w),
                                  child: Container(
                                    // height: 10.h,
                                    width: 50.w,
                                    padding: EdgeInsets.only(
                                        right: 2.w,
                                        left: 2.w,
                                        top: 1.h,
                                        bottom: 1.h),
                                    decoration: BoxDecoration(
                                      color: isDarkMode() ? black : white,
                                      border: Border(),
                                      borderRadius: BorderRadius.circular(
                                          SizerUtil.deviceType ==
                                                  DeviceType.mobile
                                              ? 4.w
                                              : 2.5.w),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 10.0,
                                            offset: const Offset(0, 1),
                                            spreadRadius: 3.0)
                                      ],
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [],
                                          ),
                                          Row(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    fontSize: SizerUtil
                                                                .deviceType ==
                                                            DeviceType.mobile
                                                        ? 14.sp
                                                        : 14.sp,
                                                    color: isDarkMode()
                                                        ? white
                                                        : black,
                                                    fontFamily: fontBold,
                                                  ),
                                                  children: [
                                                    // TextSpan(
                                                    //   text: 'Title : ',
                                                    //   style: TextStyle(
                                                    //     fontWeight: FontWeight.bold,
                                                    //   ),
                                                    // ),
                                                    TextSpan(
                                                      text: serviceDetailData
                                                          .title,
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: isDarkMode()
                                                            ? white
                                                            : black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 1.w,
                                                    right: 1.w,
                                                    top: 0.5.h,
                                                    bottom: 0.5.h),
                                                decoration: BoxDecoration(
                                                    color: Color(0XFF43C778),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.w)),
                                                child: Icon(
                                                  Icons.edit_outlined,
                                                  size: 1.h,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 1.5.w,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 0.5.w,
                                                    right: 0.5.w,
                                                    top: 0.3.h,
                                                    bottom: 0.3.h),
                                                decoration: BoxDecoration(
                                                    color: Color(0XFFFF5959),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.w)),
                                                child: Icon(
                                                  Icons.delete_rounded,
                                                  color: Colors.white,
                                                  size: 1.5.h,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Description : ",
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w800,
                                                  color: isDarkMode()
                                                      ? white
                                                      : black,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  serviceDetailData.description,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: SizerUtil
                                                                  .deviceType ==
                                                              DeviceType.mobile
                                                          ? 9.sp
                                                          : 7.sp,
                                                      color: isDarkMode()
                                                          ? white
                                                          : black,
                                                      fontFamily: fontRegular),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          Row(children: [
                                            RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: isDarkMode()
                                                      ? white
                                                      : black,
                                                  fontFamily: fontBold,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: 'Duration : ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              serviceDetailData.duration,
                                              style: TextStyle(
                                                  fontSize:
                                                      SizerUtil.deviceType ==
                                                              DeviceType.mobile
                                                          ? 9.sp
                                                          : 7.sp,
                                                  color: isDarkMode()
                                                      ? white
                                                      : black,
                                                  fontFamily: fontRegular),
                                            )
                                          ]),
                                        ]),
                                  ),
                                ));
                          }).toList(),
                        ),
                      ),
                    ),
                  ),

                  // Container(
                  //   width: SizerUtil.width,
                  //   child:

                  //    ListView.builder(
                  //       shrinkWrap: true,
                  //       clipBehavior: Clip.antiAlias,
                  //       itemBuilder: (context, index) {
                  //         ServiceDetails serviceDetailData = data.details[index];
                  //         return
                  //      },
                  //       itemCount: data.details.length),
                  // ),
                ]),
          ],
        );
      },
    );

    // ListView.builder(
    //   physics: BouncingScrollPhysics(),
    //   padding: EdgeInsets.all(0),
    //   itemCount: hairserviceItems.length,
    //   itemBuilder: (context, index) {
    //     final ServiceSlot serviceSlot =
    //         hairserviceItems[index];
    //     return IntrinsicHeight(
    //       child: Row(
    //         // mainAxisAlignment: MainAxisAlignment.start,
    //         // crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Column(
    //             children: [
    //               Container(
    //                 margin: EdgeInsets.only(left: 6.w),
    //                 height: 5.5.h,
    //                 width: 23.w,
    //                 padding: EdgeInsets.only(
    //                   left: 1.w,
    //                   right: 0.5.w,
    //                   top: 1.5.h,
    //                 ),
    //                 decoration: BoxDecoration(
    //                   boxShadow: [
    //                     BoxShadow(
    //                         color: isDarkMode()
    //                             ? Colors.white.withOpacity(0.2)
    //                             : Colors.black.withOpacity(0.2),
    //                         spreadRadius: 0.1,
    //                         blurRadius: 10,
    //                         offset: Offset(0.5, 0.5)),
    //                   ],
    //                   color: isDarkMode() ? black : black,
    //                   borderRadius: BorderRadius.circular(8.0),
    //                   border: Border.all(color: isDarkMode() ? white : black),
    //                 ),
    //                 child: Text(
    //                   serviceSlot.time,
    //                   textAlign:
    //                       TextAlign.center, // Ensure item.time is not null
    //                   style: TextStyle(
    //                     color: isDarkMode() ? white : white,
    //                   ),
    //                 ),
    //               ),
    //               if (index < hairserviceItems.length - 1)
    //                 Container(
    //                   margin: EdgeInsets.only(left: 4.w),
    //                   height: 10.h,
    //                   color: Colors.grey,
    //                   width: 0.4.w,
    //                 )
    //             ],
    //           ),
    //           SizedBox(width: 4.w),
    //           Container(
    //             margin: EdgeInsets.only(bottom: 10.h),
    //             child: SvgPicture.asset(
    //               Asset.clipArrow,
    //               height: 3.h,
    //               width: 3.h,
    //               color: isDarkMode() ? white : black,
    //             ),
    //           ),

    //           Flexible(
    //             child:
    //
    // ListView.builder(
    //               shrinkWrap: true,
    //                 scrollDirection: Axis.horizontal,
    //                 itemCount: serviceSlot.details.length,
    //                 itemBuilder: (context, index) {
    //                   final ServiceDetails details = serviceSlot.details[index];

    //                   return Container(
    //                     margin: EdgeInsets.only(right: 5.w),
    //                     child: DottedBorder(
    //                       borderType: BorderType.RRect,
    //                       color: isDarkMode() ? white : black,
    //                       dashPattern: [2, 2],
    //                       radius: Radius.circular(
    //                           SizerUtil.deviceType == DeviceType.mobile
    //                               ? 4.w
    //                               : 2.5.w),
    //                       child: Container(
    //                         // height: 13.5.h,
    //                         width: double.infinity,
    //                         padding: EdgeInsets.only(
    //                             right: 2.w, left: 2.w, top: 1.5.h, bottom: 1.5.h),
    //                         decoration: BoxDecoration(
    //                           color: isDarkMode() ? black : white,
    //                           border: Border(),
    //                           borderRadius: BorderRadius.circular(
    //                               SizerUtil.deviceType == DeviceType.mobile
    //                                   ? 4.w
    //                                   : 2.5.w),
    //                           boxShadow: [
    //                             BoxShadow(
    //                                 color: Colors.black.withOpacity(0.1),
    //                                 blurRadius: 10.0,
    //                                 offset: const Offset(0, 1),
    //                                 spreadRadius: 3.0)
    //                           ],
    //                         ),
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             // Row(
    //                             //   mainAxisAlignment: MainAxisAlignment.end,
    //                             //   children: [
    //                             //     InkWell(
    //                             //       onTap: () {},
    //                             //       child: Container(
    //                             //         padding: EdgeInsets.only(left: 1.w,right: 1.w, top: 0.5.h, bottom: 0.5.h),
    //                             //         decoration: BoxDecoration(
    //                             //             color: Color(0XFF43C778),
    //                             //             borderRadius:
    //                             //                 BorderRadius.circular(5.w)),
    //                             //         child: Icon(
    //                             //           Icons.edit_outlined,
    //                             //           size: 1.5.h,
    //                             //           color: Colors.white,
    //                             //         ),
    //                             //       ),
    //                             //     ),
    //                             //     SizedBox(
    //                             //       width: 1.5.w,
    //                             //     ),
    //                             //     InkWell(
    //                             //       child: Container(
    //                             //       padding: EdgeInsets.only(left: 0.5.w,right: 0.5.w, top: 0.3.h, bottom: 0.3.h),
    //                             //         decoration: BoxDecoration(
    //                             //             color: Color(0XFFFF5959),
    //                             //             borderRadius:
    //                             //                 BorderRadius.circular(5.w)),
    //                             //         child: Icon(
    //                             //           Icons.delete_rounded,
    //                             //            color: Colors.white,
    //                             //           size: 2.h,
    //                             //         ),
    //                             //       ),
    //                             //     ),
    //                             //   ],
    //                             // ),
    //                             Row(
    //                               children: [
    //                                 RichText(
    //                                   text: TextSpan(
    //                                     style: TextStyle(
    //                                       fontSize: SizerUtil.deviceType ==
    //                                               DeviceType.mobile
    //                                           ? 14.sp
    //                                           : 14.sp,
    //                                       color: isDarkMode() ? white : black,
    //                                       fontFamily: fontBold,
    //                                     ),
    //                                     children: [
    //                                       // TextSpan(
    //                                       //   text: 'Title : ',
    //                                       //   style: TextStyle(
    //                                       //     fontWeight: FontWeight.bold,
    //                                       //   ),
    //                                       // ),
    //                                       TextSpan(
    //                                         text: details.title ?? '',
    //                                         style: TextStyle(
    //                                           fontSize: 14.sp,
    //                                           fontWeight: FontWeight.w900,
    //                                           color: isDarkMode() ? white : black,
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                 ),
    //                                 Spacer(),
    //                               ],
    //                             ),

    //                             Row(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 Text(
    //                                   "Description : ",
    //                                   style: TextStyle(
    //                                     fontSize: 11.sp,
    //                                     fontWeight: FontWeight.w700,
    //                                     color: isDarkMode() ? white : black,
    //                                   ),
    //                                 ),
    //                                 Expanded(
    //                                   child: Text(
    //                                     details.description ?? '',
    //                                     maxLines: 2,
    //                                     overflow: TextOverflow.ellipsis,
    //                                     style: TextStyle(
    //                                         fontSize: SizerUtil.deviceType ==
    //                                                 DeviceType.mobile
    //                                             ? 9.sp
    //                                             : 7.sp,
    //                                         color: isDarkMode() ? white : black,
    //                                         fontFamily: fontRegular),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                             SizedBox(
    //                               height: 0.5.h,
    //                             ),

    //                             Row(children: [
    //                               RichText(
    //                                 text: TextSpan(
    //                                   style: TextStyle(
    //                                     fontSize: 11.sp,
    //                                     fontWeight: FontWeight.w700,
    //                                     color: isDarkMode() ? white : black,
    //                                     fontFamily: fontBold,
    //                                   ),
    //                                   children: [
    //                                     TextSpan(
    //                                       text: 'Duration : ',
    //                                       style: TextStyle(
    //                                         fontWeight: FontWeight.w700,
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ),
    //                               Text(
    //                                 details.duration ?? '',
    //                                 style: TextStyle(
    //                                     fontSize: SizerUtil.deviceType ==
    //                                             DeviceType.mobile
    //                                         ? 9.sp
    //                                         : 7.sp,
    //                                     color: isDarkMode() ? white : black,
    //                                     fontFamily: fontRegular),
    //                               )
    //                             ]),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   );
    //                 }),
    //           ),

    //         ],
    //       ),
    //     );
    //   },
    // );
  }

  late Paint _paint;
  DrawDottedhorizontalline() {
    _paint = Paint();
    _paint.color = Colors.black; //dots color
    _paint.strokeWidth = 2; //dots thickness
    _paint.strokeCap = StrokeCap.square; //dots corner edges
  }
}
