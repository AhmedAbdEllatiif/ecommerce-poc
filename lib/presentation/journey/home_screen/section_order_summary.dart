import 'package:ecommerce_poc/presentation/components/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../orders_graph/orders_graph_screen.dart';
import '../../widgets/empty_container.dart';

class ViewOrderSummarySection extends StatelessWidget {
  const ViewOrderSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyContainer(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OrdersGraph()),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// title
            const AppText.title("View Orders Summary?"),

            /// subTitle
            const AppText.subtitle("Track current orders VS time!"),

            ///
            ///
            /// Vertical Space
            const SizedBox(height: 16),

            ///
            ///
            /// View Graph btn
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        "View Graph",
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 16,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.purple,
                        size: 20,
                      ),
                    ],
                  ),
                ),

                /// spacer
                const Spacer(),

                /// graph svg image
                SvgPicture.asset(
                  "assets/images/graph.svg",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
