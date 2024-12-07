import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

AppBar mainAppBar(
  BuildContext context, {
  required Widget title,
  List<Widget> actions = const [],
}) {
  /// headerSize
  double? padding = ResponsiveValue(
    context,
    defaultValue: 2.0,
    valueWhen: [
      const Condition.equals(name: MOBILE, value: 2.0),
      const Condition.equals(name: TABLET, value: 2.0),
      const Condition.equals(name: DESKTOP, value: 10.0),
    ],
  ).value;

  /// headerSize
  double? toolBarHeight = ResponsiveValue(
    context,
    defaultValue: 50.0,
    valueWhen: [
      const Condition.equals(name: DESKTOP, value: 80.0),
      const Condition.equals(name: "XL", value: 80.0),
    ],
  ).value;


  return AppBar(
    /// title
    title: Container(
      padding: EdgeInsets.symmetric(vertical: padding ?? 2),
      child: title,
    ),

    /// height
    toolbarHeight: toolBarHeight,

    /// actions
    actions: actions
        .map((action) => Padding(
              padding: EdgeInsets.symmetric(vertical: padding ?? 2),
              child: action,
            ))
        .toList(),
  );
}
