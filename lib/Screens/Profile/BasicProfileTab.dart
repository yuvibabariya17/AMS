import 'package:booking_app/preference/UserPreference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../../core/constants/assets.dart';
import '../../core/constants/strings.dart';
import '../../core/themes/color_const.dart';
import '../../core/themes/font_constant.dart';
import '../../core/utils/helper.dart';
import 'UpdateVendor.dart';

class BasicprofileTabScreen extends StatefulWidget {
  BasicprofileTabScreen({super.key, this.callBack});

  Function? callBack;

  @override
  State<BasicprofileTabScreen> createState() => _BasicprofileTabScreenState();
}

class _BasicprofileTabScreenState extends State<BasicprofileTabScreen> {
  RxString fullName = ''.obs;
  RxString mobile = ''.obs;
  RxString address = ''.obs;
  RxString companyname = ''.obs;
  RxString Whatsapp = ''.obs;

  @override
  void initState() {
    initDataSet();
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
  // void getuserdata() async {
  //   SignInData? retrievedObject = await UserPreferences().getSignInInfo();
  // }

  @override
  Widget build(BuildContext context) {
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
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: IconButton(
                      alignment: Alignment.topRight,
                      onPressed: () {
                        Get.to(UpdateVendor())!.then((value) {
                          initDataSet();
                          widget.callBack!();
                        });
                      },
                      icon: SvgPicture.asset(Asset.edit,
                          height: 2.3.h,
                          color: isDarkMode() ? Colors.grey : Colors.grey)),
                )
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
              "Company Address :",
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
