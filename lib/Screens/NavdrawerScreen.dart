import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Screens/CourseScreen.dart';
import 'package:booking_app/Screens/CustomerScreen.dart';
import 'package:booking_app/Screens/OfferForm.dart';
import 'package:booking_app/Screens/ProductScreen.dart';
import 'package:booking_app/Screens/ProductSelling.dart';
import 'package:booking_app/Screens/StudentCourseScreen.dart';
import 'package:booking_app/Screens/StudentScreen.dart';
import 'package:booking_app/controllers/NavdrawerController.dart';
import 'package:booking_app/Screens/ServiceScreen.dart';
import 'package:booking_app/Screens/SettingScreen.dart';
import 'package:booking_app/controllers/home_screen_controller.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/screens/ChangepasswordScreen.dart';
import 'package:booking_app/preference/UserPreference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booking_app/models/SignInModel.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../core/Common/toolbar.dart';
import '../core/Common/util.dart';
import 'ExpertScreen.dart';

class NavdrawerScreen extends StatefulWidget {
  const NavdrawerScreen({super.key});

  @override
  State<NavdrawerScreen> createState() => _NavdrawerScreenState();
}

class _NavdrawerScreenState extends State<NavdrawerScreen> {
  String name = '';
  String number = '';
  var controller = Get.put(NavdrawerController());

  @override
  void initState() {
    initDataSet(context);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(23), bottomRight: Radius.circular(23)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(23),
          bottomRight: Radius.circular(23),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter,
              colors: [Theme.of(context).primaryColor, Color(0xff995DFF)],
            ),
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: Drawer(
            width: MediaQuery.of(context).size.width * 0.8,
            shadowColor: Colors.white,
            elevation: 0,
            backgroundColor: isDarkMode() ? black : Colors.grey[900],
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildHeader(context),
                  SizedBox(
                    height: 1.h,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 2.h,
                    thickness: 1,
                  ),
                  buildMenuItems(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildHeader(BuildContext context) => FadeInLeft(
        from: 50,
        child: Container(
          padding: EdgeInsets.only(top: 5.5.h, left: 3.2.h, bottom: 2.h),
          color: isDarkMode() ? black : Colors.grey[900],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 4.5.h,
                backgroundColor: Colors.white,
                child: SvgPicture.asset(
                  Asset.profileimg,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 2.5.w),
              Container(
                margin: EdgeInsets.only(bottom: 1.5.h, top: 1.8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.toString(),
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontFamily: opensansMedium,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      number.toString(),
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.white,
                          fontFamily: opensansMedium),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  buildMenuItems(BuildContext context) => FadeInLeft(
        from: 50,
        child: Container(
            color: isDarkMode() ? black : Colors.grey[900],
            padding: EdgeInsets.only(left: 2.2.h, top: 1.5.h, bottom: 1.h),
            child: Wrap(
              children: [
                setNavtile(Asset.course, "Course", isBig: true, () {
                  // controller.closeDrawer();
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(CourseScreen());
                }),
                setNavtile(Asset.serviceNav, "Service", isBig: true, () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(ServiceScreen());
                }),
                setNavtile(Asset.adduser, "Expert", () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(ExpertScreen());
                }),
                setNavtile(Asset.add_service_offer, ScreenTitle.serviceOffer,
                    () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(OfferFormScreen());
                }),
                setNavtile(Asset.passwordlock, ScreenTitle.changePassTitle, () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(ChangePasswordScreen(
                    fromProfile: true,
                  ));
                }),
                setNavtile(Asset.settingslider, ScreenTitle.settings, () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(Settings());
                }),
                setNavtile(Asset.multipleUser, "Customer", () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(CustomerScreen());
                }),
                // setListTile(Asset.share, ScreenTitle.appointmentBooking, () {
                //   Get.find<HomeScreenController>().closeDrawer();
                //   Get.to(AppointmentBookingScreen());
                // }),
                setNavtile(Asset.product, "Product", () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(ProductScreen());
                }),
                setNavtile(Asset.product, "Student", () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(StudentScreen());
                }),
                setNavtile(Asset.product, "Student Course", () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(StudentCourseScreen());
                }),
                setNavtile(Asset.product, "Product Selling", () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(ProductSellingScreen());
                }),
                SizedBox(height: 11.5.h),
                setNavtile(Asset.share, ScreenTitle.signOut, () {
                  PopupDialogsforSignOut(context);
                }),
              ],
            )),
      );

  void initDataSet(BuildContext context) async {
    SignInData? retrievedObject = await UserPreferences().getSignInInfo();

    name = retrievedObject!.userName.toString();
    number = retrievedObject.contactNo1.toString();

    setState(() {});
  }
}
