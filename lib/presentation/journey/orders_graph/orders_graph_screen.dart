import 'package:ecommerce_poc/logic/load_orders/load_orders_cubit.dart';
import 'package:ecommerce_poc/presentation/journey/orders_graph/section_graph_insights.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../../domain/entities/order_insight_entity.dart';
import '../../resources/app_colors.dart';
import '../../widgets/empty_container.dart';
import '../../widgets/outline_button.dart';
import '../../widgets/section_title.dart';

class OrdersGraph extends StatefulWidget {
  const OrdersGraph({super.key});

  @override
  State<OrdersGraph> createState() => _OrdersGraphState();
}

class _OrdersGraphState extends State<OrdersGraph> {
  /// LoadOrdersCubit
  late final LoadOrdersCubit loadOrdersCubit;

  /// bool to show avg value
  bool showAvg = false;

  @override
  void initState() {
    super.initState();
    loadOrdersCubit = LoadOrdersCubit();
    loadOrdersCubit.loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    // Determine alignment based on breakpoint
    // Determine alignment based on breakpoint
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

    // init isPortrait
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return BlocProvider(
      create: (context) => loadOrdersCubit,
      child: Scaffold(
        ///
        ///
        /// appBar
        appBar: AppBar(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "All time Orders",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textNeutralHeader),
              ),
            ],
          ),
        ),

        ///
        ///
        /// body
        body: SingleChildScrollView(
          child: BlocBuilder<LoadOrdersCubit, LoadOrdersState>(
            builder: (context, state) {
              ///
              ///
              /// orders fetched
              if (state is OrdersFetched) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment:
                          columnAlignment ?? CrossAxisAlignment.start,
                      children: [
                        EmptyContainer(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              /// change data button (Avg/All)
                              OutlineButton(
                                onPressed: () {
                                  setState(() {
                                    showAvg = !showAvg;
                                  });
                                },
                                text: showAvg ? 'Show All' : 'Show Average',
                                iconData: Icons.change_circle_outlined,
                              ),

                              /// vertical space
                              const SizedBox(height: 10),

                              /// graph
                              AspectRatio(
                                aspectRatio: isPortrait ? 1.50 : 5.00,
                                child: LineChart(
                                  chartData(
                                    insights: state.insights,
                                    isAvgData: showAvg,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// vertical space
                        SizedBox(height: sectionsVerticalSpacing ?? 16),

                        ///
                        ///
                        /// Graph Insights
                        const SectionTitle(text: "Insights"),
                        GraphInsightsSection(insights: state.insights),
                      ],
                    ),
                  ),
                );
              }

              /// other states to be handled
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  ///
  ///
  ///  build bottomTitles
  String bottomTitle({
    required OrdersInsights insights,
    required double value,
  }) {
    String text = "";

    for (var month in insights.months) {
      if (value.toInt() == insights.months.indexOf(month)) {
        text = month;
      }
    }

    return text;
  }

  ///
  ///
  ///  build left titles
  String leftTitle({
    required OrdersInsights insights,
    required double value,
  }) {
    String text;

    if (value.toInt() == insights.lstNumOrders) {
      text = insights.lstNumOrders.toString();
    } else if (value.toInt() == insights.avgNumOrder) {
      text = insights.avgNumOrder.toString();
    } else if (value.toInt() == insights.hstNumOrders) {
      text = insights.hstNumOrders.toString();
    } else {
      return "";
    }

    return text;
  }

  ///
  ///
  ///
  /// build chart data
  LineChartData chartData({
    required OrdersInsights insights,
    required bool isAvgData,
  }) {
    return LineChartData(
      minX: 0,
      maxX: insights.months.length.toDouble() - 1,
      minY: insights.lstNumOrders.toDouble() - 1,
      maxY: insights.hstNumOrders + 1,

      /// lineTouchData
      lineTouchData: LineTouchData(
        enabled: !isAvgData,
        touchTooltipData: LineTouchTooltipData(
            // tooltipBgColor: Colors.blueAccent, // Set the background color for the tooltip
            tooltipRoundedRadius: 8,
            // Optional: Adjust the tooltip corner radius
            tooltipPadding: const EdgeInsets.all(8),
            // Optional: Customize padding
            tooltipMargin: 10,
            // Optional: Set margin between tooltip and the chart
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((LineBarSpot spot) {
                return LineTooltipItem(
                  '${spot.y}', // Text to display
                  const TextStyle(
                    color: AppColors.textNeutralTitle, // Set text color
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            },
            getTooltipColor: (_) {
              return AppColors.surfaceNeutralBase;
            }),
      ),

      ///
      /// gridData
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(color: Colors.transparent);
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(color: Colors.transparent);
        },
      ),

      /// titles
      titlesData: FlTitlesData(
        show: true,
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),

        //==> bottom titles
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (double value, TitleMeta meta) => SideTitleWidget(
              axisSide: meta.axisSide,
              angle: 31,
              child: Text(
                bottomTitle(insights: insights, value: value),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: AppColors.textNeutralTitle,
                ),
              ),
            ),
          ),
        ),

        //==> left titles
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 25,
            interval: 1,
            getTitlesWidget: (double value, TitleMeta meta) => SideTitleWidget(
              axisSide: meta.axisSide,
              child: Text(
                leftTitle(insights: insights, value: value),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: AppColors.textNeutralTitle,
                ),
              ),
            ),
          ),
        ),
      ),

      ///
      /// border
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.purpleAccent.withOpacity(.3)),
      ),

      /// line bars
      lineBarsData: [
        isAvgData
            ? LineChartBarData(
                spots: insights.ordersPerMonth.entries
                    .map((e) => FlSpot(
                        insights.ordersPerMonth.keys
                            .toList()
                            .indexOf(e.key)
                            .toDouble(),
                        insights.avgNumOrder.toDouble()))
                    .toList(),
                isCurved: true,
                gradient: LinearGradient(
                  colors: [
                    ColorTween(
                            begin: AppColors.graphGradientColors[0],
                            end: AppColors.graphGradientColors[1])
                        .lerp(0.2)!,
                    ColorTween(
                            begin: AppColors.graphGradientColors[0],
                            end: AppColors.graphGradientColors[1])
                        .lerp(0.2)!,
                  ],
                ),
                barWidth: 5,
                isStrokeCapRound: true,
                dotData: const FlDotData(
                  show: false,
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      ColorTween(
                              begin: AppColors.graphGradientColors[0],
                              end: AppColors.graphGradientColors[1])
                          .lerp(0.2)!
                          .withOpacity(0.1),
                      ColorTween(
                              begin: AppColors.graphGradientColors[0],
                              end: AppColors.graphGradientColors[1])
                          .lerp(0.2)!
                          .withOpacity(0.1),
                    ],
                  ),
                ),
              )
            : LineChartBarData(
                isStrokeCapRound: true,
                show: true,
                isCurved: true,
                barWidth: 5,
                spots: insights.ordersPerMonth.entries
                    .map((e) => FlSpot(
                        insights.ordersPerMonth.keys
                            .toList()
                            .indexOf(e.key)
                            .toDouble(),
                        e.value.toDouble()))
                    .toList(),
                gradient: LinearGradient(
                  colors: AppColors.graphGradientColors,
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: AppColors.graphGradientColors
                        .map((color) => color.withOpacity(0.3))
                        .toList(),
                  ),
                ),
              ),
      ],
    );
  }
}
