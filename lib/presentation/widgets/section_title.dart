import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../components/app_text.dart';


class SectionTitle extends StatefulWidget {
  final String text;

  const SectionTitle({super.key, required this.text});

  @override
  State<SectionTitle> createState() => _SectionTitleState();
}

class _SectionTitleState extends State<SectionTitle> {
  @override
  Widget build(BuildContext context) {
    // Determine alignment based on breakpoint
    double? verticalSpace = ResponsiveValue(
      context,
      defaultValue: 6.0,
      valueWhen: [
        const Condition.equals(name: MOBILE, value: 6.0),
        const Condition.equals(name: TABLET, value: 8.0),
        const Condition.equals(name: DESKTOP, value: 10.0),
      ],
    ).value;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.title(
          widget.text,
        ),

        /// vertical space
        SizedBox(height: verticalSpace ?? 6.0),
      ],
    );
  }
}
