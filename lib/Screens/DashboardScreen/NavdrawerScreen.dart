import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Screens/BrandCategoryScreen.dart';
import 'package:booking_app/Screens/CustomerScreen/CustomerScreen.dart';
import 'package:booking_app/Screens/PackageScreen/PackageScreen.dart';
import 'package:booking_app/Screens/ProductCategoryScreen/ProductCategoryList.dart';
import 'package:booking_app/Screens/ProductSelling.dart';
import 'package:booking_app/Screens/StudentScreen/StudentCourseScreen.dart';
import 'package:booking_app/Screens/StudentScreen/StudentScreen.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/preference/UserPreference.dart';
import 'package:booking_app/screens/ChangepasswordScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booking_app/models/SignInModel.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/NavdrawerController.dart';
import '../../controllers/home_screen_controller.dart';
import '../../core/Common/toolbar.dart';
import '../../core/Common/util.dart';
import '../CourseScreen/CourseScreen.dart';
import '../ExpertScreen/ExpertScreen.dart';
import '../OfferScreen/OfferForm.dart';
import '../ProductScreen/ProductScreen.dart';
import '../ServiceScreen/ServiceScreen.dart';
import '../SettingScreen/SettingScreen.dart';

class NavdrawerScreen extends StatefulWidget {
  const NavdrawerScreen({super.key});

  @override
  State<NavdrawerScreen> createState() => _NavdrawerScreenState();
}

class _NavdrawerScreenState extends State<NavdrawerScreen> {
  String name = '';
  String number = '';
  String profile = "";
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
          padding: EdgeInsets.only(top: 5.5.h, left: 2.5.h, bottom: 2.h),
          color: isDarkMode() ? black : Colors.grey[900],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 3.7.h,
                backgroundColor: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl:
                        'http://192.168.1.7:4000/uploads/$profile', // URL of the expert's image
                    placeholder: (context, url) =>
                        SvgPicture.asset(Asset.profileimg),
                    errorWidget: (context, url, error) =>
                        SvgPicture.asset(Asset.profileimg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // CircleAvatar(
              //   radius: 4.5.h,
              //   backgroundColor: Colors.white,
              //   child: SvgPicture.asset(
              //     Asset.profileimg,
              //     fit: BoxFit.cover,
              //   ),
              // ),
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
                setNavtile(Asset.serviceNav, "Service", isBig: true, () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(ServiceScreen());
                }),
                setNavtile(Asset.adduser, " Expert", () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(ExpertScreen());
                }),
                setNavtile(Asset.course, "Course", isBig: true, () {
                  // controller.closeDrawer();
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(CourseScreen());
                }),
                // setNavtile(Asset.add_service_offer, ScreenTitle.serviceOffer,
                //     () {
                //   Get.find<HomeScreenController>().closeDrawer();
                //   Get.to(OfferFormScreen());
                // }),
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
                setNavtile(Asset.multipleUser, "Customer", isBig: true, () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(CustomerScreen());
                }),
                // setListTile(Asset.share, ScreenTitle.appointmentBooking, () {
                //   Get.find<HomeScreenController>().closeDrawer();
                //   Get.to(AppointmentBookingScreen());
                // }),
                setNavtile(Asset.product, "Product", isBig: true, () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(ProductScreen());
                }),
                setNavtile(Asset.student, "Student", isBig: true, () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(StudentScreen());
                }),
                setNavtile(Asset.studentCourse, "Student Course", isBig: true,
                    () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(StudentCourseScreen());
                }),
                // setNavtile(Asset.productSelling, "Product Selling", isBig: true,
                //     () {
                //   Get.find<HomeScreenController>().closeDrawer();
                //   Get.to(ProductSellingScreen());
                // }),
                setNavtile(Asset.package, "Package Screen", isBig: true, () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(PackageScreen());
                }),
                setNavtile(Asset.productCategory, "Product Category",
                    isBig: true, () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(ProductCategoryListScreen());
                }),
                setNavtile(Asset.brandCategory, "Brand Category", isBig: true,
                    () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(BrandCategoryScreen());
                }),
                SizedBox(height: 9.5.h),
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
    profile = retrievedObject.profilePic ?? "";

    setState(() {});
  }
}
