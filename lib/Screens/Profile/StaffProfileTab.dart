import 'package:booking_app/Config/apicall_constant.dart';
import 'package:booking_app/Models/ExpertModel.dart';
import 'package:booking_app/Screens/ExpertScreen/ExpertScreen.dart';
import 'package:booking_app/controllers/StaffController.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Models/Staff_model.dart';
import '../../Models/staff.dart';
import '../../core/constants/assets.dart';
import '../../core/themes/font_constant.dart';
import '../../core/utils/helper.dart';

class StaffprofileTabScreen extends StatefulWidget {
  const StaffprofileTabScreen({super.key});

  @override
  State<StaffprofileTabScreen> createState() => _StaffprofileTabScreenState();
}

class _StaffprofileTabScreenState extends State<StaffprofileTabScreen> {
  var controller = Get.put(StaffController());

  @override
  void initState() {
    controller.getExpertList(context);
    controller.filteredExpertObjectList = controller.expertObjectList;

    super.initState();
  }

  void initDataset(BuildContext context) async {
    //  SignInData? retrievedObject = await UserPreferences().getSignInInfo();

    // controller.profilePic.value =
    //     "http://192.168.1.7.4000/uploads/${retrievedObject!.profilePic}";
  }

  List<StaffItem> staticData1 = StaffItems;

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
        controller.expertObjectList.isNotEmpty) {
      return controller.filteredExpertObjectList.isNotEmpty
          ? Container(
              height: SizerUtil.height,
              width: SizerUtil.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // margin: EdgeInsets.only(top: 0.5.h),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(ExpertScreen());
                        // Handle View More tap
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 1.h,
                              right: SizerUtil.deviceType == DeviceType.mobile
                                  ? 7.w
                                  : 13.w,
                            ),
                            child: Text(
                              "View More >",
                              style: TextStyle(
                                color: isDarkMode() ? white : black,
                                fontWeight: FontWeight.w800,
                                fontSize:
                                    SizerUtil.deviceType == DeviceType.mobile
                                        ? 13.sp
                                        : 8.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 1.h,
                      ),
                      padding: EdgeInsets.only(
                        left: SizerUtil.deviceType == DeviceType.mobile
                            ? 5.w
                            : 5.w,
                        right: SizerUtil.deviceType == DeviceType.mobile
                            ? 5.w
                            : 5.w,
                      ),
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing:
                                SizerUtil.deviceType == DeviceType.mobile
                                    ? 10.0
                                    : 15.0,
                            childAspectRatio:
                                SizerUtil.deviceType == DeviceType.mobile
                                    ? 1.5
                                    : 1.8,
                          ),
                          clipBehavior: Clip.antiAlias,
                          itemBuilder: (context, index) {
                            ExpertList data =
                                controller.filteredExpertObjectList[index];
                            return Container(
                              margin: EdgeInsets.only(
                                  // bottom: 1.h,
                                  right:
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? 1.w
                                          : 4.w,
                                  top: SizerUtil.deviceType == DeviceType.mobile
                                      ? 1.h
                                      : 1.h,
                                  left:
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? 1.w
                                          : 4.w),
                              child: Container(
                                padding: EdgeInsets.only(
                                  //  top: 1.h,
                                  left:
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? 3.w
                                          : 4.w,
                                  right:
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? 3.w
                                          : 4.w,
                                  // bottom: 1.h
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(children: [
                                      Container(
                                        height: SizerUtil.deviceType ==
                                                DeviceType.mobile
                                            ? 6.h
                                            : 8.h,
                                        child: CircleAvatar(
                                          radius: 3.h,
                                          backgroundColor: white,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                            '${ApiUrl.ImgUrl}${data.upload_info.image}',
                                          ),
                                        ),
                                      ),
                                    ]),
                                    SizedBox(width: 2.w),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.name.capitalize.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: isDarkMode()
                                                    ? white
                                                    : black,
                                                fontFamily: opensansMedium,
                                                fontSize:
                                                    SizerUtil.deviceType ==
                                                            DeviceType.mobile
                                                        ? 14.sp
                                                        : 7.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          // SizedBox(
                                          //   height: SizerUtil.deviceType ==
                                          //           DeviceType.mobile
                                          //       ? 0.5.h
                                          //       : 0.0.h,
                                          // ),
                                          Text(
                                            data.serviceInfo.name.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: isDarkMode()
                                                    ? white
                                                    : black,
                                                fontFamily: opensansMedium,
                                                fontSize:
                                                    SizerUtil.deviceType ==
                                                            DeviceType.mobile
                                                        ? 11.sp
                                                        : 7.sp,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: isDarkMode() ? black : white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: isDarkMode()
                                            ? white.withOpacity(0.2)
                                            : black.withOpacity(0.2),
                                        spreadRadius: 0.1,
                                        blurRadius: 3,
                                        offset: Offset(0.5, 0.5)),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount:
                              controller.filteredExpertObjectList.length),
                    ),
                  ),
                ],
              ),
            )
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
