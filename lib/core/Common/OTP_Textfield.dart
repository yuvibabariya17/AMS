import 'package:booking_app/controllers/OtpController.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class OtpInput extends StatefulWidget {
  final TextEditingController controller;
  final bool autoFocus;
  final bool? isLast;
  final FocusNode node;
  final Function(bool) onLastField;

  const OtpInput(this.controller, this.autoFocus, this.node, this.onLastField,
      {Key? key, this.isLast})
      : super(key: key);

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  @override
  void initState() {
    super.initState();
    widget.node.addListener(() {
      setState(() {});
    });
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  String fieldValue = "";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizerUtil.deviceType == DeviceType.mobile ? 15.w : 10.w,
      width: SizerUtil.deviceType == DeviceType.mobile ? 15.w : 10.w,
      child: TextFormField(
        onTap: () {
          print("ID DONE");
        },
        focusNode: widget.node,
        cursorColor: Colors.black,
        controller: widget.controller,
        autofocus: widget.autoFocus,
        cursorWidth: 0.8,
        cursorHeight: SizerUtil.deviceType == DeviceType.mobile ? 40 : 45,
        maxLength: 1,
        textInputAction: widget.isLast == true || fieldValue.isNotEmpty
            ? TextInputAction.done
            : TextInputAction.next,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        onChanged: (value) {
          if (value.trim().length == 1) {
            fieldValue = value;
            setState(() {});
            if (widget.onLastField != null) {
              Get.find<OtpController>().handleLastField(true);
              if (widget.isLast == true) {
                widget.node.unfocus();
              } else {
                widget.node.nextFocus();
              }
            } else {
              Get.find<OtpController>().handleLastField(true);
            }
          } else if (value.isEmpty) {
            fieldValue = value;
            setState(() {});
            if (widget.isLast != true) {
              widget.node.previousFocus(); // Move focus to the previous field
            }
          } else {
            logcat("widget.onLastField", "FALSE");
            Get.find<OtpController>().handleLastField(false);
            fieldValue = "";
            widget.node.previousFocus();
          }
        },
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
            fontFamily: fontUrbanistExtraBold,
            fontSize: SizerUtil.deviceType == DeviceType.mobile ? 22.sp : 15.sp,
            color: black),
        decoration: InputDecoration(
          fillColor: widget.controller.text.toString().isNotEmpty
              ? secondaryColor
              : Graycolor,
          filled: widget.controller.text.toString().isNotEmpty ? true : false,
          counterText: '',
          contentPadding: EdgeInsets.only(
              top: SizerUtil.deviceType == DeviceType.mobile ? 1.2.h : 0,
              bottom: SizerUtil.deviceType == DeviceType.mobile ? 0.8.h : 0),
          hintStyle: const TextStyle(
            fontFamily: fontRegular,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                SizerUtil.deviceType == DeviceType.mobile ? 5.w : 2.5.w),
            borderSide: BorderSide(
              color: widget.controller.text.toString().isEmpty
                  ? black
                  : secondaryColor,
              width: 0.4.w,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                SizerUtil.deviceType == DeviceType.mobile ? 5.w : 2.5.w),
            borderSide: BorderSide(
              color: black,
              width: 0.4.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                SizerUtil.deviceType == DeviceType.mobile ? 5.w : 2.5.w),
            borderSide: BorderSide(
              color: widget.controller.text.toString().isEmpty
                  ? secondaryColor
                  : black,
              width: 0.4.w,
            ),
          ),
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
