import 'dart:ui' as ui show Shadow, FontFeature;

import 'package:flutter_eassypharmacy/core/core.dart';

const TextStyleExtension _default = TextStyleExtension(fontFamily: fontDefault);

final TextStyleExtension p = _default.copyWithFunct(fontSize: 8.0);

final TextStyleExtension p8 = _default.copyWithFunct(fontSize: 8.0);
final TextStyleExtension p10 = _default.copyWithFunct(fontSize: 10.0);
final TextStyleExtension p12 = _default.copyWithFunct(fontSize: 12.0);
final TextStyleExtension p14 = _default.copyWithFunct(fontSize: 14.0);
final TextStyleExtension p15 = _default.copyWithFunct(fontSize: 15.0);
final TextStyleExtension p16 = _default.copyWithFunct(fontSize: 16.0);
final TextStyleExtension p18 = _default.copyWithFunct(fontSize: 18.0);
final TextStyleExtension p20 = _default.copyWithFunct(fontSize: 20.0);
final TextStyleExtension p22 = _default.copyWithFunct(fontSize: 22.0);
final TextStyleExtension p24 = _default.copyWithFunct(fontSize: 24.0);
final TextStyleExtension p26 = _default.copyWithFunct(fontSize: 26.0);
final TextStyleExtension p28 = _default.copyWithFunct(fontSize: 28.0);
final TextStyleExtension p30 = _default.copyWithFunct(fontSize: 30.0);
final TextStyleExtension p32 = _default.copyWithFunct(fontSize: 32.0);

final TextStyleExtension h10 = _default.copyWithFunct(fontSize: 10.0, fontWeight: FontWeight.w700);

final TextStyleExtension h12 = _default.copyWithFunct(fontSize: 12.0, fontWeight: FontWeight.w700);
final TextStyleExtension h14 = _default.copyWithFunct(fontSize: 14.0, fontWeight: FontWeight.w700);
final TextStyleExtension h16 = _default.copyWithFunct(fontSize: 16.0, fontWeight: FontWeight.w700);
final TextStyleExtension h18 = _default.copyWithFunct(fontSize: 18.0, fontWeight: FontWeight.w700);
final TextStyleExtension h20 = _default.copyWithFunct(fontSize: 20.0, fontWeight: FontWeight.w700);
final TextStyleExtension h22 = _default.copyWithFunct(fontSize: 22.0, fontWeight: FontWeight.w700);
final TextStyleExtension h24 = _default.copyWithFunct(fontSize: 24.0, fontWeight: FontWeight.w700);
final TextStyleExtension h26 = _default.copyWithFunct(fontSize: 26.0, fontWeight: FontWeight.w700);
final TextStyleExtension h28 = _default.copyWithFunct(fontSize: 28.0, fontWeight: FontWeight.w700);
final TextStyleExtension h30 = _default.copyWithFunct(fontSize: 30.0, fontWeight: FontWeight.w700);

class TextStyleExtension extends TextStyle {
  const TextStyleExtension({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<ui.Shadow>? shadows,
    List<ui.FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
  }) : super(
          inherit: inherit ?? true,
          color: color,
          backgroundColor: backgroundColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
          textBaseline: textBaseline,
          height: height,
          locale: locale,
          foreground: foreground,
          background: background,
          shadows: shadows,
          fontFeatures: fontFeatures,
          decoration: decoration,
          decorationColor: decorationColor,
          decorationStyle: decorationStyle,
          decorationThickness: decorationThickness,
          debugLabel: debugLabel,
          fontFamily: package == null ? fontFamily : 'packages/$package/$fontFamily',
          fontFamilyFallback: fontFamilyFallback,
          package: package,
        );

  TextStyleExtension copyWithFunct({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<ui.Shadow>? shadows,
    List<ui.FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
  }) {
    return TextStyleExtension(
      inherit: inherit ?? this.inherit,
      color: this.foreground == null && foreground == null ? color ?? this.color : null,
      backgroundColor: this.background == null && background == null ? backgroundColor ?? this.backgroundColor : null,
      fontFamily: fontFamily ?? this.fontFamily,
      fontFamilyFallback: fontFamilyFallback ?? this.fontFamilyFallback,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      textBaseline: textBaseline ?? this.textBaseline,
      height: height ?? this.height,
      locale: locale ?? this.locale,
      foreground: foreground ?? this.foreground,
      background: background ?? this.background,
      shadows: shadows ?? this.shadows,
      fontFeatures: fontFeatures ?? this.fontFeatures,
      decoration: decoration ?? this.decoration,
      decorationColor: decorationColor ?? this.decorationColor,
      decorationStyle: decorationStyle ?? this.decorationStyle,
      decorationThickness: decorationThickness ?? this.decorationThickness,
      debugLabel: '(${this.debugLabel}).copyWithFunct',
    );
  }

  //weight
  get thin => copyWithFunct(fontWeight: FontWeight.w100);

  get extraLight => copyWithFunct(fontWeight: FontWeight.w200);

  get light => copyWithFunct(fontWeight: FontWeight.w300);

  get normal => copyWithFunct(fontWeight: FontWeight.w400);

  get medium => copyWithFunct(fontWeight: FontWeight.w500);

  get semiBold => copyWithFunct(fontWeight: FontWeight.w600);

  get bold => copyWithFunct(fontWeight: FontWeight.bold);

  get extraBold => copyWithFunct(fontWeight: FontWeight.w800);

  get thick => copyWithFunct(fontWeight: FontWeight.w900);

  get italic => copyWithFunct(fontStyle: FontStyle.italic, fontWeight: FontWeight.w500);

  //color
  get white => copyWithFunct(color: systemWhiteColor);

  get black => copyWithFunct(color: systemBlackColor);

  // get blackGrey => copyWithFunct(color: systemBlackGreyColor);

  get red => copyWithFunct(color: systemRedColor);

  // get darkRed => copyWithFunct(color: systemDarkerRedColor);

  // get lightBlue => copyWithFunct(color: systemLightBlueColor);

  // get blue => copyWithFunct(color: systemBlueColor);

  // get darkBlue => copyWithFunct(color: systemAccent900Color);

  // get mintGreen => copyWithFunct(color: systemMintGreenColor);

  // get green => copyWithFunct(color: systemGreenColor);

  // get darkGreen => copyWithFunct(color: systemDarkGreenColor);

  get primary => copyWithFunct(color: systemPrimaryColor);

  // get primary100 => copyWithFunct(color: systemPrimary100Color);

  // get primary500 => copyWithFunct(color: systemPrimary500Color);
  
  // get primary900 => copyWithFunct(color: systemPrimary900Color);

  // get primary1000 => copyWithFunct(color: systemPrimary1000Color);

  get accent => copyWithFunct(color: systemAccentColor);

  // get accentDarkest => copyWithFunct(color: systemAccent900Color);

  // get accentLightest => copyWithFunct(color: systemAccent50Color);

  get grey => copyWithFunct(color: systemGreyColor);

  // get darkerGrey => copyWithFunct(color: systemDarkerGreyColor);

  // get lightGrey => copyWithFunct(color: systemLightGreyColor);

  get yellow => copyWithFunct(color: systemYellowColor);

  get orange => copyWithFunct(color: systemOrangeColor);
  
  // get gold => copyWithFunct(color: systemGoldColor);

  // get darkestGrey => copyWithFunct(color: systemDarkestGreyColor);
}
