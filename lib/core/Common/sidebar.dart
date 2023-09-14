import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../constants/assets.dart';

class sidebar extends StatelessWidget {
  const sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.red,
              // spreadRadius: 1,
              // blurRadius: 10,
              // offset: Offset(4, 4),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Drawer(
          width: MediaQuery.of(context).size.width * 0.7,
          shadowColor: Colors.white,
          backgroundColor: Colors.black,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildHeader(context),
                buildMenuItems(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: 5.h, left: 5.5.h),
        color: Colors.black,
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: SvgPicture.asset(
                Asset.profileimg,
                width: 60,
              ),
            ),
            SizedBox(width: 2.5.h),
            Text(
              "User Name",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      );

  buildMenuItems(BuildContext context) => Container(
      color: Colors.black,
      padding: EdgeInsets.all(15),
      child: Wrap(
        children: [
          ListTile(
            hoverColor: Colors.white,
            leading: SvgPicture.asset(Asset.user),
            title: Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            // leading: Icon(
            //   Icons.add_sharp,
            //   color: Colors.white,
            // ),
            leading: SvgPicture.asset(Asset.add_service),
            title: Text(
              'Add Services',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {},
          ),
          ListTile(
            // leading: Icon(
            //   Icons.add_box,
            //   color: Colors.white,
            // ),
            leading: SvgPicture.asset(Asset.adduser),
            title: Text('Add Expert', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: SvgPicture.asset(Asset.add_service_offer),
            title: Text('Add Service Offer',
                style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: SvgPicture.asset(Asset.passwordlock),
            title:
                Text('Change Password', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: SvgPicture.asset(Asset.settingslider),
            title: Text('Setting', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: SvgPicture.asset(Asset.rate_us),
            title: Text('Rate Us', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: SvgPicture.asset(Asset.share),
            title: Text('Share Us', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: SvgPicture.asset(Asset.signout),
            title: Text('Sign Out', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          SizedBox(height: 10.h),
          ListTile(
            leading: SvgPicture.asset(Asset.info_help),
            title: Text('Help', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
        ],
      ));
}
