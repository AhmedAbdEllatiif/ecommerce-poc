import 'package:ecommerce_poc/domain/entities/order_insight_entity.dart';
import 'package:flutter/material.dart';

import 'order_graph_insight_item.dart';

class GraphInsightsSection extends StatelessWidget {
  final OrdersInsights insights;

  const GraphInsightsSection({super.key, required this.insights});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      spacing: 18,
      runSpacing: 8,
      children: [

        /// all time
        OrderGraphInsightItem(
          title: "All Time",
          value: "${insights.months.length} Months",
          icon: Icons.timeline_rounded,
          color: Colors.purple,
        ),

        /// orders count
        OrderGraphInsightItem(
          title: "Orders Count",
          value: "${insights.ordersCount} Orders",
          icon: Icons.shopping_cart_outlined,
          color: Colors.purple,
        ),

        /// best month
        OrderGraphInsightItem(
          title: "Best Month",
          value: "${insights.hstNumOrders} Orders",
          icon: Icons.local_fire_department,
          color: Colors.purple,
        ),

        /// least month
        OrderGraphInsightItem(
          title: "Least Month",
          value: "${insights.lstNumOrders} Orders",
          icon: Icons.keyboard_double_arrow_down_sharp,
          color: Colors.purple,
        ),
        //
      ],
    );
  }
}
