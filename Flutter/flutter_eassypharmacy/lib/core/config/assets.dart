import 'package:flutter/material.dart';

Assets assets = Assets();

class Assets {
  static const String appIcons = "";
  static const String landingPageLogo = "assets/images/logo.png";

  //Home
  static const Icon cartIcon = Icon(Icons.shopping_cart);
  static const Icon homeIcon = Icon(Icons.home);
  static const Icon profileIcon = Icon(Icons.person);

  //profile
  static const IconData profileDetailIcon = Icons.account_circle_rounded;
  static const IconData listOrderIcon = Icons.list_alt_rounded;
  static const IconData logoutIcon = Icons.logout_rounded;
}
