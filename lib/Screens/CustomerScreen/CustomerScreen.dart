import 'package:booking_app/Config/apicall_constant.dart';
import 'package:booking_app/Models/CustomerListModel.dart';
import 'package:booking_app/Screens/CustomerScreen/AddCustomerScreen.dart';
import 'package:booking_app/controllers/CustomerController.dart';
import 'package:booking_app/core/Common/Common.dart';
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
import 'package:url_launcher/url_launcher.dart';
import '../../core/Common/toolbar.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/strings.dart';
import '../../core/themes/color_const.dart';
import '../../core/themes/font_constant.dart';
import '../../core/utils/helper.dart';
import '../../core/utils/log.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final controller = Get.put(CustomerController());

  TextEditingController search = TextEditingController();
  @override
  void initState() {
    controller.getCustomerList(context, true);
    controller.filteredCustomerObjectList = controller.customerObjectList;
    getIp();
    super.initState();
  }

  String ip = '';

  getIp() async {
    ip = await UserPreferences().getBuildIP();
    logcat("IMAGE_URL", ip.toString());
    setState(() {});
  }

  void initdata() {}

  void filterServiceList(String query) {
    setState(() {
      if (query.isEmpty) {
        controller.filteredCustomerObjectList = controller.customerObjectList;
      } else {
        controller.filteredCustomerObjectList = controller.customerObjectList
            .where((data) =>
                data.name.toLowerCase().contains(query.toLowerCase()) ||
                data.contactNo
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  String formatDate(String dateTimeString) {
    // Parse the date string into a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format the DateTime object into the desired format
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

    return formattedDate;
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
                  Get.to(AddCustomerScreen())?.then((value) {
                    if (value == true) {
                      logcat("ISDONE", "DONE");
                      controller.getCustomerList(context, false);
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
            getCommonToolbar("Customer", () {
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
                              : 2.w,
                        ),
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
                        controller.getCustomerList(context, true);
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

  Future<void> showDeleteConfirmationDialog(String customerId) async {
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
            content: Text('Are you sure you want to delete this Customer?',
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
                  controller.deleteCustomerList(context, customerId);
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
    logcat("LENGTH", controller.customerObjectList.length.toString());
    // ignore: unrelated_type_quality_checks
    if (controller.state == ScreenState.apiSuccess &&
        controller.filteredCustomerObjectList.isNotEmpty) {
      return Container(
          margin: EdgeInsets.only(
            left: SizerUtil.deviceType == DeviceType.mobile ? 8.w : 6.3.w,
            right: SizerUtil.deviceType == DeviceType.mobile ? 8.w : 6.3.w,
          ),
          child: getCustomerList());
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

  getCustomerList() {
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
        ListofCustomer data = controller.filteredCustomerObjectList[index];
        return Container(
          padding: EdgeInsets.only(
            left: SizerUtil.deviceType == DeviceType.mobile ? 1.5.w : 1.w,
            right: SizerUtil.deviceType == DeviceType.mobile ? 1.5.w : 1.w,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(children: [
                GestureDetector(
                  onTap: () {
                    getCustomerDetails(context, data);
                    // Get.to(FullScreenImage(
                    //   imageUrl: '${ApiUrl.ImgUrl}${data.picInfo!.image}',
                    //   title: "Customer",
                    // ))!
                    //     .then((value) => {Common().trasparent_statusbar()});
                  },
                  child: Container(
                      height: SizerUtil.deviceType == DeviceType.mobile
                          ? 11.h
                          : 8.h,
                      width: SizerUtil.deviceType == DeviceType.mobile
                          ? 60.w
                          : 50.w,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: data.picInfo != null
                              ? '${ApiUrl.ImgUrl}${data.picInfo!.image}'
                              : "",
                          placeholder: (context, url) => const Center(
                            child:
                                CircularProgressIndicator(color: primaryColor),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            Asset.placeholder,
                            height: 11.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                )
              ]),
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
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      data.contactNo,
                      style: TextStyle(
                          color: isDarkMode() ? white : black,
                          fontFamily: opensansMedium,
                          fontSize: SizerUtil.deviceType == DeviceType.mobile
                              ? 12.sp
                              : 7.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.to(AddCustomerScreen(
                              isEdit: true, editCustomer: data))
                          ?.then((value) {
                        if (value == true) {
                          controller.getCustomerList(context, false);
                        }
                      });
                    },
                    child: Container(
                      child: SvgPicture.asset(
                        Asset.edit,
                        height: SizerUtil.deviceType == DeviceType.mobile
                            ? 2.3.h
                            : 2.h,
                        color: isDarkMode() ? Colors.grey : Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(width: 3.0),
                  GestureDetector(
                    onTap: () {
                      Common().commonDeleteDialog(context, "Customer", () {
                        controller.deleteCustomerList(context, data.id);
                      });

                      //showDeleteConfirmationDialog(data.id);
                    },
                    child: Container(
                      child: Icon(
                        Icons.delete_rounded,
                        color: isDarkMode() ? Colors.grey : Colors.grey,
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
        );
      },
      itemCount: controller.filteredCustomerObjectList.length,
    );
  }

  getCustomerDetails(
    BuildContext context,
    ListofCustomer data,
  ) {
    return Common().commonDetailsDialog(
      context,
      "Customer Details",
      isDescription: true,
      Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
            height: SizerUtil.deviceType == DeviceType.mobile ? 15.h : 18.h,
            width: SizerUtil.deviceType == DeviceType.mobile ? 70.w : 40.w,
            // padding: EdgeInsets.all(
            //   SizerUtil.deviceType == DeviceType.mobile
            //       ? 1.2.w
            //       : 1.0.w,
            // ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey, // Set your desired border color here
                  width: 1.0, // Set the width of the border
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: data.picInfo!.image != null
                      ? '${ApiUrl.ImgUrl}${data.picInfo!.image}'
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
              ),
            )),
        SizedBox(
          height: 2.h,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Customer Name : ",
                style: TextStyle(
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 6.sp,
                  fontWeight: FontWeight.w800,
                  color: isDarkMode() ? white : black,
                ),
              ),
              Expanded(
                child: Text(
                  data.name.capitalize.toString(),
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.start,
                  maxLines: 5,
                  style: TextStyle(
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? 12.sp
                          : 6.sp,
                      color: isDarkMode() ? white : black,
                      fontFamily: fontRegular),
                ),
              ),
            ]),
        SizedBox(
          height: 0.5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Date of Birth : ",
              style: TextStyle(
                fontSize:
                    SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 6.sp,
                fontWeight: FontWeight.w800,
                color: isDarkMode() ? white : black,
              ),
            ),
            Text(
              formatDate(
                data.dateOfBirth.toString(),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 6.sp,
                  color: isDarkMode() ? white : black,
                  fontFamily: fontRegular),
            ),
          ],
        ),
        SizedBox(
          height: 0.5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Date of Anniversary : ",
              style: TextStyle(
                fontSize:
                    SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 6.sp,
                fontWeight: FontWeight.w800,
                color: isDarkMode() ? white : black,
              ),
            ),
            Text(
              formatDate(
                data.dateOfAnniversary.toString(),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 6.sp,
                  color: isDarkMode() ? white : black,
                  fontFamily: fontRegular),
            ),
          ],
        ),
        SizedBox(
          height: 0.5.h,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Address : ",
                style: TextStyle(
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 6.sp,
                  fontWeight: FontWeight.w800,
                  color: isDarkMode() ? white : black,
                ),
              ),
              Expanded(
                child: Text(
                  data.address,
                  maxLines: 5,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? 12.sp
                          : 6.sp,
                      color: isDarkMode() ? white : black,
                      fontFamily: fontRegular),
                ),
              ),
            ]),
        SizedBox(
          height: 0.5.h,
        ),
        GestureDetector(
          onTap: () {
            controller.launchPhoneCall(data.contactNo.toString());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Contact No : ",
                style: TextStyle(
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 6.sp,
                  fontWeight: FontWeight.w800,
                  color: isDarkMode() ? white : black,
                ),
              ),
              Text(
                data.contactNo.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 12.sp
                        : 6.sp,
                    color: isDarkMode() ? Colors.blue : Colors.blue,
                    fontFamily: fontRegular),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 0.5.h,
        ),
        GestureDetector(
          onTap: () {
            controller.launchWhatsappCall(data.whatsappNo.toString());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Whatsapp No : ",
                style: TextStyle(
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 6.sp,
                  fontWeight: FontWeight.w800,
                  color: isDarkMode() ? white : black,
                ),
              ),
              Text(
                data.whatsappNo.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 12.sp
                        : 6.sp,
                    color: isDarkMode() ? Colors.blue : Colors.blue,
                    fontFamily: fontRegular),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 0.5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Email ID : ",
              style: TextStyle(
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 6.sp,
                  fontWeight: FontWeight.w800,
                  color: isDarkMode() ? white : black),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // controller.lanchEmail(
                  //     data.email.toString()); // Launch email on tap
                },
                child: Text(
                  data.email.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      //  decoration: TextDecoration.underline,
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? 12.sp
                          : 6.sp,
                      color: isDarkMode() ? white : black,
                      fontFamily: fontRegular),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 0.5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Description : ",
              style: TextStyle(
                fontSize:
                    SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 6.sp,
                fontWeight: FontWeight.w800,
                color: isDarkMode() ? white : black,
              ),
            ),
            Expanded(
              child: Container(
                width: SizerUtil.deviceType == DeviceType.mobile ? 25.w : 10.w,
                height: SizerUtil.deviceType == DeviceType.mobile ? 10.h : 10.h,
                child: Scrollbar(
                  thumbVisibility: true,
                  thickness: 1.5,
                  radius: Radius.circular(50),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      data.description.toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: SizerUtil.deviceType == DeviceType.mobile
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
      ]),
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
        controller.getCustomerList(context, false);
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
