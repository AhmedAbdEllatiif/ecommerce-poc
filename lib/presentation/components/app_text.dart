import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../resources/app_colors.dart';

/// text types
enum TextType { header, title, subtitle, caption }

class AppText extends StatefulWidget {
  final TextType textType;
  final String text;
  final Color? color;
  final FontWeight? fontWeight;

  const AppText({
    super.key,
    required this.textType,
    required this.text,
    this.color,
    this.fontWeight,
  });

  const AppText.header(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textType = TextType.header,
  });

  const AppText.title(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textType = TextType.title,
  });

  const AppText.subtitle(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textType = TextType.subtitle,
  });

  const AppText.caption(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textType = TextType.caption,
  });

  @override
  State<AppText> createState() => _AppTextState();
}

class _AppTextState extends State<AppText> {
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      widget.text,
      overflow: TextOverflow.fade,
      style: style(context),
    );
  }

  ///
  ///
  /// Build text style
  TextStyle style(BuildContext context) {
    switch (widget.textType) {
      // header
      case TextType.header:
        return TextStyle(
          fontSize: headerSize(context) ?? 18.0,
          fontWeight: widget.fontWeight ?? FontWeight.bold,
          color: widget.color ?? AppColors.textNeutralHeader,
        );

      // title
      case TextType.title:
        return TextStyle(
          fontSize: titleSize(context) ?? 18.0,
          fontWeight: widget.fontWeight ?? FontWeight.bold,
          color: widget.color ?? AppColors.textNeutralTitle,
        );

      // subTitle
      case TextType.subtitle:
        return TextStyle(
          fontSize: subTitleSize(context) ?? 14,
          fontWeight: widget.fontWeight ?? FontWeight.normal,
          color: widget.color ?? AppColors.textNeutralSubTitle,
        );

      // caption
      case TextType.caption:
        return TextStyle(
          fontSize: captionSize(context) ?? 12,
          fontWeight: widget.fontWeight ?? FontWeight.normal,
          color: widget.color ?? AppColors.textNeutralSubTitle,
        );
    }
  }

  /// headerSize
  double? headerSize(context) => ResponsiveValue(
        context,
        defaultValue: 20.0,
        valueWhen: [
          const Condition.equals(name: MOBILE, value: 20.0),
          const Condition.equals(name: TABLET, value: 20.0),
          const Condition.equals(name: DESKTOP, value: 25.0),
          const Condition.equals(name: "XL", value: 25.0),
        ],
      ).value;

  /// titleSize
  double? titleSize(context) => ResponsiveValue(
        context,
        defaultValue: 18.0,
        valueWhen: [
          const Condition.equals(name: MOBILE, value: 18.0),
          const Condition.equals(name: TABLET, value: 18.0),
          const Condition.equals(name: DESKTOP, value: 22.0),
          const Condition.equals(name: "XL", value: 22.0),
        ],
      ).value;

  /// subTitleSize
  double? subTitleSize(context) => ResponsiveValue(
        context,
        defaultValue: 14.0,
        valueWhen: [
          const Condition.equals(name: MOBILE, value: 14.0),
          const Condition.equals(name: TABLET, value: 14.0),
          const Condition.equals(name: DESKTOP, value: 16.0),
          const Condition.equals(name: "XL", value: 16.0),
        ],
      ).value;

  /// captionSiz
  double? captionSize(context) => ResponsiveValue(
        context,
        defaultValue: 12.0,
        valueWhen: [
          const Condition.equals(name: MOBILE, value: 12.0),
          const Condition.equals(name: TABLET, value: 12.0),
          const Condition.equals(name: DESKTOP, value: 13.0),
          const Condition.equals(name: "XL", value: 13.0),
        ],
      ).value;
}
