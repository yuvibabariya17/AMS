import 'package:booking_app/Screens/Profile/UpdateVendor.dart';
import 'package:booking_app/controllers/ProfileInformationController.dart';
import 'package:booking_app/core/Common/toolbar.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:booking_app/preference/UserPreference.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  State<ProfileInformationScreen> createState() =>
      _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  RxString fullName = ''.obs;
  RxString mobile = ''.obs;
  RxString address = ''.obs;
  RxString companyname = ''.obs;
  RxString Whatsapp = ''.obs;

  final controller = Get.put(ProfileInformationController());
  // String name = '';
  // String number = '';

  @override
  void initState() {
    initDataSet();

    //  controller.isDarkModes = getStorage.read(GetStorageKey.IS_DARK_MODE) ?? 1;
    super.initState();
  }

  void initDataSet() async {
    var retrievedObject = await UserPreferences().getSignInInfo();
    fullName.value = retrievedObject!.userName.toString().trim();
    mobile.value = retrievedObject.contactNo1.toString().trim();
    companyname.value = retrievedObject.companyName.toString().trim();
    address.value = retrievedObject.companyAddress.toString().trim();
    Whatsapp.value = retrievedObject.whatsappNo.toString().trim();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      // backgroundColor: transparent,
      body: Container(
        margin: EdgeInsets.only(left: 1.5.w, right: 1.5.w, top: 1.h),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Center(
                      child: Column(
                    children: [
                      getCommonToolbar(ScreenTitle.profile, () {
                        Get.back();
                      })
                    ],
                  )),
                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                      child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: "controller.profilePic.value,",
                    placeholder: (context, url) => SvgPicture.asset(
                      Asset.profileimg,
                      height: 8.h,
                      color: isDarkMode() ? white : black,
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => SvgPicture.asset(
                      Asset.profileimg,
                      height: 8.h,
                      color: isDarkMode() ? white : black,
                      fit: BoxFit.cover,
                    ),
                  )),
                  SizedBox(height: 1.h),
                  Text(
                    fullName.value,
                    style: TextStyle(
                        color: isDarkMode() ? white : black,
                        fontFamily: opensansMedium,
                        fontSize: 16.5.sp,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            getListViewItem()
          ],
        ),
      ),
    );
  }

  getListViewItem() {
    return Container(
      margin: EdgeInsets.only(top: 3.h, left: 8.w, right: 8.w, bottom: 1.h),
      child: Container(
        padding:
            EdgeInsets.only(top: 1.5.h, left: 6.w, right: 4.w, bottom: 1.5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Vendor Name :",
                  style: TextStyle(
                      fontFamily: opensansMedium,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode() ? Colors.grey : black,
                      fontSize: 13.5.sp),
                ),
                IconButton(
                    alignment: Alignment.topRight,
                    onPressed: () {
                      Get.to(UpdateVendor());
                    },
                    icon: SvgPicture.asset(Asset.edit,
                        height: 2.3.h,
                        color: isDarkMode() ? Colors.grey : Colors.grey))
              ],
            ),
            SizedBox(height: 0.5.h),
            Text(
              fullName.value,
              style: TextStyle(
                  color: isDarkMode() ? white : black,
                  fontFamily: opensansMedium,
                  fontWeight: FontWeight.w400,
                  fontSize: 13.sp),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              CommonConstant.company_name,
              style: TextStyle(
                  fontFamily: opensansMedium,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode() ? Colors.grey : black,
                  fontSize: 13.5.sp),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Text(
              companyname.value,
              style: TextStyle(
                  color: isDarkMode() ? white : black,
                  fontFamily: opensansMedium,
                  fontWeight: FontWeight.w400,
                  fontSize: 13.sp),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              Strings.address,
              style: TextStyle(
                  fontFamily: opensansMedium,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode() ? Colors.grey : black,
                  fontSize: 13.5.sp),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Text(
              address.value,
              style: TextStyle(
                  color: isDarkMode() ? white : black,
                  fontFamily: opensansMedium,
                  fontWeight: FontWeight.w400,
                  fontSize: 13.sp),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              Strings.contact_one,
              style: TextStyle(
                  fontFamily: opensansMedium,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode() ? Colors.grey : black,
                  fontSize: 13.5.sp),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Text(
              mobile.value,
              style: TextStyle(
                  color: isDarkMode() ? white : black,
                  fontFamily: opensansMedium,
                  fontWeight: FontWeight.w400,
                  fontSize: 13.sp),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              "Whatsapp Number :",
              style: TextStyle(
                  fontFamily: opensansMedium,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode() ? Colors.grey : black,
                  fontSize: 13.5.sp),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Text(
              Whatsapp.value,
              style: TextStyle(
                  color: isDarkMode() ? white : black,
                  fontFamily: opensansMedium,
                  fontWeight: FontWeight.w400,
                  fontSize: 13.sp),
            ),
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
  }
}
