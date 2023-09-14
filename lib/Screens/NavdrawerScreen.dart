import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Screens/AddCustomerScreen.dart';
import 'package:booking_app/Screens/AddProductScreen.dart';
import 'package:booking_app/Screens/ProfileScreen.dart';
import 'package:booking_app/Screens/ServiceScreen.dart';
import 'package:booking_app/Screens/SettingScreen.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/screens/ChangepasswordScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/home_screen_controller.dart';
import '../core/Common/toolbar.dart';
import '../core/Common/util.dart';
import 'AppointmentBooking.dart';
import 'ExpertScreen.dart';
import 'OfferScreen/OfferScreen.dart';

class NavdrawerScreen extends StatelessWidget {
  const NavdrawerScreen({super.key});

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
            backgroundColor: Colors.grey[900],
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
          color: Colors.grey[900],
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
                      "Kim Se-Jeong",
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
                      '+91 1234567890',
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
            color: Colors.grey[900],
            padding: EdgeInsets.only(left: 2.2.h, top: 1.5.h, bottom: 1.h),
            child: Wrap(
              children: [
                setListTile(Asset.user, 'Profile', () {
                  Get.to(ProfileScreen());
                }),
                setListTile(Asset.add_service, 'Add Services', () {
                  Get.to(ServiceScreen());
                }),
                setListTile(Asset.adduser, 'Add Expert', () {
                  Get.to(ExpertScreen());
                }),
                setListTile(Asset.add_service_offer, 'Add Service Offer', () {
                  Get.to(OfferScreen());
                }),
                setListTile(Asset.passwordlock, 'Change Password', () {
                  Get.to(ChangePasswordScreen(
                    fromProfile: true,
                  ));
                }),
                setListTile(Asset.settingslider, 'Settings', () {
                  Get.to(Settings());
                }),
                setListTile(Asset.rate_us, 'Rate Us', () {
                  Get.find<HomeScreenController>().closeDrawer();
                  Get.to(AddCustomerScreen());
                }),
                setListTile(Asset.share, 'Share Us', () {
                  Get.to(AppointmentBookingScreen());
                }),
                setListTile(Asset.share, 'Sign Out', () {
                  PopupDialogs(context);
                }),
                SizedBox(height: 11.5.h),
                setListTile(Asset.share, 'Help', () {
                  Get.to(AddProductScreen());
                }),
              ],
            )),
      );
          // InkWell(
                //   child: ListTile(
                //     leading: SvgPicture.asset(
                //       Asset.adduser,
                //     ),
                //     horizontalTitleGap: 0.1,
                //     visualDensity: VisualDensity(horizontal: -2, vertical: -2),
                //     title: Text('Add Expert',
                //         style: TextStyle(
                //             color: Colors.grey,
                //             fontFamily: opensansMedium,
                //             fontSize: 11.5.sp)),
                //     onTap: () {
                //       Get.to(ExpertScreen());
                //       // Navigator.push(
                //       //     context,
                //       //     MaterialPageRoute(
                //       //       builder: (context) => Expert(),
                //       //     ));
                //     },
                //   ),
                // ),
}
