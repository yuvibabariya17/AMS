import 'package:animate_do/animate_do.dart';
import 'package:booking_app/Models/AppointmentListModel.dart';
import 'package:booking_app/core/Common/Common.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/custom_componannt/CustomeBackground.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/AppointmentBooking_controller.dart';
import '../../core/Common/toolbar.dart';
import '../../core/constants/strings.dart';
import '../../core/themes/color_const.dart';
import '../../core/themes/font_constant.dart';
import '../../custom_componannt/common_views.dart';
import '../../custom_componannt/form_inputs.dart';
import '../ExpertScreen/AddExpertScreen.dart';

class AppointmentBookingScreen extends StatefulWidget {
  AppointmentBookingScreen(
      {super.key, this.selectedDate, this.isEdit, this.editAppointment});
  bool? isEdit;
  ListofAppointment? editAppointment;

  String? selectedDate;

  @override
  State<AppointmentBookingScreen> createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  final controller = Get.put(AppointmentBookingController());
  late TimeOfDay selectedTime;
  DateTime selectedDate = DateTime.now();
  bool check1 = false;

  @override
  void initState() {
    controller.getServiceList(context);
    controller.getExpertList(context);
    controller.getCustomerList(context);
    controller.getAppointmentSlot(context);

    if (widget.isEdit == true && widget.editAppointment != null) {
      controller.Customerctr.text =
          widget.editAppointment!.customerInfo.name.toString();
      controller.Servicectr.text =
          widget.editAppointment!.vendorServiceInfo.serviceInfo.name.toString();
      controller.expertctr.text =
          widget.editAppointment!.expertInfo.name.toString();
      controller.datectr.text =
          widget.editAppointment!.dateOfAppointment.toString();
      controller.durationctr.text = widget.editAppointment!.duration.toString();
      controller.Slotctr.text =
          widget.editAppointment!.appointmentSlotId.toString();
      controller.Amountctr.text = widget.editAppointment!.amount.toString();
      controller.appointmentTypectr.text =
          widget.editAppointment!.appointmentType.toString();
      controller.Notectr.text = widget.editAppointment!.notes.toString();

      controller.apiFormattedDate.value =
          widget.editAppointment!.dateOfAppointment.toString().trim();

      controller.customerId.value =
          widget.editAppointment!.customerId.toString();
      controller.ServiceId.value =
          widget.editAppointment!.vendorServiceId.toString();
      controller.expertId.value = widget.editAppointment!.exportId.toString();
    }
    if (widget.selectedDate != null) {
      controller.datectr.text =
          Common().formatDates(widget.selectedDate.toString());
      controller.validateDate(controller.datectr.text);
      controller.apiFormattedDate.value = widget.selectedDate!;
      setState(() {});
    }
    if (widget.isEdit == true) {
      validateFields();
    }
    super.initState();
  }

  void validateFields() {
    // Validate all fields here
    controller.validateCustomer(controller.Customerctr.text);
    controller.validateService(controller.Servicectr.text);
    controller.validateExpert(controller.expertctr.text);
    controller.validateDate(controller.datectr.text);
    controller.validateDuration(controller.durationctr.text);
    controller.validateDuration(controller.durationctr.text);
    // controller.validateSlots(controller.Pricectr.text);
    controller.validateAmount(controller.Amountctr.text);
    controller.validateAppointmentType(controller.appointmentTypectr.text);
    controller.validateNote(controller.Notectr.text);

    // Add validation for other fields as needed
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

  String formatTime(String timeString) {
    // Parse the time string into a DateTime object
    DateTime dateTime = DateTime.parse(timeString);
    // Format the time into the desired format
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.hideKeyboard(context);
      },
      child: CustomScaffold(
          body: Column(
        children: [
          getCommonToolbar(
              widget.isEdit == true
                  ? "Update Appointment"
                  : ScreenTitle.appointmentBooking, () {
            Get.back();
          }),
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
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
                            getTitle(CommonConstant.customer),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.CustomerNode,
                                        controller: controller.Customerctr,
                                        hintLabel: AppointmentBookingConstant
                                            .customer_hint,
                                        wantSuffix: true,
                                        isdown: true,
                                        onChanged: (val) {
                                          controller.validateCustomer(val);
                                        },
                                        isReadOnly: true,
                                        onTap: () {
                                          controller.Customerctr.text = "";
                                          showDropDownDialog(
                                              context,
                                              controller.setCustomerList(),
                                              "Customer List");
                                          // showDropdownMessage(
                                          //     context,
                                          //     controller.setExpertList(),
                                          //     'Select Expert');
                                        },
                                        errorText: controller
                                            .CustomerModel.value.error,
                                        inputType: TextInputType.none,
                                      );
                                    }))),
                            getTitle(AppointmentBookingConstant.Services),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.ServiceNode,
                                        controller: controller.Servicectr,
                                        hintLabel:
                                            AppointmentBookingConstant.Services,
                                        wantSuffix: true,
                                        isdown: true,
                                        onChanged: (val) {
                                          controller.validateService(val);
                                          setState(() {});
                                        },
                                        isReadOnly: true,
                                        onTap: () {
                                          controller.Servicectr.text = "";
                                          showDropDownDialog(
                                              context,
                                              controller.setServiceList(),
                                              "Service List");
                                          // showDropdownMessage(
                                          //     context,
                                          //     controller.setServiceList(),
                                          //     'Select Category');
                                        },
                                        errorText: controller
                                            .ServicesModel.value.error,
                                        inputType: TextInputType.none,
                                      );
                                    }))),
                            getTitle("Experts"),
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
                                        isReadOnly: true,
                                        onAddBtn: () {
                                          Get.to(AddExpertScreen());
                                        },
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
                                              "Expert List");
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
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2050));
                                          if (pickedDate != null &&
                                              pickedDate != selectedDate) {
                                            setState(() {
                                              selectedDate = pickedDate;
                                            });
                                          }
                                          logcat("SELECTED_DATE", pickedDate);
                                          // if (widget.selectedDate != null &&
                                          //     widget.selectedDate!.isNotEmpty) {
                                          //   controller.apiFormattedDate.value =
                                          //       widget.selectedDate!;
                                          // }

                                          if (pickedDate != null) {
                                            //2024-02-22T00:00:00.704Z
                                            controller.apiFormattedDate
                                                .value = DateFormat(
                                                    "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                                .format(pickedDate);

                                            String formattedDate =
                                                DateFormat(Strings.dateFormat)
                                                    .format(pickedDate);
                                            controller
                                                .updateDate(formattedDate);
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

                            getTitle(AddCourseConstant.duration),
                            FadeInDown(
                              child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: Obx(() {
                                  return getReactiveFormField(
                                      node: controller.durationNode,
                                      controller: controller.durationctr,
                                      hintLabel: AddCourseConstant.durationHint,
                                      onChanged: (val) {
                                        controller.validateDuration(val);
                                      },
                                      inputType: TextInputType.text,
                                      errorText:
                                          controller.durationModel.value.error);
                                }),
                              ),
                            ),

                            // getTitle("Duration"),
                            // FadeInUp(
                            //     from: 30,
                            //     child: AnimatedSize(
                            //         duration: const Duration(milliseconds: 300),
                            //         child: Obx(() {
                            //           return getReactiveFormField(
                            //             node: controller.durationNode,
                            //             controller: controller.durationctr,
                            //             wantSuffix: true,
                            //             time: true,
                            //             hintLabel: "Enter Duration",
                            //             isReadOnly: true,
                            //             onChanged: (val) {
                            //               controller.validateDuration(val);
                            //               setState(() {});
                            //             },
                            //             onTap: () async {
                            //               final TimeOfDay? pickedDuration =
                            //                   await showTimePicker(
                            //                 context: context,
                            //                 initialTime: TimeOfDay.now(),
                            //               );

                            //               if (pickedDuration != null) {
                            //                 final DateTime currentDate =
                            //                     DateTime.now();
                            //                 final DateTime combinedDateTime =
                            //                     DateTime(
                            //                   currentDate.year,
                            //                   currentDate.month,
                            //                   currentDate.day,
                            //                   pickedDuration.hour,
                            //                   pickedDuration.minute,
                            //                   0,
                            //                   704,
                            //                 );

                            //                 final SittingDurationTime =
                            //                     "${pickedDuration.format(context)}";
                            //                 //For All Format
                            //                 controller.sitingTime =
                            //                     "${DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(combinedDateTime)}Z";

                            //                 controller.updateSittingDuration(
                            //                     SittingDurationTime);
                            //                 controller.validateDuration(
                            //                     SittingDurationTime);
                            //                 setState(() {
                            //                   selectedTime = pickedDuration;
                            //                   print(
                            //                       "Selected Time: $SittingDurationTime");
                            //                 });
                            //               }

                            //               // DateTime? pickedDate =
                            //               //     await showDatePicker(
                            //               //   context: context,
                            //               //   initialDate: controller.durationDate,
                            //               //   firstDate: DateTime(1950),
                            //               //   lastDate: DateTime(2050),
                            //               //   // lastDate: DateTime.now().add(
                            //               //   //     const Duration(days: 0))
                            //               // );
                            //               // if (pickedDate != null &&
                            //               //     pickedDate !=
                            //               //         controller.durationDate) {
                            //               //   setState(() {
                            //               //     controller.durationDate = pickedDate;
                            //               //     controller.durationDate = DateTime(
                            //               //       pickedDate.year,
                            //               //       pickedDate.month,
                            //               //       pickedDate.day,
                            //               //       controller.durationDate.hour,
                            //               //       controller.durationDate.minute,
                            //               //       controller.durationDate.second,
                            //               //     );
                            //               //   });
                            //               // }
                            //               // if (pickedDate != null) {
                            //               //   String formattedDate =
                            //               //       DateFormat(Strings.oldDateFormat)
                            //               //           .format(pickedDate);
                            //               //   controller.updateSittingDuration(
                            //               //       formattedDate);
                            //               //   controller
                            //               //       .validateDuration(formattedDate);
                            //               // }
                            //             },
                            //             errorText: controller
                            //                 .durationModel.value.error,
                            //             inputType: TextInputType.none,
                            //           );
                            //         }))),

                            Obx(
                              () {
                                logcat(
                                  "EXPERTSLOT_LIST",
                                  controller.slotObjectList.length,
                                );
                                return controller.slotObjectList.length != 0
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          getTitle(AppointmentBookingConstant
                                              .Appointment_slot),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          GridView.count(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              childAspectRatio: 2.0,
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 17,
                                              mainAxisSpacing: 4,
                                              children: List.generate(
                                                  controller.slotObjectList
                                                      .length, (index) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                      top: 0.6.h),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      controller.selectedIndex
                                                          .value = index;

                                                      controller
                                                              .selectedAppointmentSlotId
                                                              .value =
                                                          controller
                                                              .slotObjectList[
                                                                  index]
                                                              .id;

                                                      logcat(
                                                          "Appointment Slot ID",
                                                          controller
                                                              .selectedAppointmentSlotId
                                                              .value);

                                                      // print(
                                                      //     "ExpertID: ${controller.slotObjectList[index].id}");
                                                      // controller.isItemSelected.value =
                                                      //     true;
                                                      controller
                                                          .updateSelectedTimeSlote(
                                                              true);
                                                      setState(() {
                                                        logcat(
                                                            "SELECTED_APPOINTMENT_SLOT_ID",
                                                            controller
                                                                .selectedAppointmentSlotId
                                                                .value);
                                                        // logcat(
                                                        //     "SELECT_ITEM",
                                                        //     controller
                                                        //         .isItemSelected.value);
                                                      });
                                                    },
                                                    child: AnimatedContainer(
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                      width: 25.w,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: controller
                                                                          .selectedIndex
                                                                          .value ==
                                                                      index
                                                                  ? black
                                                                  : black),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(14),
                                                          color: controller
                                                                      .selectedIndex
                                                                      .value ==
                                                                  index
                                                              ? black
                                                              : white),
                                                      child: Center(
                                                        child: Text(
                                                          formatTime(
                                                            controller
                                                                .slotObjectList[
                                                                    index]
                                                                .timeOfAppointment
                                                                .toString(),
                                                          ),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  opensans_Bold,
                                                              color: controller
                                                                          .selectedIndex
                                                                          .value ==
                                                                      index
                                                                  ? white
                                                                  : black,
                                                              fontSize: SizerUtil
                                                                          .deviceType ==
                                                                      DeviceType
                                                                          .mobile
                                                                  ? 10.sp
                                                                  : 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              })),
                                        ],
                                      )
                                    : Container();
                              },
                            ),

                            SizedBox(height: 2.h),
                            getTitle(CommonConstant.amount),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.AmountNode,
                                        controller: controller.Amountctr,
                                        hintLabel: CommonConstant.amount_hint,
                                        onChanged: (val) {
                                          controller.validateAmount(val);
                                          setState(() {});
                                        },
                                        errorText:
                                            controller.AmountModel.value.error,
                                        inputType: TextInputType.number,
                                      );
                                    }))),
                            getTitle("Appointment Type"),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.appointmentTypeNode,
                                        controller:
                                            controller.appointmentTypectr,
                                        hintLabel: "Enter Appointment Type",
                                        onChanged: (val) {
                                          controller
                                              .validateAppointmentType(val);
                                          setState(() {});
                                        },
                                        errorText: controller
                                            .appointmentTypeModel.value.error,
                                        inputType: TextInputType.name,
                                      );
                                    }))),
                            getTitle(AddCourseConstant.notes),
                            FadeInUp(
                                from: 30,
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Obx(() {
                                      return getReactiveFormField(
                                        node: controller.NoteNode,
                                        controller: controller.Notectr,
                                        hintLabel: AddCourseConstant.notesHint,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        activeColor:
                                            isDarkMode() ? white : black,
                                        checkColor:
                                            isDarkMode() ? black : white,
                                        visualDensity: const VisualDensity(
                                          horizontal: -2,
                                        ),
                                        value: controller.isRemind.value,
                                        onChanged: (value) {
                                          controller.isRemind.value = value!;
                                          controller.enableSignUpButton();
                                          setState(() {
                                            // logcat(tag, data)
                                          });
                                        },
                                      ),
                                      SizedBox(width: 0.5.w),
                                      GestureDetector(
                                        onTap: () async {
                                          if (controller.isRemind.value ==
                                              true) {
                                            if (!await launchUrl(
                                              Uri.parse('http://google.com/'),
                                              mode: LaunchMode
                                                  .externalApplication,
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
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  isDarkMode() ? white : black),
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
                                      if (widget.isEdit == true) {
                                        // Call updateCourse API
                                        controller.UpdateAppointment(
                                          context,
                                          widget.editAppointment!.id,
                                        );
                                      } else {
                                        // Call AddCourseApi API
                                        controller.AddBookingAppointmentAPI(
                                            context);
                                      }
                                    }
                                  }, CommonConstant.submit,
                                      validate:
                                          controller.isFormInvalidate.value);
                                })),

                            // FadeInUp(
                            //     from: 50,
                            //     child: Obx(() {
                            //       return getFormButton(() {
                            //         if (controller.isFormInvalidate.value ==
                            //             true) {
                            //           controller.AddBookingAppointmentAPI(
                            //               context);
                            //         }
                            //       }, "Submit",
                            //           validate:
                            //               controller.isFormInvalidate.value);
                            //     })),
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
      )),
    );
  }
}
