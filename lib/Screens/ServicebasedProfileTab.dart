import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Models/service.dart';
import '../Models/service_model.dart';
import '../core/Common/Common.dart';
import '../core/themes/font_constant.dart';

class ServiceProfileTabScreen extends StatefulWidget {
  const ServiceProfileTabScreen({super.key});

  @override
  State<ServiceProfileTabScreen> createState() =>
      _ServiceProfileTabScreenState();
}

class _ServiceProfileTabScreenState extends State<ServiceProfileTabScreen> {
  List<ServiceItem> staticData = SettingsItems;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: false,
        clipBehavior: Clip.antiAlias,
        itemBuilder: (context, index) {
          ServiceItem data = staticData[index];
          return Container(
            margin:
                EdgeInsets.only(top: 1.5.h, left: 8.w, right: 8.w, bottom: 1.h),
            child: InkWell(
              onTap: () {
                Common.PopupDialogs(context);
              },
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
                        Container(
                          child: data.icon,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Container(
                          child: Text(
                            data.Name,
                            style: TextStyle(
                                fontFamily: opensansMedium,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        )
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
            ),
          );
        },
        itemCount: staticData.length);
  }
}
