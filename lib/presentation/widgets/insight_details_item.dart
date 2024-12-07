import 'package:flutter/material.dart';

import '../components/app_text.dart';
import 'app_icon.dart';


class InsightDetailsItem extends StatefulWidget {
  final String title;
  final String currentValue;
  final String lastWeekValue;
  final String growth;
  final bool isProfitable;
  final IconData iconData;

  const InsightDetailsItem({
    super.key,
    required this.iconData,
    required this.title,
    required this.currentValue,
    required this.lastWeekValue,
    required this.growth,
    required this.isProfitable,
  });

  @override
  State<InsightDetailsItem> createState() => _InsightDetailsItemState();
}

class _InsightDetailsItemState extends State<InsightDetailsItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(

      ///
      /// leading
      leading: AppIcon(iconData: widget.iconData),

      ///
      /// title
      title: AppText.title(
        widget.title,
        fontWeight: FontWeight.w500,
      ),

      ///
      /// subtitle
      subtitle: AppText.caption(
        'Last Week: ${widget.lastWeekValue}',
      ),

      ///
      /// trailing
      trailing: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          // Align trailing content to the end
          children: [
            AppText.title(
              widget.currentValue,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.caption(
                  widget.growth,
                  color: widget.isProfitable ? Colors.green : Colors.red,
                ),
                Icon(
                  widget.isProfitable ? Icons.arrow_upward : Icons.arrow_downward,
                  color: widget.isProfitable ? Colors.green : Colors.red,
                  size: 14,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
