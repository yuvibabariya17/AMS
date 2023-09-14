import 'package:booking_app/Models/service.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/assets.dart';

List<ServiceItem> SettingsItems = <ServiceItem>[
  ServiceItem(icon: SvgPicture.asset(Asset.circle), Name: 'Haircuts'),
  ServiceItem(icon: SvgPicture.asset(Asset.circle), Name: 'Hair Color'),
  ServiceItem(icon: SvgPicture.asset(Asset.circle), Name: 'Hair Treatments'),
  ServiceItem(icon: SvgPicture.asset(Asset.circle), Name: 'Styling'),
  ServiceItem(icon: SvgPicture.asset(Asset.circle), Name: 'Skin Care'),
  ServiceItem(icon: SvgPicture.asset(Asset.circle), Name: 'Nail Services'),
  ServiceItem(icon: SvgPicture.asset(Asset.circle), Name: 'Makeup'),
];
