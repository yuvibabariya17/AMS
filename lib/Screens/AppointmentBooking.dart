import 'package:animate_do/animate_do.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/AppointmentBooking_controller.dart';
import '../core/Common/toolbar.dart';
import '../core/constants/strings.dart';
import '../core/themes/color_const.dart';
import '../core/themes/font_constant.dart';
import '../custom_componannt/common_views.dart';
import '../custom_componannt/form_inputs.dart';

class AppointmentBookingScreen extends StatefulWidget {
  const AppointmentBookingScreen({super.key});

  @override
  State<AppointmentBookingScreen> createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  final controller = Get.put(AppointmentBookingController());
  DateTime selectedDate = DateTime.now();
  bool check1 = false;

  @override
  void initState() {
    controller.getServieList(context);
    controller.getExpertList(context);
    super.initState();
  }

  // void getService(BuildContext context) async {
  //   try {
  //     if (mounted) {
  //       await Future.delayed(const Duration(seconds: 1)).then((value) {});
  //     }
  //   } catch (e) {
  //     logcat("ERROR", e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Column(
      children: [
        getCommonToolbar("Appointment Booking", () {
          Get.back();
        }),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 1.0.w, right: 1.0.w),
                  padding: EdgeInsets.only(
                      left: 7.0.w, right: 7.0.w, top: 2.h, bottom: 1.h),
                  child: Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getTitle(Strings.customer),
                          FadeInUp(
                              from: 30,
                              child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: Obx(() {
                                    return getReactiveFormField(
                                      node: controller.CustomerNode,
                                      controller: controller.Customerctr,
                                      hintLabel: Strings.customer_hint,
                                      wantSuffix: true,
                                      isdown: true,
                                      onChanged: (val) {
                                        controller.validateCustomer(val);
                                      },
                                      errorText:
                                          controller.CustomerModel.value.error,
                                      inputType: TextInputType.none,
                                    );
                                  }))),
                          getTitle(Strings.Services),
                          FadeInUp(
                              from: 30,
                              child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: Obx(() {
                                    return getReactiveFormField(
                                      node: controller.ServiceNode,
                                      controller: controller.Servicectr,
                                      hintLabel: Strings.Services,
                                      wantSuffix: true,
                                      isdown: true,
                                      onChanged: (val) {
                                        controller.validateService(val);
                                        setState(() {});
                                      },
                                      onTap: () {
                                        controller.Servicectr.text = "";
                                        showDropDownDialog(
                                            context,
                                            controller.setServiceList(),
                                            "Select Service");
                                        // showDropdownMessage(
                                        //     context,
                                        //     controller.setServiceList(),
                                        //     'Select Category');
                                      },
                                      errorText:
                                          controller.ServicesModel.value.error,
                                      inputType: TextInputType.none,
                                    );
                                  }))),
                          getTitle("Add Experts"),
                          FadeInUp(
                              from: 30,
                              child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: Obx(() {
                                    return getReactiveFormField(
                                      node: controller.expertNode,
                                      controller: controller.expertctr,
                                      hintLabel: "Select Expert",
                                      wantSuffix: true,
                                      isDropdown: true,
                                      onAddBtn: () {},
                                      isAdd: true,
                                      onChanged: (val) {
                                        controller.validateExpert(val);
                                        setState(() {});
                                      },
                                      onTap: () {
                                        controller.expertctr.text = "";
                                        showDropDownDialog(
                                            context,
                                            controller.setExpertList(),
                                            "Select Expert");
                                        // showDropdownMessage(
                                        //     context,
                                        //     controller.setExpertList(),
                                        //     'Select Expert');
                                      },
                                      errorText:
                                          controller.expertsModel.value.error,
                                      inputType: TextInputType.none,
                                    );
                                  }))),
                          getTitle("Select Date"),
                          FadeInUp(
                              from: 30,
                              child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: Obx(() {
                                    return getReactiveFormField(
                                      node: controller.dateNode,
                                      controller: controller.datectr,
                                      hintLabel: "Select Date",
                                      wantSuffix: true,
                                      isCalender: true,
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: selectedDate,
                                                firstDate: DateTime(1950),
                                                lastDate: DateTime(2050));
                                        if (pickedDate != null &&
                                            pickedDate != selectedDate) {
                                          setState(() {
                                            selectedDate = pickedDate;
                                          });
                                        }
                                        if (pickedDate != null) {
                                          String formattedDate =
                                              DateFormat(Strings.dateFormat)
                                                  .format(pickedDate);
                                          controller.updateDate(formattedDate);
                                          controller
                                              .validateDate(formattedDate);
                                        }
                                      },
                                      onChanged: (val) {
                                        controller.validateDate(val);
                                        setState(() {});
                                      },
                                      errorText:
                                          controller.dateModel.value.error,
                                      inputType: TextInputType.none,
                                    );
                                  }))),
                          getTitle(Strings.Appointment_slot),
                          SizedBox(
                            height: 1.h,
                          ),
                          Obx(
                            () {
                              return GridView.count(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  childAspectRatio: 2.0,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 17,
                                  mainAxisSpacing: 4,
                                  children: List.generate(
                                      controller.choices.length, (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.selectedIndex.value =
                                              index;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        width: 25.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color:
                                              controller.selectedIndex.value ==
                                                      index
                                                  ? Colors.black
                                                  : Colors.grey,
                                        ),
                                        child: Center(
                                          child: Text(
                                            controller.choices[index].title,
                                            style: TextStyle(
                                                fontFamily: opensans_Bold,
                                                color: Colors.white,
                                                fontSize:
                                                    SizerUtil.deviceType ==
                                                            DeviceType.mobile
                                                        ? 12.sp
                                                        : 13.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    );
                                  }));
                            },
                          ),
                        
                          SizedBox(height: 2.h),
                          getTitle(Strings.amount),
                          FadeInUp(
                              from: 30,
                              child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: Obx(() {
                                    return getReactiveFormField(
                                      node: controller.AmountNode,
                                      controller: controller.Amountctr,
                                      hintLabel: Strings.amount_hint,
                                      onChanged: (val) {
                                        controller.validateAmount(val);
                                        setState(() {});
                                      },
                                      errorText:
                                          controller.AmountModel.value.error,
                                      inputType: TextInputType.number,
                                    );
                                  }))),
                          getTitle(Strings.notes),
                          FadeInUp(
                              from: 30,
                              child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: Obx(() {
                                    return getReactiveFormField(
                                      node: controller.NoteNode,
                                      controller: controller.Notectr,
                                      hintLabel: Strings.notes_hint,
                                      onChanged: (val) {
                                        controller.validateNote(val);
                                        setState(() {});
                                      },
                                      isExpand: true,
                                      errorText:
                                          controller.NoteModel.value.error,
                                      inputType: TextInputType.text,
                                    );
                                  }))),
                          Container(
                            child: Obx(
                              () {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      activeColor: black,
                                      visualDensity: const VisualDensity(
                                        horizontal: -2,
                                      ),
                                      value: controller.value_1.value,
                                      onChanged: (value) {
                                        controller.value_1.value = value!;
                                        controller.enableSignUpButton();
                                      },
                                    ),
                                    SizedBox(width: 0.5.w),
                                    GestureDetector(
                                      onTap: () async {
                                        if (controller.value_1.value == true) {
                                          if (!await launchUrl(
                                            Uri.parse('http://google.com/'),
                                            mode:
                                                LaunchMode.externalApplication,
                                          )) {
                                            throw Exception(
                                                'Could not launch ');
                                          }
                                        }
                                      },
                                      child: Text(
                                        "Remind Customer ?",
                                        style: TextStyle(
                                            fontFamily: opensansMedium,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      // RichText(
                                      //   overflow: TextOverflow.clip,
                                      //   textAlign: TextAlign.start,
                                      //   softWrap: true,
                                      //   // maxLines: 2,
                                      //   //textScaleFactor: 1,
                                      //   text: TextSpan(
                                      //     text: "Agree with  ",
                                      //     style: TextStyle(
                                      //         fontSize: 10.sp,
                                      //         fontWeight: FontWeight.bold,
                                      //         color: black),
                                      //     children: [
                                      //       TextSpan(
                                      //         text:
                                      //             "Terms and Privacy Policy?",
                                      //         style: TextStyle(
                                      //             color: primaryColor,
                                      //             fontFamily: fontMedium,
                                      //             decoration: TextDecoration
                                      //                 .underline,
                                      //             fontSize: 10.sp,
                                      //             fontWeight:
                                      //                 FontWeight.w900),
                                      //       )
                                      //     ],
                                      //   ),
                                      // )
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          // Theme(
                          //   data: ThemeData(
                          //       checkboxTheme: CheckboxThemeData(
                          //           shape: RoundedRectangleBorder(
                          //               borderRadius:
                          //                   BorderRadius.circular(5)))),
                          //   child: CheckboxListTile(
                          //     controlAffinity: ListTileControlAffinity.leading,
                          //     activeColor: Colors.black,
                          //     visualDensity:
                          //         VisualDensity(horizontal: -2, vertical: -4),
                          //     contentPadding:
                          //         EdgeInsets.only(top: 0.5, bottom: 0.5),
                          //     value: check1,
                          //     onChanged: (bool? value) {
                          //       print(value);
                          //       setState(() {
                          //         check1 = value!;
                          //       });
                          //     },
                          //     title: Text(
                          //       'Remind Customer ?',
                          //       style: TextStyle(
                          //           fontFamily: opensansMedium,
                          //           fontWeight: FontWeight.w400),
                          //     ),
                          //   ),
                          // ),

                          FadeInUp(
                              from: 50,
                              child: Obx(() {
                                return getFormButton(() {
                                  if (controller.isFormInvalidate.value ==
                                      true) {
                                    // controller.AddBookingAppointmentAPI(context);
                                  }
                                }, "Sign In",
                                    validate:
                                        controller.isFormInvalidate.value);
                              })),
                          SizedBox(
                            height: 2.h,
                          )
                        ],
                      )),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
