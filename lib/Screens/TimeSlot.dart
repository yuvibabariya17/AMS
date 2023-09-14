import 'package:booking_app/controllers/AppointmentBooking_controller.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../core/themes/font_constant.dart';

class Choice {
  Choice({required this.title, required this.isSelected});
  final String title;
  bool isSelected;
}

final controler = AppointmentBookingController();

class SelectCard extends StatefulWidget {
  SelectCard({
    Key? key,
    required this.choice,
    required this.index,
  }) : super(key: key);
  final Choice choice;
  final int index;

  @override
  State<SelectCard> createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       
        SizedBox(
          height: 0.5.h,
        ),
      ],
    );
  }
}
