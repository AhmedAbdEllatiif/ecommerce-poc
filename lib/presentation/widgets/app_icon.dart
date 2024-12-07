import 'package:ecommerce_poc/presentation/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';


class AppIcon extends StatelessWidget {
  final IconData iconData;

  const AppIcon({super.key, required this.iconData});

  @override
  Widget build(BuildContext context) {
    /// titleSize
    double? iconSize = ResponsiveValue(
      context,
      defaultValue: 20.0,
      valueWhen: [
        const Condition.equals(name: MOBILE, value: 20.0),
        const Condition.equals(name: TABLET, value: 20.0),
        const Condition.equals(name: DESKTOP, value: 25.0),
        const Condition.equals(name: "XL", value: 25.0),
      ],
    ).value;

    return Container(
      padding: EdgeInsets.all(iconSize != null ? iconSize / 2 : 10),
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: AppColors.surfaceNeutralBase),
      child: Icon(
        iconData,
        size: iconSize ?? 20,
        color: AppColors.iconNeutralDefault,
      ),
    );
  }
}
