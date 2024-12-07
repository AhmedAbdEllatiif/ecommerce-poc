import 'package:flutter/material.dart';

import '../../../domain/entities/order_insight_entity.dart';
import '../../widgets/quick_insight_item.dart';

class QuickInsightsSection extends StatelessWidget {
  final OrdersInsights orderInsights;

  const QuickInsightsSection({super.key, required this.orderInsights});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1000),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: QuickInsightItem(
              title: "Total Orders",
              iconData: Icons.add_shopping_cart,
              value: "${orderInsights.ordersCount}",
              isProfitable: false,
            ),
          ),
          Expanded(
            child: QuickInsightItem(
              title: "Average Price",
              iconData: Icons.attach_money_rounded,
              value: orderInsights.avgPrice.toStringAsFixed(2),
              isProfitable: true,
            ),
          ),
          Expanded(
            child: QuickInsightItem(
              title: "Returns",
              iconData: Icons.remove_shopping_cart_outlined,
              value: "${orderInsights.returnsCount}",
              isProfitable: false,
            ),
          ),
        ],
      ),
    );
  }
}
