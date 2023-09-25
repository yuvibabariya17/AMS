import 'package:booking_app/Models/notification_model.dart';
import 'package:booking_app/Models/product.dart';
import 'package:booking_app/Screens/AppointmentScreen/PreviousAppointmentScreen.dart';
import 'package:booking_app/Screens/AppointmentScreen/Upcoming_Appointment.dart';
import 'package:booking_app/controllers/Appointment_screen_controller.dart';
import 'package:booking_app/core/Common/toolbar.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/Common/Common.dart';
import '../../core/themes/color_const.dart';

class AppointmentScreen extends StatefulWidget {
  AppointmentScreen({
    super.key,
    this.openDrawer,
    required this.isfromNav,
    this.callBack,
  });
  bool isfromNav;
  Function? callBack;

  GlobalKey<ScaffoldState>? openDrawer;

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen>
    with TickerProviderStateMixin {
  var controller = Get.put(AppointmentScreenController());
  var upcomingappointment = UpcomingAppointment();
  List<ProductItem> staticData = notificationItems;
  late TabController tabController;
  var currentPage = 0;
  var icon;
  var leading;
  var isfilter;
  var title;
  bool state = false;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 2, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Common().trasparent_statusbar();
    return WillPopScope(
      onWillPop: () async {
        if (widget.callBack != null) {
          widget.callBack!(0);
        } else {
          Get.back();
        }
        return false;
      },
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 1.5.w, right: 1.5.w),
          child: Column(
            children: [
              getAppbar(
                "Appointment",
              ),
              Expanded(
                child: getListViewItem(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getListViewItem() {
    return DefaultTabController(
        length: 2,
        child: Column(children: [
          SizedBox(
            height: 2.5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getTab("Upcoming", 30, 0),
              getTab("Previous", 30, 1),
            ],
          ),
          Expanded(
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                UpcomingAppointment(),
                PreviousAppointmentScreen(),
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
        width: 40.w,
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(
          horizontal: 3.5.w,
        ),
        padding:
            EdgeInsets.only(left: 5.w, right: 5.w, top: 1.3.h, bottom: 1.3.h),
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
                  fontSize: 12.5.sp,
                  fontFamily: opensans_Bold,
                  fontWeight: FontWeight.w700,
                  color:
                      currentPage == index ? Colors.white : Colors.grey[850]),
            ),
            SizedBox(
              width: currentPage == index ? 4.w : 0,
            ),
            currentPage == index
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          currentPage == index || isDarkMode() ? white : black,
                    ),
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
                    child: currentPage == index
                        ? Text("6",
                            style: TextStyle(
                              fontSize: 12.5.sp,
                              color: isDarkMode() ? black : null,
                            ))
                        : null,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
