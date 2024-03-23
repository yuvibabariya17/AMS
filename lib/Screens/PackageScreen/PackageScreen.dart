import 'package:booking_app/Models/PackageModel.dart';
import 'package:booking_app/Screens/PackageScreen/AddPackageScreen%20.dart';
import 'package:booking_app/controllers/PackageController.dart';
import 'package:booking_app/core/Common/Common.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';
import '../../Models/Listofexpert.dart';
import '../../Models/Listofexpert_model.dart';
import '../../controllers/internet_controller.dart';
import '../../core/Common/toolbar.dart';
import '../../core/constants/assets.dart';
import '../../core/themes/color_const.dart';
import '../../core/themes/font_constant.dart';
import '../../core/utils/helper.dart';
import '../../core/utils/log.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  bool isReadMore = false;

  var controller = Get.put(PackageController());
  List<ExpertItems> staticData = Expert_Items;
  final InternetController networkManager = Get.find<InternetController>();

  TextEditingController _search = TextEditingController();

  @override
  void initState() {
    controller.getPackageList(context, true);
    controller.filteredPackageObjectList = controller.packageObjectList;
    super.initState();
  }

  void filterPackageList(String query) {
    setState(() {
      if (query.isEmpty) {
        controller.filteredPackageObjectList = controller.packageObjectList;
      } else {
        controller.filteredPackageObjectList = controller.packageObjectList
            .where(
                (data) => data.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Common().trasparent_statusbar();
    return CustomScaffold(
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
                Get.to(AddPackageScreen())?.then((value) {
                  if (value == true) {
                    logcat("ISDONE", "DONE");
                    controller.getPackageList(context, false);
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
        body: Column(
          children: [
            getCommonToolbar("Package", () {
              Get.back();
            }),
            Container(
              margin: EdgeInsets.only(
                top: 3.h,
                left: 1.0.w,
                right: 1.0.w,
              ),
              padding: EdgeInsets.only(
                left: 7.0.w,
                right: 7.0.w,
              ),
              child: Container(
                height: 5.5.h,
                child: TextField(
                  onChanged: (value) {
                    filterPackageList(value);
                  },
                  style: TextStyle(color: isDarkMode() ? white : black),
                  decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: isDarkMode() ? white : black,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 1.h, left: 2.h, bottom: 1.h),
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
                  controller: _search,
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
                        controller.getPackageList(context, true);
                      },
                    );
                  },
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
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
                                    margin:
                                        EdgeInsets.only(top: 5.h, bottom: 5.h),
                                    height: SizerUtil.height / 1.5,
                                    child:
                                        apiOtherStates(controller.state.value),
                                  );
                                case ScreenState.apiSuccess:
                                  return Container(
                                      margin: EdgeInsets.only(
                                          bottom: 3.h, top: 2.h),
                                      child:
                                          apiSuccess(controller.state.value));
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  String formatDate(String dateTimeString) {
    // Parse the date string into a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format the DateTime object into the desired format
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

    return formattedDate;
  }

  void main() {
    String backendFromDate = '2023-07-01T00:00:00.704Z';
    String backendToDate = '2023-08-15T00:00:00.704Z';
    String formattedFromDate = formatDate(backendFromDate);
    String formattedToDate = formatDate(backendToDate);

    String formattedDates = '$formattedFromDate To $formattedToDate';
    print(formattedDates); // Output: 01-07-2023 To 15-08-2023
  }

  Future<void> showDeleteConfirmationDialog(String expertId) async {
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
            content: Text('Are you sure you want to delete this Package?',
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
                  controller.deletePackageList(context, expertId);
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
    logcat("LENGTH", controller.packageObjectList.length.toString());
    // ignore: unrelated_type_equality_checks
    if (controller.state == ScreenState.apiSuccess &&
        controller.filteredPackageObjectList.isNotEmpty) {
      return Container(child: getPackageList());
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

  getPackageList() {
    return ListView.builder(
      shrinkWrap: true,
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.only(
          bottom: SizerUtil.deviceType == DeviceType.mobile ? 10.h : 9.h),
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        PackageList data = controller.filteredPackageObjectList[index];

        return Container(
          padding:
              EdgeInsets.only(left: 3.w, right: 3.w, top: 1.h, bottom: 1.h),
          margin: EdgeInsets.only(
            left: SizerUtil.deviceType == DeviceType.mobile ? 8.w : 6.3.w,
            right: SizerUtil.deviceType == DeviceType.mobile ? 8.w : 6.3.w,
            bottom: SizerUtil.deviceType == DeviceType.mobile ? 1.h : 1.h,
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
          child: GestureDetector(
            onTap: () {
              getShowDetailsOfDialog(context, data);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                      data.name.capitalize.toString(),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: isDarkMode() ? white : black,
                          fontFamily: opensansMedium,
                          fontSize: SizerUtil.deviceType == DeviceType.mobile
                              ? 14.sp
                              : 8.sp,
                          fontWeight: FontWeight.w700),
                    )),
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
                        'Valid From : ' +
                            formatDate(data.durationFrom.toString()) +
                            ' to ' +
                            formatDate(data.durationTo.toString()),
                        // data.durationFrom.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: isDarkMode() ? white : black,
                            fontFamily: opensansMedium,
                            fontSize: SizerUtil.deviceType == DeviceType.mobile
                                ? 10.sp
                                : 7.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),

                    // Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(AddPackageScreen(
                                isEdit: true, editPackage: data))
                            ?.then((value) {
                          if (value == true) {
                            controller.getPackageList(context, false);
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
                        Common().commonDeleteDialog(context, "Package", () {
                          controller.deletePackageList(context, data.id);
                        });
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
          ),
        );
      },
      itemCount: controller.filteredPackageObjectList.length,
    );
  }

  getShowDetailsOfDialog(BuildContext context, PackageList data) {
    return Common().commonDetailsDialog(
        context,
        "Package Details",
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Package Name : ",
                    style: TextStyle(
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? 12.sp
                          : 6.sp,
                      fontWeight: FontWeight.w800,
                      color: isDarkMode() ? white : black,
                    ),
                  ),
                  Expanded(
                    // flex: 2,
                    child: Text(
                      data.name.capitalize.toString(),
                      overflow: TextOverflow.visible,
                      maxLines: 5,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: SizerUtil.deviceType == DeviceType.mobile
                              ? 12.sp
                              : 6.sp,
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
                    "Actual Fees : ",
                    style: TextStyle(
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? 12.sp
                          : 6.sp,
                      fontWeight: FontWeight.w800,
                      color: isDarkMode() ? white : black,
                    ),
                  ),
                  Text(
                    '₹ ${data.actFees.toString()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: SizerUtil.deviceType == DeviceType.mobile
                            ? 12.sp
                            : 6.sp,
                        color: isDarkMode() ? white : black,
                        fontFamily: fontRegular),
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
                    "Package Fees : ",
                    style: TextStyle(
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? 12.sp
                          : 6.sp,
                      fontWeight: FontWeight.w800,
                      color: isDarkMode() ? white : black,
                    ),
                  ),
                  Text(
                    '₹ ${data.packFees.toString()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: SizerUtil.deviceType == DeviceType.mobile
                            ? 12.sp
                            : 6.sp,
                        color: isDarkMode() ? white : black,
                        fontFamily: fontRegular),
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
                    "Start From : ",
                    style: TextStyle(
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? 12.sp
                          : 6.sp,
                      fontWeight: FontWeight.w800,
                      color: isDarkMode() ? white : black,
                    ),
                  ),
                  Text(
                    formatDate(data.durationFrom.toString()),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: SizerUtil.deviceType == DeviceType.mobile
                            ? 12.sp
                            : 6.sp,
                        color: isDarkMode() ? white : black,
                        fontFamily: fontRegular),
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
                    "End to : ",
                    style: TextStyle(
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? 12.sp
                          : 6.sp,
                      fontWeight: FontWeight.w800,
                      color: isDarkMode() ? white : black,
                    ),
                  ),
                  Text(
                    formatDate(data.durationTo.toString()),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: SizerUtil.deviceType == DeviceType.mobile
                            ? 12.sp
                            : 6.sp,
                        color: isDarkMode() ? white : black,
                        fontFamily: fontRegular),
                  ),
                ],
              ),
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
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? 12.sp
                          : 6.sp,
                      fontWeight: FontWeight.w800,
                      color: isDarkMode() ? white : black,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: SizerUtil.deviceType == DeviceType.mobile
                          ? 10.w
                          : 5.w,
                      height: SizerUtil.deviceType == DeviceType.mobile
                          ? 10.h
                          : 10.h,
                      child: Scrollbar(
                        thumbVisibility: true,
                        thickness: 1.5,
                        radius: Radius.circular(50),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(
                            data.otherNotes.toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize:
                                    SizerUtil.deviceType == DeviceType.mobile
                                        ? 12.sp
                                        : 6.sp,
                                color: isDarkMode() ? white : black,
                                fontFamily: fontRegular),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Expanded(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Other Notes : ",
              //         style: TextStyle(
              //           fontSize: 12.sp,
              //           fontWeight: FontWeight.w800,
              //           color: isDarkMode() ? white : black,
              //         ),
              //       ),
              //       Expanded(
              //         child: Container(
              //           width: 20.w,
              //           child: ReadMoreText(
              //             data.otherNotes.toString(),
              //             preDataTextStyle:
              //                 TextStyle(fontWeight: FontWeight.w500),
              //             style: TextStyle(color: Colors.black),
              //             colorClickableText: Colors.red,
              //             trimMode: TrimMode.Line,
              //             trimLines: 3,
              //             textAlign: TextAlign.start,
              //             trimCollapsedText: 'Show more',
              //             trimExpandedText: ' show less',
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ));
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
        controller.getPackageList(context, false);
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
