import 'package:booking_app/Screens/AddExpertScreen.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/screens/NavdrawerScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';

import '../Models/Listofexpert.dart';
import '../Models/Listofexpert_model.dart';
import '../core/Common/appbar.dart';
import '../core/Common/toolbar.dart';
import '../core/constants/assets.dart';
import '../core/themes/font_constant.dart';

class ExpertScreen extends StatefulWidget {
  const ExpertScreen({super.key});

  @override
  State<ExpertScreen> createState() => _ExpertScreenState();
}

class _ExpertScreenState extends State<ExpertScreen> {
  List<ExpertItems> staticData = Expert_Items;
  TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              child: Container(
                  margin: EdgeInsets.only(top: 0.5.h),
                  child: Center(
                      child: Column(children: [
                    getToolbar("Experts", showBackButton: true, notify: false,
                        callback: () {
                      Get.back();
                    })
                    // HomeAppBar(
                    //   title: 'Experts',
                    //   leading: Asset.backbutton,
                    //   isfilter: false,
                    //   icon: Asset.filter,
                    //   isBack: true,
                    //   onClick: () {
                    //     Get.to(NavdrawerScreen());
                    //   },
                    // ),
                  ])))),
          Container(
            margin: EdgeInsets.only(top: 8.h, left: 1.0.w, right: 1.0.w),
            padding: EdgeInsets.only(
                left: 7.0.w, right: 7.0.w, top: 4.h, bottom: 1.h),
            child: Container(
              height: 5.5.h,
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Search',
                    contentPadding:
                        EdgeInsets.only(top: 1.h, left: 2.h, bottom: 1.h),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    suffixIcon: IconButton(
                        onPressed: () {}, icon: Icon(Icons.search_sharp))),
                controller: _search,
                keyboardType: TextInputType.name,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15.h),
            child: ListView.builder(
                shrinkWrap: false,
                clipBehavior: Clip.antiAlias,
                itemBuilder: (context, index) {
                  ExpertItems data = staticData[index];

                  return Container(
                    margin: EdgeInsets.only(
                        top: 1.5.h, left: 8.w, right: 8.w, bottom: 1.5.h),
                    child: Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
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
                                SizedBox(width: 5.5.w),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          child: Text(
                                        data.name,
                                        style: TextStyle(
                                            fontFamily: opensansMedium,
                                            fontSize: 15.5.sp,
                                            fontWeight: FontWeight.w700),
                                      )),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        data.title,
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
                    ),
                  );
                },
                itemCount: staticData.length),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 6.1.h,
                    height: 6.1.h,
                    margin: EdgeInsets.only(bottom: 5.h, right: 7.w),
                    child: RawMaterialButton(
                      fillColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => AddExpertScreen(),
                        //     ));
                        Get.to(AddExpertScreen());
                      },
                      child: Icon(
                        Icons.add,
                        size: 3.5.h,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
