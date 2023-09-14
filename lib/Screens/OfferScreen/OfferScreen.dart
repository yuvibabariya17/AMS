import 'package:booking_app/Screens/OfferScreen/PackageBasedOffer.dart';
import 'package:booking_app/Screens/OfferScreen/ProductBasedOffer.dart';
import 'package:booking_app/Screens/OfferScreen/ServiceBasedOffer.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../../Models/offers.dart';
import '../../Models/offers_model.dart';
import '../../core/Common/Common.dart';
import '../../core/Common/appbar.dart';
import '../../core/Common/toolbar.dart';
import '../../core/constants/assets.dart';
import '../../core/themes/font_constant.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  List<OfferItem> staticData = offersItems;
  var currentPage = 0;
  bool state = false;
  bool state1 = false;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 3, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Common().trasparent_statusbar();
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: isDarkMode()
                ? SvgPicture.asset(
                    Asset.dark_bg,
                    fit: BoxFit.cover,
                  )
                : SvgPicture.asset(
                    Asset.bg,
                    fit: BoxFit.cover,
                  ),
          ),
          SafeArea(
              minimum: EdgeInsets.only(top: 1.h),
              child: Container(
                  margin: EdgeInsets.only(
                    top: 0.5.h,
                  ),
                  child: Center(
                      child: Column(children: [
                    getToolbar("Offer", showBackButton: true, notify: false,
                        callback: () {
                      Get.back();
                    })
                    // HomeAppBar(
                    //   title: 'Offer',
                    //   leading: Asset.backbutton,
                    //   isfilter: false,
                    //   icon: Asset.filter,
                    //   isBack: true,
                    //   onClick: () {},
                    // ),
                  ])))),
          Container(
            margin: EdgeInsets.only(top: 5.h),
            child: SafeArea(
              child: getListViewItem(),
            ),
          ),
        ],
      ),
    );
  }

  getListViewItem() {
    return DefaultTabController(
        length: 3,
        child: Column(children: [
          SizedBox(
            height: 3.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getTab("Product Based", 30, 0),
              getTab("Service Based", 30, 1),
              getTab("Package Based", 30, 2),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Expanded(
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                ProductBasedOffer(),
                // Container(
                //   child: ListView.builder(
                //       itemBuilder: (context, index) {
                //         OfferItem data = staticData[index];

                //         return Container(
                //           margin: EdgeInsets.only(
                //               top: 1.5.h, left: 8.w, right: 8.w, bottom: 2.h),
                //           padding: EdgeInsets.only(top: 2.h),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             children: [
                //               Row(
                //                   mainAxisAlignment:
                //                       MainAxisAlignment.spaceAround,
                //                   crossAxisAlignment: CrossAxisAlignment.center,
                //                   children: [
                //                     Container(child: data.icon),
                //                     Column(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.start,
                //                       children: [
                //                         Container(
                //                           child: Text(
                //                             data.title,
                //                             style: TextStyle(
                //                                 fontFamily: opensansMedium,
                //                                 fontWeight: FontWeight.w400,
                //                                 fontSize: 13.5.sp),
                //                           ),
                //                         ),
                //                         Container(
                //                           margin: EdgeInsets.only(right: 4.7.h),
                //                           child: Text(
                //                             data.offer,
                //                             style: TextStyle(
                //                                 fontFamily: opensans_Bold,
                //                                 fontWeight: FontWeight.w700,
                //                                 fontSize: 14.sp),
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                     Container(
                //                       child: CupertinoSwitch(
                //                         value: state,
                //                         onChanged: (value) {
                //                           state = value;
                //                           state1 = value;
                //                           setState(
                //                             () {},
                //                           );
                //                         },
                //                         thumbColor: CupertinoColors.white,
                //                         activeColor: CupertinoColors.black,
                //                         trackColor: Colors.grey,
                //                       ),
                //                     )
                //                   ]),
                //               SizedBox(
                //                 height: 0.5.h,
                //               ),
                //               Container(
                //                 height: 5.h,
                //                 width: 100.w,
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.start,
                //                   crossAxisAlignment: CrossAxisAlignment.center,
                //                   children: [
                //                     Text(
                //                       '     Valid till: 26 March',
                //                       style: TextStyle(color: Colors.white),
                //                     ),
                //                   ],
                //                 ),
                //                 decoration: BoxDecoration(
                //                     color: Colors.black,
                //                     borderRadius: BorderRadius.vertical(
                //                         bottom: Radius.circular(10))),
                //               )
                //             ],
                //           ),
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.all(Radius.circular(20)),
                //             boxShadow: [
                //               BoxShadow(
                //                   color: Colors.black.withOpacity(0.2),
                //                   spreadRadius: 0.1,
                //                   blurRadius: 10,
                //                   offset: Offset(0.5, 0.5)),
                //             ],
                //           ),
                //         );
                //       },
                //       itemCount: staticData.length),
                // ),
                ServiceBasedOffer(),
                PackageBasedOffer(),
              ]))
        ]));
  }

  getTab(str, pad, index) {
    return Bounce(
      duration: Duration(milliseconds: 200),
      onPressed: (() {
        currentPage = index;
        if (tabController.indexIsChanging == false) {
          tabController.index = index;
        }
        setState(() {});
      }),
      child: AnimatedContainer(
        width: 30.w,

        //width: 50.w,
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(
          horizontal: 0.1.w,
        ),
        padding:
            EdgeInsets.only(left: 1.w, right: 1.w, top: 1.5.h, bottom: 1.5.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: currentPage == index ? Colors.black : Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 0.1,
                color: Colors.black.withOpacity(.1),
              )
            ],
            borderRadius: BorderRadius.circular(50)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              str,
              style: TextStyle(
                  fontSize: 9.5.sp,
                  fontFamily: opensans_Bold,
                  fontWeight: FontWeight.w700,
                  color:
                      currentPage == index ? Colors.white : Colors.grey[850]),
            ),
            SizedBox(
              width: currentPage == index ? 4.w : 0,
            ),
          ],
        ),
      ),
    );
  }
}
