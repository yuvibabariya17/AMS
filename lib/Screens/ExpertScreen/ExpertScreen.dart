import 'package:booking_app/Config/apicall_constant.dart';
import 'package:booking_app/controllers/Expert_controller.dart';
import 'package:booking_app/core/Common/Common.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:booking_app/preference/UserPreference.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:sizer/sizer.dart';
import '../../Models/ExpertModel.dart';
import '../../Models/Listofexpert.dart';
import '../../Models/Listofexpert_model.dart';
import '../../controllers/internet_controller.dart';
import '../../core/Common/toolbar.dart';
import '../../core/constants/assets.dart';
import '../../core/themes/color_const.dart';
import '../../core/themes/font_constant.dart';
import '../../core/utils/helper.dart';
import '../../core/utils/log.dart';
import 'AddExpertScreen.dart';

class ExpertScreen extends StatefulWidget {
  const ExpertScreen({super.key});

  @override
  State<ExpertScreen> createState() => _ExpertScreenState();
}

class _ExpertScreenState extends State<ExpertScreen> {
  var controller = Get.put(expertcontroller());
  List<ExpertItems> staticData = Expert_Items;
  final InternetController networkManager = Get.find<InternetController>();

  TextEditingController search = TextEditingController();

  @override
  void initState() {
    controller.getExpertList(context, true);
    controller.filteredExpertObjectList = controller.expertObjectList;
    getIp();

    super.initState();
  }

  void filterExpertList(String query) {
    setState(() {
      if (query.isEmpty) {
        controller.filteredExpertObjectList = controller.expertObjectList;
      } else {
        controller.filteredExpertObjectList = controller.expertObjectList
            .where((data) =>
                data.name.toLowerCase().contains(query.toLowerCase()) ||
                data.amount.toString().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  String formatTime(String timeString) {
    // Parse the time string into a DateTime object
    DateTime dateTime = DateTime.parse(timeString);
    // Format the time into the desired format
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  }

  String ip = '';

  getIp() async {
    ip = await UserPreferences().getBuildIP();
    logcat("IMAGE_URL", ip.toString());
    setState(() {});
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
                Get.to(AddExpertScreen())?.then((value) {
                  if (value == true) {
                    logcat("ISDONE", "DONE");
                    controller.getExpertList(context, false);
                  }
                });
              },
              child: Icon(
                Icons.add,
                color: isDarkMode() ? black : white,
                size: SizerUtil.deviceType == DeviceType.mobile ? null : 3.h,
              )),
        ),
        body: Column(
          children: [
            getCommonToolbar(ScreenTitle.expert, () {
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
                    filterExpertList(value);
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
                        controller.getExpertList(context, true);
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

  Future<void> showDeleteConfirmationDialog(String expertId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoTheme(
          data: CupertinoThemeData(
            brightness: isDarkMode()
                ? Brightness.dark
                : Brightness.light, // Set the brightness to light
            scaffoldBackgroundColor: white, // Set the background color to white
            textTheme: CupertinoTextThemeData(
              textStyle: TextStyle(color: black), // Set text color to black
            ),
          ),
          child: CupertinoAlertDialog(
            title: Text('Confirm Delete',
                style: TextStyle(
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 17.sp
                        : 9.sp,
                    color: isDarkMode() ? white : black)),
            content: Text('Are you sure you want to delete this Expert?',
                style: TextStyle(
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 12.sp
                        : 7.sp,
                    color: isDarkMode() ? white : black)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Cancel',
                    style: TextStyle(
                        fontSize: SizerUtil.deviceType == DeviceType.mobile
                            ? 11.sp
                            : 8.sp,
                        color: isDarkMode() ? white : black)),
              ),
              TextButton(
                onPressed: () {
                  controller.deleteExpertList(context, expertId);
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  'Yes',
                  style: TextStyle(
                    color: isDarkMode() ? white : black,
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 11.sp
                        : 8.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget apiSuccess(ScreenState state) {
    logcat("LENGTH", controller.expertObjectList.length.toString());
    // ignore: unrelated_type_equality_checks
    if (controller.state == ScreenState.apiSuccess &&
        controller.filteredExpertObjectList.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(
          left: SizerUtil.deviceType == DeviceType.mobile ? 8.w : 6.3.w,
          right: SizerUtil.deviceType == DeviceType.mobile ? 8.w : 6.3.w,
        ),
        child: getExpertList(),
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

  getExpertList() {
    return GridView.builder(
      shrinkWrap: true,
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.only(
          bottom: SizerUtil.deviceType == DeviceType.mobile ? 10.h : 9.h),
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: SizerUtil.deviceType == DeviceType.mobile
            ? 2
            : 3, // Adjust the number of columns as needed
        crossAxisSpacing: 10.0,
        childAspectRatio: SizerUtil.deviceType == DeviceType.mobile ? 1.0 : 1.2,
        mainAxisSpacing:
            SizerUtil.deviceType == DeviceType.mobile ? 10.0 : 15.0,
      ),
      itemBuilder: (context, index) {
        ExpertList data = controller.filteredExpertObjectList[index];
        return Container(
          padding: EdgeInsets.only(
            left: SizerUtil.deviceType == DeviceType.mobile ? 1.5.w : 0.5.w,
            right: SizerUtil.deviceType == DeviceType.mobile ? 1.5.w : 0.5.w,
          ),
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
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    //CLICPRRECT
                    GestureDetector(
                      onTap: () {
                        getExpertDetails(context, data);

                        // Get.to(FullScreenImage(
                        //   imageUrl:
                        //       '${ApiUrl.ImgUrl}${data.upload_info.image}',
                        //   title: ScreenTitle.expert,
                        // ))!
                        //     .then(
                        //         (value) => {Common().trasparent_statusbar()});
                      },
                      child: Container(
                          height: SizerUtil.deviceType == DeviceType.mobile
                              ? 11.h
                              : 8.h,
                          width: SizerUtil.deviceType == DeviceType.mobile
                              ? 60.w
                              : 50.w,
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
                              imageUrl:
                                  '${ApiUrl.ImgUrl}${data.upload_info.image}',

                              //   '${ip}${data.upload_info.image}',
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                    color: primaryColor),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                Asset.placeholder,
                                height: 11.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                    )
                  ],
                ),
                // SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                      data.name.capitalize.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: isDarkMode() ? white : black,
                          fontFamily: opensansMedium,
                          fontSize: SizerUtil.deviceType == DeviceType.mobile
                              ? 14.sp
                              : 7.sp,
                          fontWeight: FontWeight.w700),
                    )),
                  ],
                ),
                SizedBox(
                    height: SizerUtil.deviceType == DeviceType.mobile
                        ? 5.0
                        : 0.1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        data.serviceInfo.name.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        // '₹ ${data.amount.toString()}',
                        // data.serviceInfo != null
                        //     ? data.serviceInfo!.name
                        //     : "",
                        style: TextStyle(
                            color: isDarkMode() ? white : black,
                            fontFamily: opensansMedium,
                            fontSize: SizerUtil.deviceType == DeviceType.mobile
                                ? 11.sp
                                : 6.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(AddExpertScreen(isEdit: true, editExpert: data))
                            ?.then((value) {
                          if (value == true) {
                            controller.getExpertList(context, false);
                          }
                        });
                      },
                      child: Container(
                        child: SvgPicture.asset(
                          Asset.edit,
                          height: SizerUtil.deviceType == DeviceType.mobile
                              ? 2.3.h
                              : 2.h,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.0),
                    GestureDetector(
                      onTap: () {
                        Common().commonDeleteDialog(context, "Expert", () {
                          controller.deleteExpertList(context, data.id);
                        });
                        //  showDeleteConfirmationDialog(data.id);
                      },
                      child: Container(
                        child: Icon(
                          Icons.delete_rounded,
                          color: Colors.grey,
                          size: SizerUtil.deviceType == DeviceType.mobile
                              ? 3.h
                              : 2.8.h,
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
      itemCount: controller.filteredExpertObjectList.length,
    );
  }

  getExpertDetails(BuildContext context, ExpertList data) {
    return Common().commonDetailsDialog(
      context,
      "EXPERT DETAILS",
      isNotes: true,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: SizerUtil.deviceType == DeviceType.mobile ? 11.h : 18.h,
              width: SizerUtil.deviceType == DeviceType.mobile ? 60.w : 40.w,
              // padding: EdgeInsets.all(
              //   SizerUtil.deviceType == DeviceType.mobile
              //       ? 1.2.w
              //       : 1.0.w,
              // ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: data.upload_info.image != null
                      ? '${ApiUrl.ImgUrl}${data.upload_info.image}'
                      // '${ip}${data.photoUrlInfo.image}'
                      : "",
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Expert Name : ",
                style: TextStyle(
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 8.sp,
                  fontWeight: FontWeight.w800,
                  color: isDarkMode() ? white : black,
                ),
              ),
              Expanded(
                child: Text(
                  data.name.capitalize.toString(),
                  overflow: TextOverflow.visible,
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? 12.sp
                          : 8.sp,
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
                "Service : ",
                style: TextStyle(
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 8.sp,
                  fontWeight: FontWeight.w800,
                  color: isDarkMode() ? white : black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // controller.launchPhoneCall(
                  //     data.customerInfo.contactNo);
                },
                child: Text(
                  data.serviceInfo.name.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? 12.sp
                          : 8.sp,
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
                "Start Time : ",
                style: TextStyle(
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 8.sp,
                  fontWeight: FontWeight.w800,
                  color: isDarkMode() ? white : black,
                ),
              ),
              Text(
                formatTime(
                  data.startTime.toString(),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 12.sp
                        : 8.sp,
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
                "End Time : ",
                style: TextStyle(
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 8.sp,
                  fontWeight: FontWeight.w800,
                  color: isDarkMode() ? white : black,
                ),
              ),
              Text(
                formatTime(
                  data.endTime.toString(),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 12.sp
                        : 8.sp,
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
                "Amount : ",
                style: TextStyle(
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 8.sp,
                  fontWeight: FontWeight.w800,
                  color: isDarkMode() ? white : black,
                ),
              ),
              Text(
                '₹ ${data.amount.toString()}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 12.sp
                        : 8.sp,
                    color: isDarkMode() ? white : black,
                    fontFamily: fontRegular),
              ),
            ],
          ),
        ],
      ),
    );
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

      // Center(
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(100),
      //     child: Container(
      //       height: 50,
      //       width: 50,
      //       child: Image.asset(
      //         "assets/gif/apiloader.gif",
      //         width: 50,
      //         height: 50,
      //       ),
      //     ),
      //   ),
      // );
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
        controller.getExpertList(context, true);
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
