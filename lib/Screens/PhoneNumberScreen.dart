import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Screens/OtpScreen.dart';
import 'package:booking_app/controllers/Phone_controller.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/custom_componannt/common_views.dart';
import 'package:booking_app/custom_componannt/form_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../core/constants/strings.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final Controller = Get.put(PhoneController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
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
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 35.sp),
                padding: EdgeInsets.only(
                  top: 8.h,
                ),
                child: FadeInDown(
                  from: 50,
                  child: Text(
                    Strings.welcome_back,
                    style: TextStyle(
                        fontFamily: opensans_Bold,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  margin: EdgeInsets.only(right: 40.sp),
                  child: FadeInDown(
                    from: 50,
                    child: Text(
                      Strings.send_code,
                      style: TextStyle(
                          fontFamily: opensans_Bold,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 7.0.w, right: 7.0.w, top: 6.h, bottom: 5.h),
                  child: Form(
                    key: Controller.formKey,
                    child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getTitle(Strings.mobile_number),
                              FadeInUp(
                                  from: 30,
                                  child: AnimatedSize(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Obx(() {
                                        return getReactiveFormField(
                                          node: Controller.Phone,
                                          controller: Controller.phonectr,
                                          hintLabel: Strings.hint_mobile_number,
                                          onChanged: (val) {
                                            Controller.validatePhone(val);
                                          },
                                          errorText:
                                              Controller.phoneModel.value.error,
                                          inputType: TextInputType.number,
                                        );
                                      }))),
                              //     Text(
                              //       Strings.mobile_number,
                              //       style: TextStyle(
                              //           fontFamily: opensans_Bold,
                              //           fontSize: 17.5.sp,
                              //           fontWeight: FontWeight.w700),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 0.5.h,
                              // ),
                              // Container(
                              //   height: 5.5.h,
                              //   child: TextField(
                              //     decoration: InputDecoration(
                              //       hintText: Strings.hint_mobile_number,
                              //     ),
                              //     controller: _phonenumber,
                              //     keyboardType: TextInputType.number,
                              //   ),
                              // ),
                              SizedBox(
                                height: 15.h,
                              ),
                              FadeInUp(
                                from: 50,
                                child: SizedBox(
                                    width: 150.h,
                                    height: 6.h,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Get.to(OtpScreen());
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             const OtpScreen()));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50))),
                                        child: Text(
                                          Strings.get_otp,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.5.sp,
                                              fontFamily: opensans_Bold,
                                              fontWeight: FontWeight.w700),
                                        ))),
                              ),
                            ],
                          ),
                        ])),
                  ),
                )
              ]),
            ],
          ),
        )
      ]),
    );
  }
}
