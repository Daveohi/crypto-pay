import 'package:flutter/material.dart';

import '../../core/values/styles/text_styles.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final bool multiText;
  final TextAlign? textAlign;
  final TextOverflow overflow;
  final Color? color;
  final bool centered;
  final int? maxLines;
  final double? fontSize;
  final FontStyle? fontStyle;

  /// biggest text
  ///
  /// fontSize `32`
  /// fontWeight `700`
  AppText.heading1(
    this.text, {
    super.key,
    this.multiText = true,
    this.overflow = TextOverflow.ellipsis,
    this.centered = false,
    this.color,
    this.maxLines,
    this.textAlign,
    this.fontSize,
    this.fontStyle,
  }) : style = headingStyle1.copyWith(color: color);

  /// h2 text
  ///
  /// fontSize `30`
  /// fontWeight `700`
  AppText.heading2(
    this.text, {
    super.key,
    this.multiText = true,
    this.overflow = TextOverflow.ellipsis,
    this.color,
    this.maxLines,
    this.centered = false,
    this.textAlign,
    this.fontSize,
    this.fontStyle,
  }) : style = headingStyle2.copyWith(color: color);

  /// h3 text
  ///
  /// fontSize `24`
  /// fontWeight `700`
  AppText.heading3(
    this.text, {
    super.key,
    this.multiText = true,
    this.overflow = TextOverflow.ellipsis,
    this.color,
    this.maxLines,
    this.centered = false,
    this.textAlign,
    this.fontSize,
    this.fontStyle,
  }) : style = headingStyle3.copyWith(color: color);

  /// h4text
  ///
  /// fontSize `22`
  /// fontWeight `700`
  AppText.heading4(
    this.text, {
    super.key,
    this.multiText = true,
    this.overflow = TextOverflow.ellipsis,
    this.color,
    this.maxLines,
    this.centered = false,
    this.textAlign,
    this.fontSize,
    this.fontStyle,
  }) : style = headingStyle4.copyWith(
          color: color,
          fontSize: fontSize,
        );

  /// h5 text
  ///
  /// fontSize `16`
  /// fontWeight `500`
  AppText.heading5(
    this.text, {
    super.key,
    this.multiText = true,
    this.overflow = TextOverflow.ellipsis,
    this.color,
    this.maxLines,
    this.centered = false,
    this.textAlign,
    this.fontSize,
    this.fontStyle,
  }) : style = headingStyle5.copyWith(color: color, fontSize: fontSize);

  /// h6 text
  ///
  /// fontSize `14`
  /// fontWeight `500`
  AppText.heading6(
    this.text, {
    super.key,
    this.multiText = true,
    this.overflow = TextOverflow.ellipsis,
    this.color,
    this.maxLines,
    this.centered = false,
    this.textAlign,
    this.fontSize,
    this.fontStyle,
  }) : style = headingStyle6.copyWith(color: color);

  /// normal body text
  ///
  /// fontSize `14`
  /// fontWeight `400`
  AppText.body1(
    this.text, {
    super.key,
    this.multiText = true,
    this.overflow = TextOverflow.ellipsis,
    this.color,
    this.maxLines,
    double? height,
    this.centered = false,
    this.textAlign,
    this.fontSize,
    this.fontStyle,
  }) : style = bodyStyle1.copyWith(
          color: color,
          height: height,
          fontSize: fontSize,
        );

  /// small body text
  ///
  /// fontSize `12`
  /// fontWeight `400`
  AppText.body2(
    this.text, {
    super.key,
    this.multiText = true,
    this.overflow = TextOverflow.ellipsis,
    this.color,
    this.maxLines,
    double? height,
    this.centered = false,
    this.textAlign,
    this.fontSize,
    this.fontStyle,
  }) : style = bodyStyle2.copyWith(color: color, height: height);

  /// caption text
  ///
  /// fontSize `10`
  /// fontWeight `400`
  AppText.caption(
    this.text, {
    super.key,
    this.multiText = true,
    this.overflow = TextOverflow.ellipsis,
    this.color,
    this.maxLines,
    this.centered = false,
    this.textAlign,
    this.fontSize,
    this.fontStyle,
  }) : style = captionStyle.copyWith(color: color);

  /// button text
  ///
  /// fontSize `18`
  /// fontWeight `700`
  AppText.button(
    this.text, {
    super.key,
    this.multiText = true,
    this.overflow = TextOverflow.ellipsis,
    this.color,
    this.maxLines,
    this.centered = false,
    this.textAlign,
    this.fontSize,
    this.fontStyle,
  }) : style = buttonStyle.copyWith(color: color);

  /// smallest text
  ///
  /// fontSize `8`
  /// fontWeight `400`
  AppText.small(
    this.text, {
    super.key,
    this.multiText = true,
    this.overflow = TextOverflow.ellipsis,
    this.color,
    this.maxLines,
    this.centered = false,
    this.textAlign,
    this.fontSize,
    this.fontStyle,
  }) : style = small.copyWith(color: color);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: multiText || maxLines != null ? maxLines ?? 9999999999 : 1,
      overflow: overflow,
      textAlign: centered ? TextAlign.center : textAlign ?? TextAlign.left,
      style: style.copyWith(
          color: color ?? Theme.of(context).textTheme.titleMedium!.color!),
    );
  }
}
