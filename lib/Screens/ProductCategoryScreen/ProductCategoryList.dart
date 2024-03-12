import 'package:booking_app/Config/apicall_constant.dart';
import 'package:booking_app/Models/ProductCatListModel.dart';
import 'package:booking_app/Screens/ProductCategoryScreen/AddProductCategory.dart';
import 'package:booking_app/controllers/ProductList_controller.dart';
import 'package:booking_app/core/Common/Common.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:booking_app/dialogs/ImageScreen.dart';
import 'package:booking_app/preference/UserPreference.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:sizer/sizer.dart';
import '../../../core/Common/toolbar.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/strings.dart';
import '../../../core/themes/color_const.dart';
import '../../../core/themes/font_constant.dart';
import '../../../core/utils/helper.dart';
import '../../../core/utils/log.dart';

class ProductCategoryListScreen extends StatefulWidget {
  const ProductCategoryListScreen({super.key});

  @override
  State<ProductCategoryListScreen> createState() =>
      _ProductCategoryListScreenState();
}

class _ProductCategoryListScreenState extends State<ProductCategoryListScreen> {
  final controller = Get.put(ProductListController());

  TextEditingController search = TextEditingController();

  @override
  void initState() {
    controller.getProductCategoryList(context, true);
    getIp();
    controller.filterrdProductObjectList = controller.productCategoryObjectList;
    super.initState();
  }

  String ip = '';

  getIp() async {
    ip = await UserPreferences().getBuildIP();
    logcat("IMAGE_URL", ip.toString());
    setState(() {});
  }

  void filetProductCategoryList(String query) {
    setState(() {
      if (query.isEmpty) {
        controller.filterrdProductObjectList =
            controller.productCategoryObjectList;
      } else {
        controller.filterrdProductObjectList = controller
            .productCategoryObjectList
            .where((data) =>
                data.name.toLowerCase().contains(query.toLowerCase()) ||
                data.description
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
                  Get.to(AddProductCategoryScreen())?.then((value) {
                    if (value == true) {
                      logcat("ISDONE", "DONE");
                      controller.getProductCategoryList(context, false);
                    }
                  });
                },
                child: isDarkMode()
                    ? Icon(
                        Icons.add,
                        color: black,
                      )
                    : Icon(
                        Icons.add,
                        color: white,
                      )),
          ),
          body: Column(children: [
            getCommonToolbar("Product Category List", () {
              Get.back();
            }),
            Container(
              margin: EdgeInsets.only(top: 3.h, left: 1.0.w, right: 1.0.w),
              padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
              child: Container(
                height: 5.5.h,
                child: TextField(
                  onChanged: ((value) {
                    filetProductCategoryList(value);
                  }),
                  style: TextStyle(color: isDarkMode() ? white : black),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(top: 1.h, left: 2.h, bottom: 1.h),
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
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search_sharp,
                            color: isDarkMode() ? white : black,
                          ))),
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
                        controller.getProductCategoryList(context, true);
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
                'Are you sure you want to delete this Product Category?',
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
                  controller.deleteProductCategoryList(context, serviceId);
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
    logcat("LENGTH", controller.productCategoryObjectList.length.toString());
    // ignore: unrelated_type_quality_checks
    if (controller.state == ScreenState.apiSuccess &&
        controller.filterrdProductObjectList.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(left: 8.w, right: 8.w),
        child: GridView.builder(
          shrinkWrap: true,
          clipBehavior: Clip.antiAlias,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: 35.h),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Adjust the number of columns as needed
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemBuilder: (context, index) {
            ListProductCategory data =
                controller.filterrdProductObjectList[index];

            return Container(
              padding: EdgeInsets.only(
                left: 1.5.w,
                right: 1.5.w,
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                insetPadding: EdgeInsets.symmetric(
                                    vertical: 20.h, horizontal: 4.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Adjust the radius as needed
                                ),
                                elevation: 0.0, // No shadow
                                //clipBehavior: Clip.antiAlias,
                                backgroundColor: isDarkMode() ? black : white,
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 3.h,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 55.w,
                                              child: Marquee(
                                                style: TextStyle(
                                                  fontFamily: fontRegular,
                                                  color: isDarkMode()
                                                      ? white
                                                      : black,
                                                  fontSize:
                                                      SizerUtil.deviceType ==
                                                              DeviceType.mobile
                                                          ? 16.sp
                                                          : 10.sp,
                                                ),
                                                text:
                                                    "PRODUCT CATEGORY DETAILS",
                                                scrollAxis: Axis
                                                    .horizontal, // Use Axis.vertical for vertical scrolling
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start, // Adjust as needed
                                                blankSpace:
                                                    20.0, // Adjust the space between text repetitions
                                                velocity:
                                                    50.0, // Adjust the scrolling speed
                                                pauseAfterRound: const Duration(
                                                    seconds:
                                                        1), // Time to pause after each scroll
                                                startPadding: 2
                                                    .w, // Adjust the initial padding
                                                accelerationDuration:
                                                    const Duration(
                                                        seconds:
                                                            1), // Duration for acceleration
                                                accelerationCurve: Curves
                                                    .linear, // Acceleration curve
                                                decelerationDuration:
                                                    const Duration(
                                                        milliseconds:
                                                            500), // Duration for deceleration
                                                decelerationCurve: Curves
                                                    .easeOut, // Deceleration curve
                                              ),
                                            ),
                                            Spacer(),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Icon(
                                                  Icons.cancel,
                                                  size: 24.0,
                                                  color: isDarkMode()
                                                      ? white
                                                      : black,
                                                ),
                                              ),
                                            ),
                                          ]),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15)),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: data
                                                            .uploadInfo.image !=
                                                        null
                                                    ? '${ApiUrl.ImgUrl}${data.uploadInfo.image}'
                                                    // '${ip}${data.photoUrlInfo.image}'
                                                    : "",
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: primaryColor),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Category Name : ",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w800,
                                                color: isDarkMode()
                                                    ? white
                                                    : black,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                data.name.capitalize.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: SizerUtil
                                                                .deviceType ==
                                                            DeviceType.mobile
                                                        ? 12.sp
                                                        : 10.sp,
                                                    color: isDarkMode()
                                                        ? white
                                                        : black,
                                                    fontFamily: fontRegular),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Description : ",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w800,
                                            color: isDarkMode() ? white : black,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            data.description.toString(),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize:
                                                    SizerUtil.deviceType ==
                                                            DeviceType.mobile
                                                        ? 12.sp
                                                        : 12.sp,
                                                color: isDarkMode()
                                                    ? white
                                                    : black,
                                                fontFamily: fontRegular),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );

                          // Get.to(FullScreenImage(
                          //   imageUrl:
                          //       '${ApiUrl.ImgUrl}${data.uploadInfo.image}',
                          //   title: "Product Category",
                          // ))!
                          //     .then(
                          //         (value) => {Common().trasparent_statusbar()});
                        },
                        child: Container(
                            height: 11.h,
                            width: 60.w,
                            // padding: EdgeInsets.all(
                            //   SizerUtil.deviceType == DeviceType.mobile
                            //       ? 1.2.w
                            //       : 1.0.w,
                            // ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: data.uploadInfo.image != null
                                    ? '${ApiUrl.ImgUrl}${data.uploadInfo.image}'

                                    // '${ip}${data.uploadInfo.image}'
                                    : "",
                                placeholder: (context, url) => const Center(
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
                            )),
                      )

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
                  // SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          data.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isDarkMode() ? white : black,
                            fontFamily: opensansMedium,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // SizedBox(height: 5.0),
                    ],
                  ),

                  // SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          data.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isDarkMode() ? white : black,
                            fontFamily: opensansMedium,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      // Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.to(AddProductCategoryScreen(
                                  isEdit: true, editProductCategory: data))
                              ?.then((value) {
                            if (value == true) {
                              controller.getProductCategoryList(context, false);
                            }
                          });
                        },
                        child: Container(
                          child: SvgPicture.asset(
                            Asset.edit,
                            height: 2.2.h,
                            color: isDarkMode() ? Colors.grey : Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(width: 1.w),
                      GestureDetector(
                        onTap: () {
                          showDeleteConfirmationDialog(data.id);
                        },
                        child: Container(
                          child: Icon(
                            Icons.delete_rounded,
                            color: isDarkMode() ? Colors.grey : Colors.grey,
                            size: 2.9.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          itemCount: controller.filterrdProductObjectList.length,
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
