import 'package:flutter/material.dart';

class ServiceBasedOffer extends StatefulWidget {
  const ServiceBasedOffer({super.key});

  @override
  State<ServiceBasedOffer> createState() => _ServiceBasedOfferState();
}

class _ServiceBasedOfferState extends State<ServiceBasedOffer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Service Based')),
    );
  }
}
