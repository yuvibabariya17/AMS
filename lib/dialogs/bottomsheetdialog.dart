import 'package:booking_app/core/themes/color_const.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../core/themes/font_constant.dart';
import '../core/utils/helper.dart';

Future showbottomsheetdialog(BuildContext context) {
  bool? check2 = false;

  bool? check3 = false;

  bool check1 = false;
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      top: Radius.circular(25.0),
    )),
    builder: (context) {
      return Container(
        height: 40.h,
        padding:
            EdgeInsets.only(left: 3.5.h, right: 3.5.h, top: 2.h, bottom: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
                child: Text(
              'Filter',
              style: TextStyle(
                fontFamily: opensans_Bold,
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
                color: isDarkMode() ? white : black,
              ),
            )),
            SizedBox(
              height: 0.5.h,
            ),
            Divider(
              height: 3.h,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            Wrap(
              children: [
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Column(
                      children: [
                        Theme(
                          data: ThemeData(
                              checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: isDarkMode() ? white : black,
                            visualDensity:
                                VisualDensity(horizontal: -2, vertical: -4),
                            contentPadding:
                                EdgeInsets.only(top: 0.5, bottom: 0.5),
                            value: check1,
                            onChanged: (bool? value) {
                              print(value);
                              setState(() {
                                check1 = value!;
                              });
                            },
                            title: Text(
                              'Cancelations',
                              style: TextStyle(
                                  color: isDarkMode() ? white : black,
                                  fontFamily: opensansMedium,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Theme(
                          data: ThemeData(
                              checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: isDarkMode() ? white : black,
                            contentPadding:
                                EdgeInsets.only(top: 0.5, bottom: 0.5),
                            visualDensity:
                                VisualDensity(horizontal: -2, vertical: -4),
                            value: check2,
                            onChanged: (bool? value) {
                              setState(() {
                                check2 = value;
                              });
                            },
                            title: Text('Pending',
                                style: TextStyle(
                                    color: isDarkMode() ? white : black,
                                    fontFamily: opensansMedium,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                        Theme(
                          data: ThemeData(
                              checkboxTheme: CheckboxThemeData(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          )),
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: isDarkMode() ? white : black,
                            contentPadding: EdgeInsets.only(
                              top: 0.5,
                            ),
                            visualDensity:
                                VisualDensity(horizontal: -2, vertical: -4),
                            value: check3,
                            onChanged: (bool? value) {
                              setState(() {
                                check3 = value;
                              });
                            },
                            title: Text('Late Cancelations',
                                style: TextStyle(
                                    color: isDarkMode() ? white : black,
                                    fontFamily: opensansMedium,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 3.5.h),
                  child: SizedBox(
                    width: 150.h,
                    height: 5.5.h,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        child: Center(
                          child: Text(
                            'Apply',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.5.sp,
                                fontFamily: opensans_Bold,
                                fontWeight: FontWeight.w700),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
