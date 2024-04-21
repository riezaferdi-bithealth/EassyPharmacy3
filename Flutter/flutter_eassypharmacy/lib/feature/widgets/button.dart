import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter/material.dart';

enum ButtonSize { small, large, medium }

class GeneralButton extends StatelessWidget {
  final Widget child;
  final bool enable;
  final VoidCallback? onPressed;
  final double circular;
  final ButtonSize buttonSize;
  final bool onlyBorder;
  final bool reverse;
  final Color primaryColor;
  final Color accentColor;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final bool? isBorderWidth;

  GeneralButton._(
      {required this.child,
      this.circular = 5.0,
      this.enable = true,
      this.onlyBorder = false,
      this.reverse = false,
      this.onPressed,
      ButtonSize? buttonSize,
      Color? primaryColor,
      Color? accentColor,
      this.width,
      this.height,
      EdgeInsets? padding,
      bool this.isBorderWidth = false})
      : buttonSize = buttonSize ?? ButtonSize.large,
        primaryColor = !reverse
            ? primaryColor ?? systemWhiteColor
            : accentColor ?? systemWhiteColor,
        accentColor = !reverse
            ? accentColor ?? systemWhiteColor
            : primaryColor ?? systemWhiteColor,
        padding = padding!;

  factory GeneralButton.text(String text,
      {double circular = 5.0,
      bool enable = true,
      bool onlyBorder = false,
      bool reverse = false,
      bool bold = false,
      VoidCallback? onPressed,
      ButtonSize? buttonSize,
      Color? backgroundColor,
      Color? textColor,
      double? width,
      double? height,
      EdgeInsets? padding,
      bool isBorderWidth = false}) {
    Color primaryColor = !reverse
        ? backgroundColor ?? systemWhiteColor
        : textColor ?? systemWhiteColor;
    Color accentColor = !reverse
        ? textColor ?? systemWhiteColor
        : backgroundColor ?? systemWhiteColor;
    double fontSize = buttonSize == ButtonSize.large
        ? 16.0
        : buttonSize == ButtonSize.medium
            ? 14.0
            : 12.0;
    FontWeight fontWeight = buttonSize == ButtonSize.large
        ? bold
            ? FontWeight.w700
            : FontWeight.w500
        : FontWeight.normal;
    Color? disableTextColor = Color.lerp(
        !reverse ? Colors.white : Colors.black54, systemWhiteColor, 0.6);
    Color? disableBackgroundColor = Color.lerp(
        reverse ? Colors.white : Colors.black54, systemWhiteColor, 0.6);
    Color textColorTwo = !onlyBorder ? accentColor : primaryColor;
    Color? disableTextColorTwo =
        !onlyBorder ? disableTextColor : disableBackgroundColor;
    TextStyle textStyle = TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: enable ? textColorTwo : disableTextColorTwo);

    return GeneralButton._(
        circular: circular,
        enable: enable,
        onlyBorder: onlyBorder,
        reverse: reverse,
        onPressed: onPressed,
        buttonSize: buttonSize,
        primaryColor: primaryColor,
        accentColor: accentColor,
        width: width,
        height: height,
        padding: padding,
        isBorderWidth: isBorderWidth,
        child: Text(text, style: textStyle));
  }

  factory GeneralButton.custom(
      {Widget? child,
      double circular = 5.0,
      bool enable = true,
      bool onlyBorder = false,
      bool reverse = false,
      bool bold = false,
      VoidCallback? onPressed,
      ButtonSize? buttonSize,
      Color? primaryColor,
      Color? accentColor,
      double? width,
      double? height,
      EdgeInsets? padding,
      bool isBorderWidth = false}) {
    return GeneralButton._(
        circular: circular,
        enable: enable,
        onlyBorder: onlyBorder,
        reverse: reverse,
        onPressed: onPressed,
        buttonSize: buttonSize,
        primaryColor: primaryColor,
        accentColor: accentColor,
        width: width,
        height: height,
        padding: padding,
        isBorderWidth: isBorderWidth,
        child: child!);
  }

  @override
  Widget build(BuildContext context) {
    return _buildButton(context);
  }

  Widget _buildButton(BuildContext context) {
    double borderWidth = isBorderWidth!
        ? onlyBorder
            ? 1.0
            : 0.0
        : 0.0;
    Color? disableBackgroundColor = Color.lerp(
        reverse ? Colors.white : Colors.black54, systemWhiteColor, 0.6);
    Color? disableTextColor = Color.lerp(
        !reverse ? Colors.white : Colors.black54, systemWhiteColor, 0.6);
    Color? transparentColor = Colors.transparent;

    OutlinedBorder border = RoundedRectangleBorder(
        side: BorderSide(
            color: enable
                ? isBorderWidth!
                    ? primaryColor
                    : transparentColor
                : disableBackgroundColor!,
            width: borderWidth),
        borderRadius: BorderRadius.circular(circular));

    Color color = onlyBorder ? accentColor : primaryColor;
    Color disableColor =
        onlyBorder ? disableTextColor! : disableBackgroundColor!;

    EdgeInsets finalPadding = padding;
    // ?? (buttonSize == ButtonSize.large
    //         ? EdgeInsets.all(14.0)
    //         : EdgeInsets.all(8.0));

    return ButtonTheme(
        minWidth: 0.0,
        height: 0.0,
        child: SizedBox(
            width: width,
            height: height,
            child: TextButton(
              style: ButtonStyle(
                //USING WHEN ONPRESS COLOR
                // overlayColor: MaterialStateProperty.resolveWith<Color>(
                //         (Set<MaterialState> states) {
                //       return primaryColor;
                //     }),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return color;
                }),
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Theme.of(context).dividerColor;
                  } else if (states.contains(MaterialState.hovered)) {
                    return Theme.of(context).dividerColor;
                  } else if (states.contains(MaterialState.disabled)) {
                    return disableColor;
                  }
                  return color;
                }),
                padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                    (Set<MaterialState> states) {
                  return finalPadding;
                }),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                    (Set<MaterialState>? states) {
                  return border;
                }),
              ),
              onPressed: enable
                  ? () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (onPressed != null) onPressed!();
                    }
                  : null,

              // padding: finalPadding,
              // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              // color: _color,
              // disabledColor: _disableColor,
              // disabledTextColor: _disableTextColor,
              // highlightColor: Theme.of(context).dividerColor,
              // splashColor: Theme.of(context).dividerColor,
              child: child,
              // shape: border,
            )));
  }
}
