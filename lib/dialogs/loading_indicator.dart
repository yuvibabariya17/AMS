import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoadingProgressDialog {
  show(BuildContext data, message) {
    showDialog(
      context: data,
      barrierDismissible: false,
      builder: (BuildContext parentContext) {
        return Center(
            child: Material(
          color: Colors.transparent,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: isDarkMode() ? black : white,
              ),
              child: Container(
                height: 8.h,
                width: 8.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: isDarkMode() ? black : white,
                ),
                child: Center(
                  child: ClipOval(
                    child: Image.asset(
                      'assets/gif/loadingIndicator.gif',
                      // color: isDarkMode() ? black : white,
                      height: 6.h,
                      width: 6.h,
                    ),
                  ),
                ),
              )),
        ));
      },
    );
  }

  hide(BuildContext context) async {
    Navigator.pop(context);
  }
}

class LoadingProgressDialogs {
  final GlobalKey<State> _key = GlobalKey<State>();
  OverlayEntry? _overlayEntry;

  show(BuildContext context, message) {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        // Statusbar().trasparentStatusbarProfile(true);
        return Container(
          height: SizerUtil.height,
          width: SizerUtil.width,
          color: black.withOpacity(0.3),
          child: Center(
            child: Material(
              color: transparent,
              child: Container(
                key: _key,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: transparent,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: white,
                        ),
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: ClipOval(
                            child: Image.asset(
                              'assets/gif/loadingIndicator.gif',
                              // color: isDarkMode() ? black : white,
                              height: 6.h,
                              width: 6.h,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(message),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  hide(BuildContext context) {
    logcat('BuildContext', 'CONTEXXXXX');
    if (_overlayEntry != null) {
      logcat('isHIDE', 'HIDEEEEEE');
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}
