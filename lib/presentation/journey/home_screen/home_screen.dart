import 'package:ecommerce_poc/logic/load_orders/load_orders_cubit.dart';
import 'package:ecommerce_poc/presentation/components/app_text.dart';
import 'package:ecommerce_poc/presentation/journey/home_screen/section_quick_insight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../widgets/main_app_bar.dart';
import '../../widgets/section_title.dart';
import 'section_insight_details.dart';
import 'section_order_summary.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    /// columnAlignment
    CrossAxisAlignment? columnAlignment = ResponsiveValue(
      context,
      defaultValue: CrossAxisAlignment.start,
      valueWhen: [
        const Condition.equals(name: MOBILE, value: CrossAxisAlignment.start),
        const Condition.equals(name: TABLET, value: CrossAxisAlignment.center),
        const Condition.equals(name: DESKTOP, value: CrossAxisAlignment.center),
        const Condition.equals(name: "XL", value: CrossAxisAlignment.center),
      ],
    ).value;

    /// sectionsVerticalSpacing
    double? sectionsVerticalSpacing = ResponsiveValue(
      context,
      defaultValue: 20.0,
      valueWhen: [
        const Condition.equals(name: MOBILE, value: 20.0),
        const Condition.equals(name: TABLET, value: 20.0),
        const Condition.equals(name: DESKTOP, value: 30.0),
        const Condition.equals(name: "XL", value: 30.0),
      ],
    ).value;

    return Scaffold(
      appBar: mainAppBar(
        context,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.header("Good Morning Ahmed"),
            AppText.subtitle("Control your finances easily"),
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: const Icon(
              Icons.notifications_none_outlined,
              size: 20,
              color: Color(0xFF4F4F4F),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: const Icon(
              Icons.mail,
              size: 20,
              color: Color(0xFF4F4F4F),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<LoadOrdersCubit, LoadOrdersState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: columnAlignment ?? CrossAxisAlignment.start,
                children: [
                  ///
                  ///
                  /// Quick Insights Section
                  const SectionTitle(text: "Quick Insights"),
                  QuickInsightsSection(
                    orderInsights: state.orderInsights,
                  ),

                  /// Vertical Space
                  SizedBox(height: sectionsVerticalSpacing ?? 20),

                  ///
                  ///
                  /// Insights Details Section
                  const SectionTitle(text: "Insights Details"),
                  InsightDetailsSection(
                    orderInsights: state.orderInsights,
                  ),

                  /// Vertical Space
                  SizedBox(height: sectionsVerticalSpacing ?? 20),

                  ///
                  ///
                  /// Order Summary Section
                  const SectionTitle(text: "Order Summary"),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: const ViewOrderSummarySection(),
                  ),

                  const Row(),

                  /// Vertical Space
                  SizedBox(height: sectionsVerticalSpacing ?? 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
