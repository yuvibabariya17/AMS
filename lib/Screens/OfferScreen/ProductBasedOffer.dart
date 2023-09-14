import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Models/offers.dart';
import '../../Models/offers_model.dart';
import '../../core/themes/font_constant.dart';

class ProductBasedOffer extends StatefulWidget {
  const ProductBasedOffer({super.key});

  @override
  State<ProductBasedOffer> createState() => _ProductBasedOfferState();
}

class _ProductBasedOfferState extends State<ProductBasedOffer> {
  List<OfferItem> staticData = offersItems;
  var currentPage = 0;
  bool state = false;
  bool state1 = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          OfferItem data = staticData[index];

          return Container(
            margin:
                EdgeInsets.only(top: 1.5.h, left: 8.w, right: 8.w, bottom: 2.h),
            padding: EdgeInsets.only(top: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(child: data.icon),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              data.title,
                              style: TextStyle(
                                  fontFamily: opensansMedium,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.5.sp),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 4.7.h),
                            child: Text(
                              data.offer,
                              style: TextStyle(
                                  fontFamily: opensans_Bold,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: CupertinoSwitch(
                          value: state,
                          onChanged: (value) {
                            state = value;
                            state1 = value;
                            setState(
                              () {},
                            );
                          },
                          thumbColor: CupertinoColors.white,
                          activeColor: CupertinoColors.black,
                          trackColor: Colors.grey,
                        ),
                      )
                    ]),
                SizedBox(
                  height: 0.5.h,
                ),
                Container(
                  height: 5.h,
                  width: 100.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '     Valid till: 26 March',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(10))),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 0.1,
                    blurRadius: 10,
                    offset: Offset(0.5, 0.5)),
              ],
            ),
          );
        },
        itemCount: staticData.length);
  }
}
