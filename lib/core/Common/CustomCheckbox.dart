import 'package:booking_app/core/themes/color_const.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomCheckbox extends StatefulWidget {
  CustomCheckbox({
    Key? key,
    this.color,
    this.onChanged,
    this.checkColor,
    this.isChecked,
  }) : super(key: key);

  final Color? color;
  // Now you can set the checkmark size of your own
  final Color? checkColor;
  final Function(bool?)? onChanged;
  bool? isChecked = false;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => widget.isChecked = !widget.isChecked!);
        widget.onChanged?.call(widget.isChecked);
      },
      child: Container(
        width: 2.8.h,
        height: 2.8.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.color ?? Colors.grey.shade500,
            width: 2.0,
          ),
          color: widget.isChecked! ? widget.color : white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: widget.isChecked!
            ? Icon(
                Icons.check,
                size: 2.h,
                color: widget.checkColor,
              )
            : null,
      ),
    );
  }
}
