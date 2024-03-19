import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../core/constants/assets.dart';
import 'offers.dart';

List<OfferItem> offersItems = <OfferItem>[
  OfferItem(
    title: 'Hair Smoothening',
    button: SvgPicture.asset(
      Asset.togglebutton,
      height: 4.h,
      width: 4.h,
    ),
    icon: SvgPicture.asset(Asset.bluestar),
    offer: 'Flat 15% Off',
    date: 'Valid till:26 March',
  ),
  OfferItem(
    title: 'Hair Smoothening',
    button: SvgPicture.asset(
      Asset.togglebutton,
      height: 4.h,
      width: 4.h,
    ),
    icon: SvgPicture.asset(Asset.orangestar),
    offer: 'Flat 15% Off',
    date: 'Valid till:26 March',
  )
];
