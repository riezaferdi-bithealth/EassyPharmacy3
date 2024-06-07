import 'package:flutter/cupertino.dart';
import 'package:flutter_eassypharmacy/core/core.dart';

Assets assets = Assets();

class Assets {
  static const String appIcons = "";
  static const String landingPageLogo = "assets/images/eassypharmacy_logo.png";
  static const String noNetworkImage = "assets/images/no_image.jpg";
  static const String searchNotFoundImage =
      "assets/images/search_not_found.png";
  static const String cartIsEmptyImage = "assets/images/cart_is_empty.png";

  //Home
  static const Icon cartIcon = Icon(Icons.shopping_cart);
  static const Icon homeIcon = Icon(Icons.home);
  static const Icon profileIcon = Icon(Icons.person);
  static const Icon search = Icon(Icons.search);

  //profile
  static const IconData profileDetailIcon = Icons.account_circle_rounded;
  static const IconData listOrderIcon = Icons.list_alt_rounded;
  static const IconData logoutIcon = Icons.logout_rounded;

  //login_register
  static const IconData passVisible = Icons.visibility;
  static const IconData passNotVisible = Icons.visibility_off;

  //cart page
  static const IconData addQty = Icons.add;
  static const IconData subQty = Icons.remove;
  static const IconData removeCart = Icons.delete;

  //filter icons
  static const IconData ascFilter = CupertinoIcons.sort_up;
  static const IconData descFilter = CupertinoIcons.sort_down;
  static const IconData filterOn = Icons.filter_alt_rounded;
  static const IconData filterOff = Icons.filter_alt_off_rounded;
  static const IconData close = CupertinoIcons.xmark;
}
