import 'package:booking_app/Models/VendorServiceModel.dart';
import 'package:booking_app/Screens/ServiceScreen/ServiceScreen.dart';
import 'package:booking_app/controllers/ServiceBasedProfileController.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ServiceProfileTabScreen extends StatefulWidget {
  const ServiceProfileTabScreen({super.key});

  @override
  State<ServiceProfileTabScreen> createState() =>
      _ServiceProfileTabScreenState();
}

class _ServiceProfileTabScreenState extends State<ServiceProfileTabScreen> {
  // List<ServiceItem> staticData = SettingsItems;
  // List<Service_Item> staticData = ServicesItems;
  // List<ExpertItem> staticData1 = expertItems;
  // List<OfferItem> staticData2 = offersItems;

  var controller = Get.put(ServiceBasedProfileController());

  String capitalizeFirst(String input) {
    if (input.isEmpty) {
      return input;
    }
    return "${input[0].toUpperCase()}${input.substring(1)}";
  }

  @override
  void initState() {
    controller.getServiceList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.state.value) {
        case ScreenState.apiLoading:
        case ScreenState.noNetwork:
        case ScreenState.noDataFound:
        case ScreenState.apiError:
          return Container(
            height: SizerUtil.height / 1.7,
            child: apiOtherStates(controller.state.value),
          );
        case ScreenState.apiSuccess:
          return apiSuccess(controller.state.value);
        default:
          Container();
      }
      return Container();
    });
  }

  Widget apiSuccess(ScreenState state) {
    if (controller.state == ScreenState.apiSuccess &&
        controller.serviceObjectList.isNotEmpty) {
      return Container(
          height: SizerUtil.height,
          width: SizerUtil.width,
          child: Column(
            children: [
              GestureDetector(
                onTap: (() {
                  Get.to(ServiceScreen());
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        margin:
                            EdgeInsets.only(left: 5.w, right: 8.w, top: 1.h),
                        child: Text(
                          "View More >",
                          style: TextStyle(
                            color: isDarkMode() ? white : black,
                            fontWeight: FontWeight.w800,
                            fontSize: 13.sp,
                          ),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 1.h),
                  padding: EdgeInsets.only(
                    left: 8.w,
                    right: 8.w,
                  ),
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //   crossAxisCount:
                      //       2, // Set the number of columns as per your requirement
                      //   crossAxisSpacing:
                      //       6.w, // Set the spacing between columns
                      //   mainAxisSpacing: 3.h, // Set the spacing between rows
                      // ),
                      clipBehavior: Clip.antiAlias,
                      itemCount: controller.serviceObjectList.length,
                      itemBuilder: (context, index) {
                        VendorServiceList data =
                            controller.serviceObjectList[index];
                        return Container(
                          padding: EdgeInsets.only(
                              left: 5.w, right: 3.w, top: 1.h, bottom: 1.h),
                          margin: EdgeInsets.only(bottom: 1.h),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 1.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.serviceInfo.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    // data.serviceInfo != null
                                    //     ? data.serviceInfo!.name
                                    //     : "",
                                    style: TextStyle(
                                      color: isDarkMode() ? white : black,
                                      fontFamily: opensansMedium,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  // SizedBox(height: 5.0),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '₹ ${data.fees.toString()}',
                                    style: TextStyle(
                                      fontFamily: opensansMedium,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),

                              // SizedBox(height: 5.0),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ],
          ));
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              "Data not Found",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: fontMedium, fontSize: 12.sp),
            ),
          ),
        ],
      );
    }
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
        // controller.getPackageList(
        //   context,
        // );
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
}











         
                    // return Container(
                    //   height: 10.h,
                    //   width: 20.h,
                    //   margin: EdgeInsets.only(left: 1.5.h, right: 1.5.h),
                    //   decoration: BoxDecoration(
                    //     color: isDarkMode() ? black : white,
                    //     border: Border.all(
                    //       color: primaryColor.withOpacity(0.02),
                    //     ),
                    //     boxShadow: [
                    //       BoxShadow(
                    //           color: isDarkMode()
                    //               ? Colors.white.withOpacity(0.2)
                    //               : Colors.black.withOpacity(0.2),
                    //           spreadRadius: 0.1,
                    //           blurRadius: 10,
                    //           offset: Offset(0.5, 0.5)),
                    //     ],
                    //     borderRadius: BorderRadius.circular(
                    //       SizerUtil.deviceType == DeviceType.mobile ? 4.w : 2.2.w,
                    //     ),
                    //   ),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Container(
                    //         // padding:
                    //         //     EdgeInsets.only(top: 5.h, left: 1.w, right: 1.w),
                    //         height: 15.h,
                    //         width: 100.w,
                    //         child: ClipRRect(
                    //           borderRadius: BorderRadius.circular(10),
                    //           child: data.icon,
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 2.h,
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Text(
                    //             data.Name,
                    //             style: TextStyle(
                    //                 color: isDarkMode() ? white : black,
                    //                 fontSize: 12.sp,
                    //                 fontWeight: FontWeight.w500),
                    //           ),
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // );
             
        
              // ListView.builder(
              //     shrinkWrap: false,
              //     scrollDirection: Axis.horizontal,
              //     clipBehavior: Clip.antiAlias,
              //     itemBuilder: (context, index) {
              //       Service_Item data = staticData[index];
              //       return Container(
              //         height: 20.h,
              //         width: 32.w,
              //         margin: EdgeInsets.only(left: 3.h),
              //         decoration: BoxDecoration(
              //           color: white,
              //           border: Border.all(
              //             color: primaryColor..withOpacity(0.02),
              //           ),
              //           borderRadius: BorderRadius.circular(
              //               SizerUtil.deviceType == DeviceType.mobile ? 4.w : 2.2.w),
              //         ),
              //         child: Column(
              //           children: [
              //             Container(
              //               padding:
              //                   EdgeInsets.only(top: 0.5.h, left: 1.w, right: 1.w),
              //               height: 11.h,
              //               width: 100.w,
              //               child: ClipRRect(
              //                   borderRadius: BorderRadius.circular(10),
              //                   child: data.icon),
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Text(
              //                   data.Name,
              //                   style: TextStyle(
              //                     fontSize: 10.5.sp,
              //                   ),
              //                 ),
              //               ],
              //             )
              //           ],
              //         ),
              //       );
              //     },
              //     itemCount: staticData.length),
              
        
          // Container(
          //   margin: EdgeInsets.only(left: 3.h),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Text(
          //         'Offers',
          //         style: TextStyle(fontFamily: opensansMedium, fontSize: 15.sp),
          //       ),
          //     ],
          //   ),
          // ),
      

    // Container(
    //   margin: EdgeInsets.only(top: 3.h),
    //   child: ListView.builder(
    //       shrinkWrap: false,
    //       clipBehavior: Clip.antiAlias,
    //       itemBuilder: (context, index) {
    //         ServiceItem data = staticData[index];

    //         return Container(
    //           margin:
    //               EdgeInsets.only(top: 1.h, left: 8.w, right: 8.w, bottom: 1.h),
    //           child: InkWell(
    //             onTap: () {
    //               Common.PopupDialogs(context);
    //             },
    //             child: Container(
    //               padding: EdgeInsets.only(
    //                   top: 1.5.h, left: 4.w, right: 4.w, bottom: 1.5.h),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       Container(
    //                         child: data.icon,
    //                       ),
    //                       SizedBox(
    //                         width: 3.w,
    //                       ),
    //                       Container(
    //                         child: Text(
    //                           data.Name,
    //                           style: TextStyle(
    //                               color: isDarkMode() ? white : black,
    //                               fontFamily: opensansMedium,
    //                               fontSize: 12.sp,
    //                               fontWeight: FontWeight.w400),
    //                         ),
    //                       )
    //                     ],
    //                   )
    //                 ],
    //               ),
    //               decoration: BoxDecoration(
    //                 color: isDarkMode() ? black : white,
    //                 borderRadius: BorderRadius.all(Radius.circular(10)),
    //                 boxShadow: [
    //                   BoxShadow(
    //                       color: Colors.black.withOpacity(0.2),
    //                       spreadRadius: 0.1,
    //                       blurRadius: 10,
    //                       offset: Offset(0.5, 0.5)),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         );
    //       },
    //       itemCount: staticData.length),
    // );
  

