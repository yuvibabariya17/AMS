import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoadingProgressDialog {
  show(BuildContext context, message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Center(
              child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(20),
                      child: Image.asset(
                        "assets/gif/ZKZg.gif",
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  Text(message)
                ],
              ),
            ),
          )),
        );
      },
    );
  }

  hide(BuildContext context) {
    Navigator.pop(context);
  }
}

class LoadingProgressDialogData {
  final GlobalKey<State> _key = GlobalKey<State>();
  OverlayEntry? _overlayEntry;

  show(BuildContext context, message) {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          height: SizerUtil.height,
          width: SizerUtil.width,
          child: Center(
            child: Material(
              color: Colors.transparent, // Set the opacity here
              child: Container(
                key: _key,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        height: 60,
                        width: 60,
                        padding: const EdgeInsets.all(20),
                        child: Image.asset(
                          "assets/gif/ZKZg.gif",
                          width: 60,
                          height: 60,
                        ),
                      ),
                    ),
                    Text(message)
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
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}
