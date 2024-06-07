import 'package:flutter_eassypharmacy/core/core.dart';

const int _primaryPrimaryValue = 0xff0D4D8B;
const int _accentPrimaryValue = 0xff5f842b;
const int _tertiaryPrimaryValue = 0xffEFF8F7;

class CompanyColors {
  const CompanyColors(); // this basically makes it so you can instantiate this class

  static const Map<int, Color> primaryColorList = <int, Color>{
    20: Color(0xffebf8ff),
    50: Color(0xffe0f3fc),
    100: Color(0xffb1e0f8),
    200: Color(0xff7fccf2),
    300: Color(0xff4fb9ec),
    400: Color(0xff2faae8),
    500: Color(0xff189ce4),
    600: Color(0xff178ed5),
    700: Color(0xff147cc1),
    800: Color(0xff126bad),
    900: Color(_primaryPrimaryValue),
    1000: Color(0xff093059),
  };

  static const Map<int, Color> accentColorList = <int, Color>{
    20: Color(0xfffcfff7),
    50: Color(0xfffaffef),
    100: Color(0xffdfeac6),
    200: Color(0xffcadca2),
    300: Color(0xffb5cf7d),
    400: Color(0xffa5c560),
    500: Color(0xff96bb45),
    600: Color(0xff87ab3d),
    700: Color(0xff729833),
    800: Color(_accentPrimaryValue),
    900: Color(0xff3e631b),
  };
  static const Map<int, Color> tertiaryColorList = <int, Color>{
    50: Color(_tertiaryPrimaryValue),
    100: Color(0xffdeece8),
    200: Color(0xffcadfdb),
    300: Color(0xffb4d1cb),
    400: Color(0xffa1c3bd),
    500: Color(0xff8fb6af),
    600: Color(0xff81a49d),
    700: Color(0xff6f8d88),
    800: Color(0xff607874),
    900: Color(0xff4d605d),
  };

  static const MaterialColor accent = MaterialColor(
    _accentPrimaryValue,
    accentColorList,
  );

  static const MaterialColor primary = MaterialColor(
    _primaryPrimaryValue,
    primaryColorList,
  );

  static const MaterialColor tertiary = MaterialColor(
    _tertiaryPrimaryValue,
    tertiaryColorList,
  );
}

Color systemPrimaryColor = CompanyColors.primary[900]!;
Color systemPrimary50Color = CompanyColors.primary[50]!;

Color systemAccentColor = CompanyColors.accent[900]!;
Color systemAccent500Color = CompanyColors.accent[500]!;

Color systemBlackColor = Colors.black;

Color systemWhiteColor = Colors.white;

Color systemGreyColor = Colors.grey;

Color systemLightGreyColor = const Color.fromARGB(255, 231, 231, 231);

Color systemRedColor = Colors.red;

Color systemOrangeColor = Colors.orange;

Color systemYellowColor = Colors.yellow;
