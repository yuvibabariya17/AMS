import 'package:booking_app/Models/VendorServiceModel.dart';
import 'package:booking_app/Screens/ServiceScreen/AddServiceScreen.dart';
import 'package:booking_app/controllers/Service_controller.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/Common/toolbar.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/strings.dart';
import '../../core/themes/color_const.dart';
import '../../core/themes/font_constant.dart';
import '../../core/utils/helper.dart';
import '../../core/utils/log.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final controller = Get.put(serviceController());

  TextEditingController search = TextEditingController();

  @override
  void initState() {
    controller.getServiceList(context);
    controller.filteredServiceObjectList = controller.serviceObjectList;
    super.initState();
  }

  void filterServiceList(String query) {
    setState(() {
      if (query.isEmpty) {
        controller.filteredServiceObjectList = controller.serviceObjectList;
      } else {
        controller.filteredServiceObjectList = controller.serviceObjectList
            .where((data) =>
                data.fees.toString().trim().contains(query.toLowerCase()) ||
                data.serviceInfo.name
                    .toString()
                    .trim()
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
                  Get.to(AddServiceScreen(
                    isEdit: false,
                  ))?.then((value) {
                    if (value == true) {
                      controller.getServiceList(
                        context,
                      );
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
            getCommonToolbar(ScreenTitle.service, () {
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
                                : 2.w),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.search_sharp,
                              color: isDarkMode() ? white : black,
                              size: SizerUtil.deviceType == DeviceType.mobile
                                  ? null
                                  : 3.h,
                            )),
                      )),
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
                        controller.getServiceList(context);
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
            content: Text('Are you sure you want to delete this Service ?',
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
                  controller.deleteServiceList(context, serviceId);
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
    logcat("LENGTH", controller.serviceObjectList.length.toString());
    // ignore: unrelated_type_quality_checks
    if (controller.state == ScreenState.apiSuccess &&
        controller.filteredServiceObjectList.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(
          left: SizerUtil.deviceType == DeviceType.mobile ? 8.w : 6.3.w,
          right: SizerUtil.deviceType == DeviceType.mobile ? 8.w : 6.3.w,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          clipBehavior: Clip.antiAlias,
          padding: EdgeInsets.only(
              bottom: SizerUtil.deviceType == DeviceType.mobile ? 20.h : 10.h),
          physics: BouncingScrollPhysics(),
          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 2, // Adjust the number of columns as needed
          //   crossAxisSpacing: 10.0,
          //   mainAxisSpacing: 10.0,
          // ),
          itemBuilder: (context, index) {
            VendorServiceList data =
                controller.filteredServiceObjectList[index];
            return Container(
              padding: EdgeInsets.only(
                left: SizerUtil.deviceType == DeviceType.mobile ? 5.w : 3.w,
                right: SizerUtil.deviceType == DeviceType.mobile ? 5.w : 3.w,
                top: SizerUtil.deviceType == DeviceType.mobile ? 1.h : 0.5.h,
                bottom: SizerUtil.deviceType == DeviceType.mobile ? 1.h : 0.5.h,
              ),
              margin: EdgeInsets.only(bottom: 1.h),
              decoration: BoxDecoration(
                color: isDarkMode() ? black : white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode()
                        ? white.withOpacity(0.2)
                        : black.withOpacity(0.2),
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
                  // Stack(
                  //   children: [
                  //     //IMAGE SHOW

                  //     // Container(
                  //     //     height: 11.h,
                  //     //     width: 60.w,
                  //     //     // padding: EdgeInsets.all(
                  //     //     //   SizerUtil.deviceType == DeviceType.mobile
                  //     //     //       ? 1.2.w
                  //     //     //       : 1.0.w,
                  //     //     // ),
                  //     //     child: ClipRRect(
                  //     //       borderRadius: const BorderRadius.all(
                  //     //           Radius.circular(15)),
                  //     //       child: CachedNetworkImage(
                  //     //         fit: BoxFit.cover,
                  //     //         imageUrl: "",
                  //     //         placeholder: (context, url) =>
                  //     //             const Center(
                  //     //           child: CircularProgressIndicator(
                  //     //               color: primaryColor),
                  //     //         ),
                  //     //         errorWidget: (context, url, error) =>
                  //     //             Image.asset(
                  //     //           Asset.placeholder,
                  //     //           height: 11.h,
                  //     //           fit: BoxFit.cover,
                  //     //         ),
                  //     //       ),
                  //     //     ))

                  //     // CircleAvatar(
                  //     //   radius: 4.h,
                  //     //   backgroundColor: Colors.white,
                  //     //   child: SvgPicture.asset(
                  //     //     Asset.profileimg,
                  //     //     fit: BoxFit.cover,
                  //     //   ),
                  //     // ),
                  //   ],
                  // ),
                  // SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.serviceInfo.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isDarkMode() ? white : black,
                          fontFamily: opensansMedium,
                          fontSize: SizerUtil.deviceType == DeviceType.mobile
                              ? 14.sp
                              : 11.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        // textAlign: TextAlign.center,
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
                          Get.to(AddServiceScreen(
                                  isEdit: true, editService: data))
                              ?.then((value) {
                            if (value == true) {
                              controller.getServiceList(
                                context,
                              );
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
          itemCount: controller.filteredServiceObjectList.length,
        ),
      );
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
        controller.getServiceList(
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
}
