import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_icon.dart';
import '../../widgets/empty_container.dart';

class OrderGraphInsightItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final bool isCircular;

  const OrderGraphInsightItem({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyContainer(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///
          /// title
          Container(
            constraints: const BoxConstraints(maxWidth: 100),
            child: AutoSizeText(
              title,
              overflow: TextOverflow.fade,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),

          /// vertical space
          const SizedBox(height: 8),

          /// vale and icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              //==> icon
              AppIcon(iconData: icon),

              //==> horizontal space
              const SizedBox(width: 8),

              //==> value text
              Container(
                constraints: const BoxConstraints(maxWidth: 100),
                child: AutoSizeText(
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
