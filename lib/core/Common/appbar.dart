import 'package:booking_app/core/themes/font_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../constants/assets.dart';
import '../themes/color_const.dart';
import '../utils/helper.dart';

// ignore: must_be_immutable
class HomeAppBar extends StatelessWidget {
  HomeAppBar(
      {super.key,
      this.openDrawer,
      required this.title,
      required this.onClick,
      required this.isfilter,
      required this.leading,
      required this.icon,
      this.isBack});
  GlobalKey<ScaffoldState>? openDrawer;
  final String title;
  bool isfilter;
  var icon;
  var leading;
  var isBack = null;
  final Function? onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 22, right: 5.w, top: 10),
      child: Row(
        children: [
          title == 'Settings'
              ? Container()
              : InkWell(
                  onTap: () {
                    isBack == true
                        ? Get.back()
                        : openDrawer?.currentState?.openDrawer();
                  },
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  child: isBack != null
                      ? isBack == true
                          ? SvgPicture.asset(
                              Asset.arrowBack,
                              height: 4.h,
                              color: isDarkMode() ? white : black,
                            )
                          : SvgPicture.asset(
                              Asset.menu,
                              color: isDarkMode() ? white : black,
                            )
                      : SvgPicture.asset(
                          Asset.cart,
                          color: isDarkMode() ? white : black,
                        )),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 1, left: 9, right: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16.5.sp,
                      color: isDarkMode() ? white : black,
                      fontFamily: opensans_Bold,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          title == 'Settings' ||
                  title == 'Invite Friends' ||
                  title == 'Profile' ||
                  title == 'Offer' ||
                  title == 'Update Vendor' ||
                  title == 'Services' ||
                  title == 'Add Services' ||
                  title == 'Experts' ||
                  title == 'Add Experts' ||
                  title == 'Add Vendor Service' ||
                  title == 'Add Vendor' ||
                  title == 'Add Customer' ||
                  title == 'Add Product' ||
                  title == 'Add Course' ||
                  title == 'Report Bug' ||
                  title == 'Appointment Booking'
              ? Container()
              : isfilter == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          child: InkWell(
                            onTap: () {
                              onClick!();
                            },
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            child: SvgPicture.asset(
                              Asset.notification,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 6.5.w,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 1.h),
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) => notification()));
                            },
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            child: SvgPicture.asset(
                              Asset.cart,
                              color: isDarkMode() ? white : black,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      padding: EdgeInsets.only(right: 1.h),
                      child: InkWell(
                        onTap: () {
                          onClick!();
                        },
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        child: SvgPicture.asset(
                          Asset.filter,
                          color: isDarkMode() ? white : black,
                        ),
                      ),
                    )
        ],
      ),
    );
  }
}
