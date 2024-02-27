import 'package:booking_app/core/constants/assets.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final Widget? floatingActionBtn;
  bool? isListScreen;

  CustomScaffold({
    required this.body,
    this.floatingActionBtn,
    this.isListScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: Colors.transparent,
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
          Scaffold(
            resizeToAvoidBottomInset: isListScreen == true ? false : true,
            backgroundColor:
                transparent, // Make the Scaffold's background transparent
            body: SafeArea(child: body),
            floatingActionButton: floatingActionBtn,
          ),
        ],
      ),
    );
  }
}
