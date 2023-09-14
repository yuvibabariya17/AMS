import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:telephony/telephony.dart';

import '../core/constants/assets.dart';
import '../core/themes/font_constant.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  Telephony telephony = Telephony.instance;

  @override
  void initState() {
    super.initState();
    setState(() {
      telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) {
          print(message.address); //+977981******67, sender nubmer
          print(message.body); //Your OTP code is 34567
          print(message.date); //1659690242000, timestamp

          String sms = message.body.toString(); //get the message
          print("-----------------");
          print(sms);

          if (message.address == "+917359792115") {
            //verify SMS is sent for OTP with sender number
            String otpcode = sms.replaceAll(new RegExp(r'[^0-9]'), '');
            //prase code from the OTP sms

            //otpbox.set(otpcode.split(""));

            //split otp code to list of number
            //and populate to otb boxes

            setState(() {
              print(otpcode);
              //refresh UI
            });
          } else {
            print("Normal message.");
          }
        },
        listenInBackground: false,
      );
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SvgPicture.asset(Asset.bg, fit: BoxFit.cover),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 35.sp),
                padding: EdgeInsets.only(
                  top: 8.h,
                ),
                child: FadeInDown(
                  from: 50,
                  child: Text(
                    "Otp",
                    style: TextStyle(
                        fontFamily: opensans_Bold,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              PinFieldAutoFill(
                codeLength: 4,
                decoration: UnderlineDecoration(
                  textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                  colorBuilder:
                      FixedColorBuilder(Colors.black.withOpacity(0.3)),
                ),
                currentCode: "123456",
                onCodeSubmitted: (code) {},
                onCodeChanged: (code) {
                  if (code!.length == 4) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
