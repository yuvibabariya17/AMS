import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Config/apicall_constant.dart';
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
import 'package:booking_app/core/utils/log.dart';
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
            width: SizerUtil.deviceType == DeviceType.mobile
                ? MediaQuery.of(context).size.width * 0.8
                : MediaQuery.of(context).size.width * 0.6,
            shadowColor: Colors.white,
            elevation: 0,
            backgroundColor: isDarkMode() ? black : Colors.grey[900],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildHeader(context),
                SizedBox(
                  height:
                      SizerUtil.deviceType == DeviceType.mobile ? 1.h : 0.3.h,
                ),
                Divider(
                  color: Colors.grey,
                  height: 2.h,
                  thickness: 1,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    // Wrap buildMenuItems with SingleChildScrollView
                    child: buildMenuItems(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildHeader(BuildContext context) => FadeInLeft(
        from: 50,
        child: Container(
          padding: EdgeInsets.only(
              top: SizerUtil.deviceType == DeviceType.mobile ? 5.5.h : 4.h,
              left: 2.5.h,
              bottom: SizerUtil.deviceType == DeviceType.mobile ? 2.h : 1.h),
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
                    imageUrl: '${ApiUrl.ImgUrl}${profile}',
                    placeholder: (context, url) =>
                        SvgPicture.asset(Asset.profileimg),
                    errorWidget: (context, url, error) =>
                        SvgPicture.asset(Asset.profileimg),
                    fit: BoxFit.cover,
                    height:
                        SizerUtil.deviceType == DeviceType.mobile ? null : 8.h,
                  ),
                ),
              ),
              SizedBox(width: 2.5.w),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 1.5.h, top: 1.8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.capitalize.toString(),
                        maxLines: 3,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                            fontSize: SizerUtil.deviceType == DeviceType.mobile
                                ? 16.sp
                                : 10.sp,
                            color: Colors.white,
                            fontFamily: opensansMedium,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: SizerUtil.deviceType == DeviceType.mobile
                            ? 1.h
                            : 0.2.h,
                      ),
                      Text(
                        number.toString(),
                        style: TextStyle(
                            fontSize: SizerUtil.deviceType == DeviceType.mobile
                                ? 10.sp
                                : 8.sp,
                            color: Colors.white,
                            fontFamily: opensansMedium),
                      )
                    ],
                  ),
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
            // padding: EdgeInsets.only(left: 2.2.h, top: 1.5.h, bottom: 1.h),
            child: Wrap(
              children: [
                setNavtile(Asset.serviceNav, "Service", () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(ServiceScreen());
                }),
                setNavtile(Asset.adduser, "Expert", () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(ExpertScreen());
                }),
                setNavtile(Asset.course, "Course", () {
                  // controller.closeDrawer();
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(CourseScreen());
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
                  Get.to(Settings())!.then((value) {
                    logcat("Settingsss", "Back");
                    //Get.find<HomeScreenController>().updateDarkMode();
                  });
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
                setNavtile(Asset.student, "Student", () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(StudentScreen());
                }),
                setNavtile(Asset.studentCourse, "Student Course", () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(StudentCourseScreen());
                }),
                setNavtile(Asset.productSelling, "Product Selling", () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(ProductSellingScreen());
                }),
                setNavtile(Asset.package, "Package Screen", () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(PackageScreen());
                }),
                setNavtile(Asset.productCategory, "Product Category", () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(ProductCategoryListScreen());
                }),
                setNavtile(Asset.brandCategory, "Brand Category", () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(BrandCategoryScreen());
                }),
                SizedBox(height: 9.5.h),
                setNavtile(Asset.share, ScreenTitle.signOut, () {
                  PopupDialogsforSignOut(context);
                }),
                SizedBox(height: 8.h),
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
