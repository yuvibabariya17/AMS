import '../../Models/ServiceModel.dart';
import 'package:booking_app/controllers/ServiceBasedProfileController.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
    controller.filteredServiceObjectList = controller.serviceObjectList;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Obx(() {
          return Stack(children: [
            Obx(() {
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
                      // margin: EdgeInsets.only(bottom: 3.h, top: 2.h),
                      child: apiSuccess(controller.state.value));
                default:
                  Container();
              }
              return Container();
            }),
            if (controller.isLoading.value == true)
              SizedBox(
                  height: SizerUtil.height,
                  width: SizerUtil.width,
                  child: Center(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      height: 60,
                      width: 60,
                      child: Image.asset(
                        "assets/gif/loading.gif",
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ))),
          ]);
        }),
      ),
    ]);
  }

  Widget apiSuccess(ScreenState state) {
    if (controller.state == ScreenState.apiSuccess &&
        controller.serviceObjectList.isNotEmpty) {
      return controller.filteredServiceObjectList.isNotEmpty
          ? Container(
              height: SizerUtil.height,
              width: SizerUtil.width,
              child: Container(
                  margin: EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h),
                  child: GridView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: false,
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            2, // Set the number of columns as per your requirement
                        crossAxisSpacing:
                            20.0, // Set the spacing between columns
                        mainAxisSpacing: 20.0, // Set the spacing between rows
                      ),
                      clipBehavior: Clip.antiAlias,
                      itemCount: controller.filteredServiceObjectList.length,
                      itemBuilder: (context, index) {
                        ServiceList data =
                            controller.filteredServiceObjectList[index];

                        return Container(
                          padding: EdgeInsets.only(
                            left: 1.w,
                            right: 1.w,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(
                                          top: 0.5.h,
                                          left: 0.5.w,
                                          right: 0.5.w),
                                      height: 11.h,
                                      width: 60.w,
                                      // padding: EdgeInsets.all(
                                      //   SizerUtil.deviceType == DeviceType.mobile
                                      //       ? 1.2.w
                                      //       : 1.0.w,
                                      // ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: "",
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(
                                                color: primaryColor),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            Asset.placeholder,
                                            height: 11.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ))

                                  // CircleAvatar(
                                  //   radius: 4.h,
                                  //   backgroundColor: Colors.white,
                                  //   child: SvgPicture.asset(
                                  //     Asset.profileimg,
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.name,
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
                                  // Text(
                                  //   '₹ ${data..toString()}',
                                  //   style: TextStyle(
                                  //     color: isDarkMode() ? white : black,
                                  //     fontFamily: opensansMedium,
                                  //     fontSize: 12.sp,
                                  //     fontWeight: FontWeight.w500,
                                  //   ),
                                  // ),
                                ],
                              ),

                              // SizedBox(height: 5.0),
                            ],
                          ),
                        );
                     
                     
                     
                     
                     
                     
                     
                      })))
          : Center(
              child: Text("Data not Found"),
            );
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
  

