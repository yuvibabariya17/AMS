import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/assets.dart';

class BottomNotificationScreen extends StatefulWidget {
  const BottomNotificationScreen({super.key});

  @override
  State<BottomNotificationScreen> createState() =>
      _BottomNotificationScreenState();
}

class _BottomNotificationScreenState extends State<BottomNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SvgPicture.asset(
          Asset.bg,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
