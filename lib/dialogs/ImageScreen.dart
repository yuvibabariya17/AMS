import 'package:booking_app/core/Common/Common.dart';
import 'package:booking_app/core/Common/toolbar.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';

class FullScreenImage extends StatefulWidget {
  final String imageUrl; // URL of the image to display

  FullScreenImage({
    required this.imageUrl,
    this.title,
  });
  bool? fromProfile;
  String? title;

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    Common().trasparent_statusbar();
    return Scaffold(
      body: Container(
        color: black,
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            getImage(
              widget.title,
              callback: () {
                Get.back();
              },
            ),
            Expanded(
              child: Center(
                child: PhotoView(
                  imageProvider: NetworkImage(widget.imageUrl),
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
