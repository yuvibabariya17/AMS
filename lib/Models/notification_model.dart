import 'package:booking_app/Models/notification_Static.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/constants/assets.dart';

List<NotificationItem> notificationItems = <NotificationItem>[
  NotificationItem(
    icon: SvgPicture.asset(Asset.profileimg),
    Name: 'Justin',
    Status: 'Completed',
    time: '09:00 AM',
    title: 'Hair Treatment',
  ),
  NotificationItem(
    icon: SvgPicture.asset(Asset.profileimg),
    Name: 'Maulik',
    Status: 'Pending',
    time: '10:00 AM',
    title: 'Hair Cutting / Hair Smoothing',
  ),
  NotificationItem(
    icon: SvgPicture.asset(Asset.profileimg),
    Name: 'Sachin',
    Status: 'Canceled',
    time: '11:00 AM',
    title: 'Hair Spa / Hair Treatment',
  ),
  NotificationItem(
    icon: SvgPicture.asset(Asset.profileimg),
    Name: 'Hiral',
    Status: 'Completed',
    time: '01:00 PM',
    title: 'Hair Treatment',
  ),
  NotificationItem(
    icon: SvgPicture.asset(Asset.profileimg),
    Name: 'Riya',
    Status: 'Pending',
    time: '02:00 PM',
    title: 'Nail Extensions',
  ),
  NotificationItem(
    icon: SvgPicture.asset(Asset.profileimg),
    Name: 'Ashwini',
    Status: 'Canceled',
    time: '04:00 PM',
    title: 'Bridal Makeup',
  ),
];
