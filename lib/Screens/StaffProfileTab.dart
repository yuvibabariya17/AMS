import 'package:booking_app/Models/ExpertModel.dart';
import 'package:booking_app/controllers/StaffController.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../Models/Staff_model.dart';
import '../Models/staff.dart';
import '../core/constants/assets.dart';
import '../core/themes/font_constant.dart';
import '../core/utils/helper.dart';

class StaffprofileTabScreen extends StatefulWidget {
  const StaffprofileTabScreen({super.key});

  @override
  State<StaffprofileTabScreen> createState() => _StaffprofileTabScreenState();
}

class _StaffprofileTabScreenState extends State<StaffprofileTabScreen> {
  var controller = Get.put(StaffController());

  @override
  void initState() {
    controller.getExpertList(context);
    controller.filteredExpertObjectList = controller.expertObjectList;
    super.initState();
  }

  List<StaffItem> staticData1 = StaffItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 3.h),
      child: ListView.builder(
          shrinkWrap: false,
          clipBehavior: Clip.antiAlias,
          itemBuilder: (context, index) {
            ExpertList data = controller.filteredExpertObjectList[index];
            return Container(
              margin: EdgeInsets.only(
                  top: 1.5.h, left: 8.w, right: 8.w, bottom: 1.5.h),
              child: Container(
                padding: EdgeInsets.only(
                    top: 1.5.h, left: 4.w, right: 4.w, bottom: 1.5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(children: [
                          CircleAvatar(
                            radius: 3.7.h,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              Asset.profileimg,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ]),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Text(
                                data.name,
                                style: TextStyle(
                                    color: isDarkMode() ? white : black,
                                    fontFamily: opensansMedium,
                                    fontSize: 15.5.sp,
                                    fontWeight: FontWeight.w700),
                              )),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Text(
                                '₹ ${data.amount.toString()}',
                                style: TextStyle(
                                    color: isDarkMode() ? white : black,
                                    fontFamily: opensansMedium,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
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
          },
          itemCount: controller.filteredExpertObjectList.length),
    );
  }
}
