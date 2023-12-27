import 'package:booking_app/Models/service_name.dart';
import 'package:booking_app/core/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

List<Service_Item> ServicesItems = <Service_Item>[
  Service_Item(
      icon: Image.asset(
        Asset.placeholder,
        height: 10.h,
        fit: BoxFit.cover,
      ),
      Name: 'Haircuts'),
  Service_Item(
      icon: Image.asset(
        Asset.placeholder,
        height: 10.h,
        fit: BoxFit.cover,
      ),
      Name: 'Hair Color'),
  Service_Item(
      icon: Image.asset(
        Asset.placeholder,
        height: 10.h,
        fit: BoxFit.cover,
      ),
      Name: 'Hair Treatments'),
  Service_Item(
      icon: Image.asset(
        Asset.placeholder,
        height: 10.h,
        fit: BoxFit.cover,
      ),
      Name: 'Styling'),
  Service_Item(
      icon: Image.asset(
        Asset.placeholder,
        height: 10.h,
        fit: BoxFit.cover,
      ),
      Name: 'Skin Care'),
  Service_Item(
      icon: Image.asset(
        Asset.placeholder,
        height: 10.h,
        fit: BoxFit.cover,
      ),
      Name: 'Nail Services'),
  Service_Item(
      icon: Image.asset(
        Asset.placeholder,
        height: 10.h,
        fit: BoxFit.cover,
      ),
      Name: 'Makeup'),
];
