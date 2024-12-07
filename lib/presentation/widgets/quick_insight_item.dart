import 'package:flutter/material.dart';

import '../components/app_text.dart';
import 'app_icon.dart';
import 'empty_container.dart';

class QuickInsightItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData iconData;
  final bool isProfitable;

  const QuickInsightItem({
    super.key,
    required this.title,
    required this.value,
    required this.isProfitable,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyContainer(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// icon
          AppIcon(iconData: iconData),

          /// vertical space
          const SizedBox(height: 10),

          /// data
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 5),
                child: AppText.title(
                  value,
                  color: isProfitable ? Colors.green : Colors.red,
                ),
              ),

              /// arrow
              Icon(
                isProfitable ? Icons.arrow_upward : Icons.arrow_downward,
                color: isProfitable ? Colors.green : Colors.red,
                size: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
