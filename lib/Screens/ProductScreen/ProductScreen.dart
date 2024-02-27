import 'package:booking_app/Config/apicall_constant.dart';
import 'package:booking_app/Models/ProductListModel.dart';
import 'package:booking_app/Screens/ProductScreen/AddProductScreen.dart';
import 'package:booking_app/controllers/ProductController.dart';
import 'package:booking_app/core/Common/Common.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:booking_app/dialogs/ImageScreen.dart';
import 'package:booking_app/preference/UserPreference.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/Common/toolbar.dart';
import '../../core/constants/strings.dart';
import '../../core/themes/color_const.dart';
import '../../core/themes/font_constant.dart';
import '../../core/utils/helper.dart';
import '../../core/utils/log.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final controller = Get.put(ProductController());

  TextEditingController search = TextEditingController();

  @override
  void initState() {
    controller.getProductList(context, true);
    controller.filteredProductObjectList = controller.productObjectList;
    getIp();
    super.initState();
    getIp();
  }

  void initDataSet() {}

  String ip = '';

  getIp() async {
    ip = await UserPreferences().getBuildIP();
    logcat("IMAGE_URL", ip.toString());
    setState(() {});
  }

  void filterProductList(String query) {
    setState(() {
      if (query.isEmpty) {
        controller.filteredProductObjectList = controller.productObjectList;
      } else {
        controller.filteredProductObjectList = controller.productObjectList
            .where((data) =>
                data.name.toLowerCase().contains(query.toLowerCase()) ||
                data.amount
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

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
                  Get.to(AddProductScreen())?.then((value) {
                    if (value == true) {
                      logcat("ISDONE", "DONE");
                      controller.getProductList(context, false);
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
            getCommonToolbar("Product", () {
              Get.back();
            }),
            Container(
              margin: EdgeInsets.only(top: 3.h, left: 1.0.w, right: 1.0.w),
              padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
              child: Container(
                height: 5.5.h,
                child: TextField(
                  onChanged: ((value) {
                    filterProductList(value);
                  }),
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
                        controller.getProductList(context, true);
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

  Future<void> showDeleteConfirmationDialog(String productId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Confirm Delete', style: TextStyle(fontSize: 17.sp)),
          content: Text('Are you sure you want to delete this Product?',
              style: TextStyle(fontSize: 12.sp)),
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
                controller.deleteProductList(context, productId);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Yes',
                style: TextStyle(
                    color: isDarkMode() ? white : black, fontSize: 11.sp),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget apiSuccess(ScreenState state) {
    logcat("LENGTH", controller.productObjectList.length.toString());
    // ignore: unrelated_type_quality_checks
    if (controller.state == ScreenState.apiSuccess &&
        controller.filteredProductObjectList.isNotEmpty) {
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
            ListofProduct data = controller.filteredProductObjectList[index];

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
                          Get.to(FullScreenImage(
                            imageUrl:
                                '${ApiUrl.ImgUrl}${data.uploadInfo.image}',
                            title: ScreenTitle.expert,
                          ))!
                              .then(
                                  (value) => {Common().trasparent_statusbar()});
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
                      // CachedNetworkImage(
                      //   fit: BoxFit.cover,
                      //   imageUrl: "data.pic,",
                      //   placeholder: (context, url) => SvgPicture.asset(
                      //     Asset.profileimg,
                      //     color: isDarkMode()
                      //         ? Colors.white
                      //         : Colors.black,
                      //     height: 4.5.h,
                      //     fit: BoxFit.cover,
                      //   ),
                      //   errorWidget: (context, url, error) =>
                      //       SvgPicture.asset(
                      //     Asset.profileimg,
                      //     color: isDarkMode()
                      //         ? Colors.white
                      //         : Colors.black,
                      //     height: 4.5.h,
                      //     fit: BoxFit.cover,
                      //   ),
                      // )
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
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isDarkMode() ? white : black,
                            fontFamily: opensansMedium,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //     height:
                  //         5.0), // You can adjust the spacing as needed
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '₹ ${data.amount.toString()}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: opensansMedium,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.to(AddProductScreen(
                                  isEdit: true, editProduct: data))
                              ?.then((value) {
                            if (value == true) {
                              controller.getProductList(context, false);
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
          itemCount: controller.filteredProductObjectList.length,
        ),
      );

      // Container(
      //     margin: EdgeInsets.only(left: 7.w, right: 7.w),
      //     child: GridView.builder(
      //       shrinkWrap: true,
      //       clipBehavior: Clip.antiAlias,
      //       physics: BouncingScrollPhysics(),
      //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 2, // Adjust the number of columns as needed
      //         crossAxisSpacing: 10.0,
      //         mainAxisSpacing: 10.0,
      //       ),
      //       itemBuilder: (context, index) {
      //         ListofProduct data =
      //             controller.filteredProductObjectList[index];

      //         return Container(
      //           padding: EdgeInsets.only(left: 5.w, right: 5.w),
      //           decoration: BoxDecoration(
      //             color: isDarkMode() ? black : white,
      //             borderRadius: BorderRadius.all(Radius.circular(25)),
      //             boxShadow: [
      //               BoxShadow(
      //                 color: isDarkMode()
      //                     ? Colors.white.withOpacity(0.2)
      //                     : Colors.black.withOpacity(0.2),
      //                 spreadRadius: 0.1,
      //                 blurRadius: 10,
      //                 offset: Offset(0.5, 0.5),
      //               ),
      //             ],
      //           ),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               Stack(children: [
      //                 CachedNetworkImage(
      //                   fit: BoxFit.cover,
      //                   imageUrl: "data.pic,",
      //                   placeholder: (context, url) => SvgPicture.asset(
      //                     Asset.profileimg,
      //                     color:
      //                         isDarkMode() ? Colors.white : Colors.black,
      //                     height: 4.5.h,
      //                     fit: BoxFit.cover,
      //                   ),
      //                   errorWidget: (context, url, error) =>
      //                       SvgPicture.asset(
      //                     Asset.profileimg,
      //                     color:
      //                         isDarkMode() ? Colors.white : Colors.black,
      //                     height: 4.5.h,
      //                     fit: BoxFit.cover,
      //                   ),
      //                 )
      //                 // CircleAvatar(
      //                 //   radius: 3.5.h,
      //                 //   backgroundColor: Colors.white,
      //                 //   child: SvgPicture.asset(
      //                 //     data.pic,
      //                 //     fit: BoxFit.cover,
      //                 //   ),
      //                 // ),
      //               ]),
      //               SizedBox(height: 10.0),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Container(
      //                     child: Text(
      //                       data.name,
      //                       overflow: TextOverflow.ellipsis,
      //                       style: TextStyle(
      //                           color: isDarkMode() ? white : black,
      //                           fontFamily: opensansMedium,
      //                           fontSize: 15.5.sp,
      //                           fontWeight: FontWeight.w700),
      //                     ),
      //                   ),
      //                   SizedBox(height: 5.0),
      //                 ],
      //               ),
      //               Row(children: []),
      //               // SizedBox(height: 5.0),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 children: [
      //                   Text(
      //                     '₹ ${data.amount.toString()}',
      //                     // data.fees.toString(),
      //                     // '${model.fullName.capitalize} (${model.age} Years)'
      //                     style: TextStyle(
      //                         fontFamily: opensansMedium,
      //                         fontSize: 16.sp,
      //                         fontWeight: FontWeight.w600),
      //                   ),
      //                   Spacer(),
      //                   GestureDetector(
      //                     onTap: () {
      //                       // Handle edit action
      //                     },
      //                     child: Container(
      //                       child: SvgPicture.asset(
      //                         Asset.edit,
      //                         height: 2.3.h,
      //                         color: isDarkMode()
      //                             ? Colors.grey
      //                             : Colors.grey,
      //                       ),
      //                     ),
      //                   ),
      //                   SizedBox(width: 5.0),
      //                   GestureDetector(
      //                     onTap: () {
      //                       // Handle delete action
      //                     },
      //                     child: Container(
      //                       child: Icon(
      //                         Icons.delete_rounded,
      //                         color: isDarkMode()
      //                             ? Colors.grey
      //                             : Colors.grey,
      //                         size: 3.h,
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         );
      //       },
      //       itemCount: controller.filteredProductObjectList.length,
      //     ),
      //   )

      // ListView.builder(
      //     shrinkWrap: true,
      //     clipBehavior: Clip.antiAlias,
      //     physics: BouncingScrollPhysics(),
      //     itemBuilder: (context, index) {
      //       ListofProduct data =
      //           controller.filteredProductObjectList[index];
      //       // hairservice data = staticData[index];
      //       // logcat("DATAAA", controller.serviceObjectList);
      //       return Container(
      //         margin: EdgeInsets.only(
      //             top: 1.h, left: 7.w, right: 7.w, bottom: 1.h),
      //         child: Expanded(
      //           child: Container(
      //             padding: EdgeInsets.only(
      //                 top: 1.h, left: 3.w, right: 4.w, bottom: 1.h),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   crossAxisAlignment: CrossAxisAlignment.center,
      //                   children: [
      //                     Stack(children: [
      //                       CachedNetworkImage(
      //                         fit: BoxFit.cover,
      //                         imageUrl: "data.pic,",
      //                         placeholder: (context, url) =>
      //                             SvgPicture.asset(
      //                           Asset.profileimg,
      //                           color: isDarkMode()
      //                               ? Colors.white
      //                               : Colors.black,
      //                           height: 4.5.h,
      //                           fit: BoxFit.cover,
      //                         ),
      //                         errorWidget: (context, url, error) =>
      //                             SvgPicture.asset(
      //                           Asset.profileimg,
      //                           color: isDarkMode()
      //                               ? Colors.white
      //                               : Colors.black,
      //                           height: 4.5.h,
      //                           fit: BoxFit.cover,
      //                         ),
      //                       )
      //                       // CircleAvatar(
      //                       //   radius: 3.5.h,
      //                       //   backgroundColor: Colors.white,
      //                       //   child: SvgPicture.asset(
      //                       //     data.pic,
      //                       //     fit: BoxFit.cover,
      //                       //   ),
      //                       // ),
      //                     ]),
      //                     SizedBox(width: 5.5.w),
      //                     Expanded(
      //                       child: Column(
      //                         mainAxisAlignment: MainAxisAlignment.start,
      //                         crossAxisAlignment:
      //                             CrossAxisAlignment.start,
      //                         children: [
      //                           Row(
      //                               mainAxisAlignment:
      //                                   MainAxisAlignment.start,
      //                               crossAxisAlignment:
      //                                   CrossAxisAlignment.center,
      //                               children: [
      //                                 Container(
      //                                   child: Text(
      //                                     data.name,
      //                                     style: TextStyle(
      //                                         fontFamily: opensansMedium,
      //                                         fontSize: 15.sp,
      //                                         fontWeight:
      //                                             FontWeight.w700),
      //                                   ),
      //                                 ),
      //                                 Spacer(),
      //                                 GestureDetector(
      //                                   onTap: () {
      //                                     // Get.to(AddServiceScreen(
      //                                     //     isEdit: true,
      //                                     //     editService: data));
      //                                   },
      //                                   child: Container(
      //                                       child: SvgPicture.asset(
      //                                           Asset.edit,
      //                                           height: 2.3.h,
      //                                           color: isDarkMode()
      //                                               ? Colors.grey
      //                                               : Colors.grey)),
      //                                 ),
      //                                 SizedBox(
      //                                   width: 2.w,
      //                                 ),
      //                                 GestureDetector(
      //                                   onTap: () {
      //                                     showDeleteConfirmationDialog(
      //                                         data.id);
      //                                   },
      //                                   child: Container(
      //                                       child: Icon(
      //                                     Icons.delete_rounded,
      //                                     color: isDarkMode()
      //                                         ? Colors.grey
      //                                         : Colors.grey,
      //                                     size: 3.h,
      //                                   )),
      //                                 ),
      //                               ]),
      //                           Container(
      //                             margin: EdgeInsets.only(top: 0.5.h),
      //                             child: Text(
      //                               '₹ ${data.amount.toString()}',
      //                               // data.fees.toString(),
      //                               // '${model.fullName.capitalize} (${model.age} Years)'
      //                               style: TextStyle(
      //                                   fontFamily: opensansMedium,
      //                                   fontSize: 16.sp,
      //                                   fontWeight: FontWeight.w600),
      //                             ),
      //                           ),
      //                           // Row(
      //                           //     mainAxisAlignment:
      //                           //         MainAxisAlignment.spaceBetween,
      //                           //     crossAxisAlignment:
      //                           //         CrossAxisAlignment.center,
      //                           //     children: [
      //                           //       Container(
      //                           //         child: Text(
      //                           //           data.email,
      //                           //           style: TextStyle(
      //                           //               fontFamily: opensansMedium,
      //                           //               fontSize: 11.sp,
      //                           //               fontWeight:
      //                           //                   FontWeight.w400),
      //                           //         ),
      //                           //       ),
      //                           //     ]),
      //                         ],
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //             decoration: BoxDecoration(
      //               color: isDarkMode() ? black : white,
      //               borderRadius: BorderRadius.all(Radius.circular(25)),
      //               boxShadow: [
      //                 BoxShadow(
      //                     color: isDarkMode()
      //                         ? Colors.white.withOpacity(0.2)
      //                         : Colors.black.withOpacity(0.2),
      //                     spreadRadius: 0.1,
      //                     blurRadius: 10,
      //                     offset: Offset(0.5, 0.5)),
      //               ],
      //             ),
      //           ),
      //         ),
      //       );
      //     },
      //     itemCount: controller.filteredProductObjectList.length,
      //   )
    } else {
      return Container(
        height: SizerUtil.height / 1.3,
        child: Center(
          child: Container(
            child: Text(
              CommonConstant.noDataFound,
              style: TextStyle(
                  fontFamily: fontMedium, fontSize: 12.sp, color: black),
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
        controller.getProductList(context, false);
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
