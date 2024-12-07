import 'package:ecommerce_poc/domain/entities/order_insight_entity.dart';
import 'package:flutter/material.dart';

import '../../widgets/empty_container.dart';
import '../../widgets/insight_details_item.dart';

class InsightDetailsSection extends StatelessWidget {
  final OrdersInsights orderInsights;

  const InsightDetailsSection({super.key, required this.orderInsights});

  @override
  Widget build(BuildContext context) {
    return EmptyContainer(
      constraints: const BoxConstraints(maxWidth: 1000),
      child: Column(
        children: [
          ///
          ///
          /// Total Orders
          InsightDetailsItem(
            iconData: Icons.add_shopping_cart,
            title: "Total Orders",
            lastWeekValue: "110",
            currentValue: "${orderInsights.ordersCount}",
            growth: '10',
            isProfitable: false,
          ),

          ///
          ///
          /// Average Price
          InsightDetailsItem(
            iconData: Icons.attach_money_rounded,
            title: "Average Price",
            lastWeekValue: "2000",
            currentValue: "\$${orderInsights.avgPrice.toStringAsFixed(2)}",
            growth: '600',
            isProfitable: true,
          ),

          ///
          ///
          /// Total Returns
          InsightDetailsItem(
            iconData: Icons.remove_shopping_cart_outlined,
            title: "Total Returns",
            lastWeekValue: "25",
            currentValue: "${orderInsights.returnsCount}",
            growth: '15',
            isProfitable: false,
          ),
        ],
      ),
    );
  }
}
