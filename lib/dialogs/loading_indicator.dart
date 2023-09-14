import 'package:flutter/material.dart';

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
                      color: Colors.transparent,
                    ),
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      "assets/gif/loading.gif",
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
                Text(message)
              ],
            ),
          ),
        ));
      },
    );
  }

  hide(BuildContext context) async {
    Navigator.pop(context);
  }
}
