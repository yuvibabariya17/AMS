import 'package:animate_do/animate_do.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../controllers/AppointmentBooking_controller.dart';
import '../core/Common/toolbar.dart';
import '../core/constants/assets.dart';
import '../core/constants/strings.dart';
import '../core/themes/font_constant.dart';
import '../core/utils/log.dart';
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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: Colors.white,
        body: SafeArea(
          minimum: EdgeInsets.only(top: 1.h),
          child: Stack(children: [
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
            SizedBox(
              height: 0.5.h,
            ),
            Center(
                child: Column(children: [
              getForgetToolbar("Appointment Booking", showBackButton: true,
                  callback: () {
                Get.back();
              })
              // HomeAppBar(
              //   title: Strings.appointment_booking,
              //   leading: Asset.backbutton,
              //   isfilter: false,
              //   icon: Asset.filter,
              //   isBack: true,
              //   onClick: () {
              //     Get.back();
              //   },
              // ),
            ])),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 6.h, left: 1.0.w, right: 1.0.w),
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
                                      showDropdownMessage(
                                          context,
                                          controller.setServiceList(),
                                          'Select Category');
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
                                      showDropdownMessage(
                                          context,
                                          controller.setExpertList(),
                                          'Select Expert');
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
                                              lastDate: DateTime.now().add(
                                                  const Duration(days: 0)));
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
                                        controller.validateDate(formattedDate);
                                      }
                                    },
                                    onChanged: (val) {
                                      controller.validateDate(val);
                                      setState(() {});
                                    },
                                    errorText: controller.dateModel.value.error,
                                    inputType: TextInputType.text,
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
                                        controller.selectedIndex.value = index;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      width: 25.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: controller.selectedIndex.value ==
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
                                              fontSize: SizerUtil.deviceType ==
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
                        // Obx(
                        //   () {
                        //     return GridView.count(
                        //         shrinkWrap: true,
                        //         childAspectRatio: 1.5,
                        //         crossAxisCount: 3,
                        //         crossAxisSpacing: 16.2,
                        //         mainAxisSpacing: -0.0,
                        //         children:
                        //             List.generate(choices.length, (index) {
                        //           return SelectCard(
                        //               choice: choices[index], index: index);
                        //         }));
                        //   },
                        // ),
                        Column(
                          children: [
                            // Obx(
                            //   () {
                            //     return Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Container(
                            //           child: getTime(Strings.time1, Booking),
                            //         ),
                            //         Container(
                            //           child: getTime(Strings.time2, Booking),
                            //         ),
                            //         Container(
                            //           child: getTime(Strings.time3, Booking),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // ),
                            // SizedBox(
                            //   height: 1.h,
                            // ),
                            // Obx(
                            //   () {
                            //     return Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Container(
                            //           child: getTime(Strings.time4,
                            //                Booking),
                            //         ),
                            //         Container(
                            //           child: getTime(Strings.time5,
                            //                Booking),
                            //         ),
                            //         Container(
                            //           child: getTime(Strings.time6,
                            //                Booking),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // ),
                            // SizedBox(
                            //   height: 1.h,
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Container(
                            //       child: getTime(Strings.time7,
                            //           Booking.isClickd.value, Booking),
                            //     ),
                            //     Container(
                            //       child: getTime(Strings.time8,
                            //           Booking.isClickd.value, Booking),
                            //     ),
                            //     Container(
                            //       child: getTime(Strings.time9,
                            //           Booking.isClickd.value, Booking),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 1.h,
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Container(
                            //       child: getTime(Strings.time10,
                            //           Booking.isClickd.value, Booking),
                            //     ),
                            //     Container(
                            //       child: getTime(Strings.time11,
                            //           Booking.isClickd.value, Booking),
                            //     ),
                            //     Container(
                            //       child: getTime(Strings.time12,
                            //           Booking.isClickd.value, Booking),
                            //     ),
                            //   ],
                            // ),
                          ],
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
                                    inputType: TextInputType.text,
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
                                    errorText: controller.NoteModel.value.error,
                                    inputType: TextInputType.text,
                                  );
                                }))),
                        Theme(
                          data: ThemeData(
                              checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: Colors.black,
                            visualDensity:
                                VisualDensity(horizontal: -2, vertical: -4),
                            contentPadding:
                                EdgeInsets.only(top: 0.5, bottom: 0.5),
                            value: check1,
                            onChanged: (bool? value) {
                              print(value);
                              setState(() {
                                check1 = value!;
                              });
                            },
                            title: Text(
                              'Remind Customer ?',
                              style: TextStyle(
                                  fontFamily: opensansMedium,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        FadeInUp(
                            from: 50,
                            child: Obx(() {
                              return getFormButton(() {
                                if (controller.isFormInvalidate.value == true) {
                                  // controller.AddBookingAppointmentAPI(context);
                                }
                              }, "Sign In",
                                  validate: controller.isFormInvalidate.value);
                            })),
                        SizedBox(
                          height: 2.h,
                        )
                      ],
                    )),
              ),
            ),
          ]),
        ));
  }
}
