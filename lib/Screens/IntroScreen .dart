import 'package:animate_do/animate_do.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../core/constants/assets.dart';
import 'LoginScreen/LoginScreen.dart';
import 'OnboardingContentScreen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: Color(0xFF000000),
      ),
      margin: EdgeInsets.only(
        right: 0.5.h,
      ),
      height: 1.h,
      curve: Curves.easeIn,
      width: _currentPage == index ? 2.5.h : 1.h,
    );
  }

  @override
  Widget build(BuildContext context) {
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
          Column(
            children: [
              Expanded(
                flex: 2,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _controller,
                  onPageChanged: (value) =>
                      setState(() => _currentPage = value),
                  itemCount: contents.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FadeInDown(
                            from: 50,
                            child: SvgPicture.asset(
                              contents[i].image,
                              height: i == 1
                                  ? SizerUtil.deviceType == DeviceType.mobile
                                      ? 25.h
                                      : 27.h
                                  : SizerUtil.deviceType == DeviceType.mobile
                                      ? 35.h
                                      : 37.h,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        contents.length,
                        (int index) => _buildDots(
                          index: index,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0.h,
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Expanded(
                          child: _currentPage == 0
                              ? FadeInLeft(
                                  from: 50,
                                  child: Text(
                                      'Lorem ipsum dolor sit amet consectetur.\nId sed purus malesuada euismod.',
                                      style: TextStyle(
                                          color: isDarkMode() ? white : black,
                                          fontSize: SizerUtil.deviceType ==
                                                  DeviceType.mobile
                                              ? 13.sp
                                              : 12.sp,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: opensansMedium),
                                      textAlign: TextAlign.center),
                                )
                              : FadeInRight(
                                  from: 50,
                                  child: Text(
                                      'Lorem ipsum dolor sit amet consectetur.\nId sed purus malesuada euismod.',
                                      style: TextStyle(
                                          fontSize: SizerUtil.deviceType ==
                                                  DeviceType.mobile
                                              ? 13.sp
                                              : 12.sp,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: opensansMedium),
                                      textAlign: TextAlign.center),
                                ),
                        ),
                      ],
                    ),
                    FadeInUp(
                      from: 50,
                      child: _currentPage + 1 == contents.length
                          ? Padding(
                              padding: EdgeInsets.only(
                                  top: 8.h, left: 11.5.w, right: 11.5.w),
                              child: FadeInUp(
                                from: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(LoginScreen());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: EdgeInsets.all(15),
                                    textStyle: TextStyle(
                                        fontSize: SizerUtil.deviceType ==
                                                DeviceType.mobile
                                            ? 13.sp
                                            : 15.sp),
                                  ),
                                  child: Center(
                                      child: Text(
                                    Strings.started,
                                    style: TextStyle(
                                        fontFamily: opensans_Bold,
                                        fontSize: SizerUtil.deviceType ==
                                                DeviceType.mobile
                                            ? 15.sp
                                            : 14.sp,
                                        fontWeight: FontWeight.w700),
                                  )),
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FadeInUp(
                                    from: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _controller.nextPage(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          curve: Curves.easeIn,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        shape: const CircleBorder(
                                            side: BorderSide(width: 11)),
                                        elevation: 0,
                                        textStyle: TextStyle(
                                            fontSize: SizerUtil.deviceType ==
                                                    DeviceType.mobile
                                                ? 13.sp
                                                : 15.sp),
                                      ),
                                      child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 6.5.h),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
