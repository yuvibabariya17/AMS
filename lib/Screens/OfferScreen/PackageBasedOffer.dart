import 'package:flutter/material.dart';

class PackageBasedOffer extends StatefulWidget {
  const PackageBasedOffer({super.key});

  @override
  State<PackageBasedOffer> createState() => _PackageBasedOfferState();
}

class _PackageBasedOfferState extends State<PackageBasedOffer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Package Based')),
    );
  }
}
