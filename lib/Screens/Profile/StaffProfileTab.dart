import 'package:booking_app/Models/ExpertModel.dart';
import 'package:booking_app/controllers/StaffController.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        controller.expertObjectList.isNotEmpty) {
      return controller.filteredExpertObjectList.isNotEmpty
          ? Container(
              margin: EdgeInsets.only(top: 3.h),
              child: ListView.builder(
                  shrinkWrap: true,
                  clipBehavior: Clip.antiAlias,
                  itemBuilder: (context, index) {
                    ExpertList data =
                        controller.filteredExpertObjectList[index];
                    return Container(
                      margin: EdgeInsets.only(
                          top: 1.5.h, left: 8.w, right: 8.w, bottom: 1.5.h),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 1.5.h, left: 4.w, right: 4.w, bottom: 1.5.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(children: [
                                  CircleAvatar(
                                    radius: 3.7.h,
                                    backgroundColor: Colors.white,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "  data., ", // URL of the expert's image
                                        placeholder: (context, url) =>
                                            SvgPicture.asset(Asset.profileimg),
                                        errorWidget: (context, url, error) =>
                                            SvgPicture.asset(Asset.profileimg),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                  // CircleAvatar(
                                  //   radius: 3.7.h,
                                  //   backgroundColor: Colors.white,
                                  //   child: SvgPicture.asset(
                                  //     Asset.profileimg,
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  // ),
                                ]),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          child: Text(
                                        data.name,
                                        style: TextStyle(
                                            color: isDarkMode() ? white : black,
                                            fontFamily: opensansMedium,
                                            fontSize: 15.5.sp,
                                            fontWeight: FontWeight.w700),
                                      )),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        '₹ ${data.amount.toString()}',
                                        style: TextStyle(
                                            color: isDarkMode() ? white : black,
                                            fontFamily: opensansMedium,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
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
                    );
                  },
                  itemCount: controller.filteredExpertObjectList.length),
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
