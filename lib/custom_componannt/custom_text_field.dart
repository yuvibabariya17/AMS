import 'package:booking_app/controllers/UpdateVendor_controller.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/themes/color_const.dart';
import '../controllers/ChangePassword_controller.dart';
import '../controllers/login_controller.dart';
import '../core/themes/font_constant.dart';
import '../core/themes/style.dart';
import '../core/utils/log.dart';
import 'form_inputs.dart';

class CustomFormField extends StatefulWidget {
  CustomFormField(
      {Key? key,
      required this.hintText,
      required this.errorText,
      this.onChanged,
      this.validator,
      this.title,
      this.inputFormatters,
      required this.inputType,
      required this.node,
      this.controller,
      this.formType,
      this.isExpand,
      this.isVerified,
      this.time,
      this.isPhoto,
      this.isDropdown,
      this.onAddBtn,
      this.isCalender,
      this.isHidden,
      this.wantSuffix,
      this.onVerifiyButtonClick,
      this.isDataValidated,
      this.onTap,
      this.isdown,
      this.isReadOnly,
      this.isPick,
      this.isAdd,
      this.isPassword,
      this.fromObsecureText,
      this.index,
      this.isFromAddStory = false,
      this.isEnable = true})
      : super(key: key);
  final TextEditingController? controller;
  final String hintText;
  final FieldType? formType;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final String? title;
  final FocusNode node;
  final Function(String?)? onChanged;
  final bool? isExpand;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final bool? isVerified;
  final bool? isPick;
  final bool? time;
  final bool? isDropdown;
  final Function? onAddBtn;
  final bool? isReadOnly;
  final bool? isPhoto;
  final bool? isPassword;
  final bool? isCalender;
  final Function? onVerifiyButtonClick;
  final bool? wantSuffix;
  final bool? isHidden;
  final bool? isDataValidated;
  final bool? isAdd;
  final bool? isdown;
  final String? fromObsecureText;
  final Function? onTap;
  bool isEnable = true;
  final String? index;
  bool isFromAddStory = false;
  bool obsecuretext = false;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.isExpand! ? 4 : 1,
      enabled: widget.isEnable,
      cursorColor: primaryColor,
      readOnly:
          widget.isCalender == true || widget.isReadOnly == true ? true : false,
      onTap: () {
        if (widget.onTap != null) widget.onTap!();
      },
      obscureText: widget.fromObsecureText == "LOGIN"
          ? Get.find<LoginController>().obsecureText.value
          : widget.fromObsecureText == "RESETPASS"
              ? widget.index == "0"
                  ? Get.find<ChangePasswordController>()
                      .obsecureOldPasswordText
                      .value
                  : widget.index == "1"
                      ? Get.find<ChangePasswordController>()
                          .obsecureNewPasswordText
                          .value
                      : widget.index == "2"
                          ? Get.find<ChangePasswordController>()
                              .obsecureConfirmPasswordText
                              .value
                          : widget.obsecuretext
              : widget.index == "2"
                  ? Get.find<ChangePasswordController>()
                      .obsecureConfirmPasswordText
                      .value
                  : widget.fromObsecureText == "UPDATE VENDOR"
                      ? Get.find<UpdateVendorController>().obsecureText.value
                      : widget.obsecuretext,
      textInputAction: TextInputAction.next,
      keyboardType: widget.inputType,
      validator: widget.validator,
      controller: widget.controller,
      maxLength: widget.inputType == TextInputType.number ? 16 : null,
      style: widget.isFromAddStory
          ? TextStyle(
              fontFamily: fontRegular,
              fontSize:
                  SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 8.sp,
              color: black)
          : styleTextFormFieldText(),
      textAlignVertical: TextAlignVertical.center,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        labelStyle: styleTextForFieldLabel(widget.node),
        contentPadding: EdgeInsets.only(
            left: SizerUtil.deviceType == DeviceType.mobile ? 5.w : 4.w,
            right: SizerUtil.deviceType == DeviceType.mobile ? 5.w : 4.w,
            top: SizerUtil.deviceType == DeviceType.mobile
                ? widget.isExpand!
                    ? 5.h
                    : 0.w
                : 3.w,
            bottom: SizerUtil.deviceType == DeviceType.mobile ? 0.w : 2.w),
        //EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 5.w),
        hintText: widget.hintText,
        errorText: widget.errorText,
        errorStyle: styleTextForErrorFieldHint(),
        hintStyle: styleTextForFieldHint(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              SizerUtil.deviceType == DeviceType.mobile ? 30 : 20),
          borderSide: const BorderSide(
            color: inputBorderColor,
            width: 1.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 1.2),
          borderRadius: BorderRadius.circular(
              SizerUtil.deviceType == DeviceType.mobile ? 30 : 50),
        ),
        counterText: '',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              SizerUtil.deviceType == DeviceType.mobile ? 30 : 50),
          borderSide: const BorderSide(
            color: inputBorderColor,
          ),
        ),
        // prefixStyle: styleTextFormFieldText(),
        prefixIcon: widget.formType != null &&
                widget.formType == FieldType.Mobile
            ? Container(
                padding: const EdgeInsets.only(left: 16, bottom: 3, right: 3),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("+91", style: styleTextFormFieldText()),
                  ],
                ),
              )
            : null,
        prefixIconConstraints:
            const BoxConstraints(minHeight: 25, maxHeight: 50),
        suffixIcon: widget.wantSuffix == true
            ? GestureDetector(
                onTap: () {
                  if (widget.fromObsecureText == "LOGIN") {
                    Get.find<LoginController>().obsecureText.value =
                        !Get.find<LoginController>().obsecureText.value;
                    setState(() {});
                  } else if (widget.fromObsecureText == "UPDATE VENDOR") {
                    Get.find<UpdateVendorController>().obsecureText.value =
                        !Get.find<UpdateVendorController>().obsecureText.value;
                  } else if (widget.fromObsecureText == "RESETPASS") {
                    if (widget.index == "0") {
                      Get.find<ChangePasswordController>()
                              .obsecureOldPasswordText
                              .value =
                          !Get.find<ChangePasswordController>()
                              .obsecureOldPasswordText
                              .value;
                      setState(() {});
                      logcat("ResetpassController", widget.index);
                    } else if (widget.index == "1") {
                      logcat("ResetpassController:111", widget.index);
                      Get.find<ChangePasswordController>()
                              .obsecureNewPasswordText
                              .value =
                          !Get.find<ChangePasswordController>()
                              .obsecureNewPasswordText
                              .value;
                      setState(() {});
                    } else {
                      logcat("ResetpassController:ELSE", widget.index);
                      Get.find<ChangePasswordController>()
                              .obsecureConfirmPasswordText
                              .value =
                          !Get.find<ChangePasswordController>()
                              .obsecureConfirmPasswordText
                              .value;
                      setState(() {});
                    }
                  } else {
                    _togglePasswordView(context);
                  }
                },
                child: widget.time == true
                    ? Padding(
                        padding: SizerUtil.deviceType == DeviceType.mobile
                            ? EdgeInsets.all(4.w)
                            : EdgeInsets.only(right: 3.w),
                        child: SvgPicture.asset(Asset.time,
                            height: SizerUtil.deviceType == DeviceType.mobile
                                ? 0
                                : 10,
                            width: SizerUtil.deviceType == DeviceType.mobile
                                ? 0
                                : 10,
                            fit: BoxFit.contain),
                      )
                    : widget.isDropdown == true
                        ? Row(
                            mainAxisSize: MainAxisSize.min, // added line
                            children: [
                              IconButton(
                                alignment: Alignment.centerRight,
                                onPressed: () {
                                  if (widget.onTap != null) widget.onTap!();
                                },
                                padding: EdgeInsets.only(
                                    left: widget.isAdd == true ? 5.w : 0),
                                icon: SvgPicture.asset(
                                  Asset.dropdown,
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.scaleDown,
                                ),
                                // iconSize:
                                //     SizerUtil.deviceType == DeviceType.mobile
                                //         ? 30
                                //         : 40,
                                color: black.withOpacity(0.2),
                              ),
                              widget.isAdd == true
                                  ? IconButton(
                                      onPressed: () {
                                        if (widget.onAddBtn != null)
                                          widget.onAddBtn!();
                                      },
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.only(
                                          right: SizerUtil.deviceType ==
                                                  DeviceType.mobile
                                              ? 2.w
                                              : 3.w),
                                      icon: const Icon(Icons.add,
                                          color: Colors.grey),
                                      iconSize: SizerUtil.deviceType ==
                                              DeviceType.mobile
                                          ? 25
                                          : 40,
                                      color: isDarkMode() ? white : black,
                                    )
                                  : Container(),
                            ],
                          )
                        :

                        // widget.isDropdown == true
                        //     ? Row(
                        //       children: [
                        //         SvgPicture.asset(
                        //             Asset.dropdown,
                        //             height: 5,
                        //             width: 5,
                        //             fit: BoxFit.scaleDown,
                        //           ),
                        //       ],
                        //     )
                        //     : widget.isAdd == true
                        //         ? Container(
                        //             color: black,
                        //             width: 5.w,
                        //           )
                        widget.isCalender == true
                            ? Padding(
                                padding:
                                    SizerUtil.deviceType == DeviceType.mobile
                                        ? EdgeInsets.all(4.w)
                                        : EdgeInsets.only(right: 3.w),
                                child: SvgPicture.asset(
                                  Asset.calender,
                                  height:
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? 0
                                          : 8,
                                  width:
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? 0
                                          : 8,
                                  fit: BoxFit.contain,
                                  color: Colors.grey,
                                ),
                              )
                            : InkWell(
                                child: widget.isPassword == true
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            right: SizerUtil.deviceType ==
                                                    DeviceType.mobile
                                                ? 0.w
                                                : 3.w),
                                        child: Icon(
                                          widget.fromObsecureText == "LOGIN"
                                              ? Get.find<LoginController>()
                                                      .obsecureText
                                                      .value
                                                  ? Icons.visibility_off
                                                  : Icons.visibility
                                              : widget.fromObsecureText ==
                                                      "UPDATE VENDOR"
                                                  ? Get.find<UpdateVendorController>()
                                                          .obsecureText
                                                          .value
                                                      ? Icons.visibility_off
                                                      : Icons.visibility
                                                  : widget.fromObsecureText ==
                                                          "RESETPASS"
                                                      ? widget.index == "0"
                                                          ? Get.find<ChangePasswordController>()
                                                                  .obsecureOldPasswordText
                                                                  .value
                                                              ? Icons
                                                                  .visibility_off
                                                              : Icons.visibility
                                                          : widget.index == "1"
                                                              ? Get.find<ChangePasswordController>()
                                                                      .obsecureNewPasswordText
                                                                      .value
                                                                  ? Icons
                                                                      .visibility_off
                                                                  : Icons
                                                                      .visibility
                                                              : widget.index ==
                                                                      "2"
                                                                  ? Get.find<ChangePasswordController>()
                                                                          .obsecureConfirmPasswordText
                                                                          .value
                                                                      ? Icons
                                                                          .visibility_off
                                                                      : Icons
                                                                          .visibility
                                                                  : widget
                                                                          .obsecuretext
                                                                      ? Icons
                                                                          .visibility_off
                                                                      : Icons
                                                                          .visibility
                                                      : widget.obsecuretext
                                                          ? Icons.visibility_off
                                                          : Icons.visibility,
                                          color: Colors.grey,
                                          size: SizerUtil.deviceType ==
                                                  DeviceType.mobile
                                              ? 20.sp
                                              : 15.sp,
                                        ),
                                      )
                                    : widget.isdown == true
                                        ? GestureDetector(
                                            onTap: () {
                                              if (widget.onTap != null)
                                                widget.onTap!();
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: SizerUtil.deviceType ==
                                                          DeviceType.mobile
                                                      ? 0.w
                                                      : 3.w),
                                              child: SvgPicture.asset(
                                                Asset.dropdown,
                                                height: 20,
                                                width: 20,
                                                fit: BoxFit.scaleDown,
                                              ),
                                              // child: Icon(
                                              //   Icons
                                              //       .keyboard_arrow_down_rounded,
                                              //   size: SizerUtil.deviceType ==
                                              //           DeviceType.mobile
                                              //       ? 30
                                              //       : 40,
                                              //   color: Colors.black
                                              //       .withOpacity(0.2),
                                              // ),
                                            ),
                                          )
                                        : Padding(
                                            padding: SizerUtil.deviceType ==
                                                    DeviceType.mobile
                                                ? EdgeInsets.all(4.w)
                                                : EdgeInsets.only(right: 3.w),
                                            child: SvgPicture.asset(
                                                Asset.photos,
                                                height: SizerUtil.deviceType ==
                                                        DeviceType.mobile
                                                    ? 0
                                                    : 8,
                                                width: SizerUtil.deviceType ==
                                                        DeviceType.mobile
                                                    ? 0
                                                    : 8,
                                                fit: BoxFit.contain),
                                          ),
                              ))
            : Container(
                width: 1,
              ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.redAccent,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.redAccent,
          ),
        ),
      ),
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
    );
  }

  void _togglePasswordView(BuildContext context) {
    setState(() {
      widget.obsecuretext = !widget.obsecuretext;
    });
  }
}
