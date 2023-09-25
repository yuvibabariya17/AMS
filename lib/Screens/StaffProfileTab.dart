import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../Models/Staff_model.dart';
import '../Models/staff.dart';
import '../core/constants/assets.dart';
import '../core/themes/font_constant.dart';

class StaffprofileTabScreen extends StatefulWidget {
  const StaffprofileTabScreen({super.key});

  @override
  State<StaffprofileTabScreen> createState() => _StaffprofileTabScreenState();
}

class _StaffprofileTabScreenState extends State<StaffprofileTabScreen> {
  List<StaffItem> staticData1 = StaffItems;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: false,
        clipBehavior: Clip.antiAlias,
        itemBuilder: (context, index) {
          StaffItem data = staticData1[index];
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
                              data.title,
                              style: TextStyle(
                                  fontFamily: opensansMedium,
                                  fontSize: 15.5.sp,
                                  fontWeight: FontWeight.w700),
                            )),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            Text(
                              data.number,
                              style: TextStyle(
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
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0.1,
                      blurRadius: 10,
                      offset: Offset(0.5, 0.5)),
                ],
              ),
            ),
          );
        },
        itemCount: staticData1.length);
  }
}
