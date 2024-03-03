import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_app_rivan/constants/assets_constants.dart';
import 'package:new_app_rivan/theme/pallete.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        // ignore: deprecated_member_use
        color: Pallete.blueColor,
        height: 30,
      ),
      centerTitle: true,
    );
  }

  static List<Widget> bottomTabBarPages = [
    const Text("Home"),
    const Text("Search"),
    const Text("Noti"),
  ];
}
