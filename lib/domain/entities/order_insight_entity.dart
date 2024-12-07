import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

Future<OrdersInsights> buildOrderInsights() async {
  final List<double> prices = [];
  final List<String> months = [];
  final Map<String, double> pricePerMonth = {};
  final Map<String, double> ordersPerMonth = {};
  int ordersCount = 0;
  double highestPrice = double.negativeInfinity;
  double lowestPrice = double.infinity;
  double avgPrice = double.infinity;
  int highestNumOrder = -1;
  int lowestNumOrder = -1;
  int averageNumOrder = -1;
  int returnsCount = 0;

  // load the file
  final String response = await rootBundle.loadString('assets/orders.json');

  // decode the file
  final List<dynamic> orders = json.decode(response);

  for (var order in orders) {
    final double price = priceFromString(order["price"]);
    prices.add(price);

    // Parse the date and group by month
    final month = monthFromDate(order['registered']);
    if (!months.contains(month)) {
      months.add(month);
    }

    pricePerMonth.update(month, (pricePerMonth) => pricePerMonth + price,
        ifAbsent: () => price);

    ordersPerMonth.update(month, (count) => count + 1, ifAbsent: () => 1);

    //==> increment returnsCount
    if(order['status'] == 'RETURNED'){
      returnsCount += 1;
    }
  }

  //==> init orders count
  ordersCount = orders.length;

  //==> init highest lowest prices
  final hlPrices = getHighestLowestAverage(prices);
  highestPrice = hlPrices[0];
  lowestPrice = hlPrices[1];
  avgPrice = hlPrices[2];

  //==> init highest lowest prices
  final ordersCountsPerMonth =
      getHighestLowestAverage(ordersPerMonth.values.toList());
  highestNumOrder = ordersCountsPerMonth[0].toInt();
  lowestNumOrder = ordersCountsPerMonth[1].toInt();
  averageNumOrder = ordersCountsPerMonth[2].toInt();

  //==> re-arrange months
  final arrangedMonth = arrangedDates(months);


  // return OrderInsights
  return OrdersInsights(
    hstPrice: highestPrice,
    lstPrice: lowestPrice,
    avgPrice: avgPrice,
    hstNumOrders: highestNumOrder,
    lstNumOrders: lowestNumOrder,
    avgNumOrder: averageNumOrder,
    ordersCount: ordersCount,
    returnsCount: returnsCount,
    prices: prices,
    months: arrangedMonth,
    pricePerMonth: pricePerMonth,
    ordersPerMonth: ordersPerMonth,
  );
}

///
///
/// extract the month form the date
/// ex: Sep from "2021-09-19T01:41:06 -02:00"
String monthFromDate(String? date) {
  if (date == null) return "";

  // Parse the date and group by month
  DateTime? registeredDate = DateTime.tryParse(date);
  if (registeredDate == null) return "";

  //return registeredDate.month.toString().padLeft(2, '0');
  return DateFormat('MMM').format(registeredDate);
}

///
///
/// build price as double for string
/// ex: 122.03 from $122,03
double priceFromString(String? strPrice) {
  //  return -1 if null
  if (strPrice == null) return -1;

  // remove ',' and '$' form the price
  final String rawStrPrice = strPrice.replaceAll(',', '').replaceAll('\$', '');

  // convert to double
  final double price = double.tryParse(rawStrPrice) ?? -1;

  return price;
}

///
///
///  return a list of double
///  highest and lowest prices
List<double> getHighestLowestAverage(List<double> prices) {
  double hPrice = double.negativeInfinity;
  double lPrice = double.infinity;
  for (var price in prices) {
    if (price > hPrice) hPrice = price;
    if (price < lPrice) lPrice = price;
  }
  double sum = prices.reduce((a, b) => a + b);
  final average = sum / prices.length;

  return [hPrice, lPrice, average];
}


/// Re-arrange the dates
List<String> arrangedDates(List<String> unArrangedDates) {
  // Custom order for months
  List<String> orderedDates = [
    "Jun",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jan",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  // sort
  unArrangedDates.sort((a, b) {
    int indexA = orderedDates.indexOf(a);
    int indexB = orderedDates.indexOf(b);
    return indexA.compareTo(indexB);
  });

  return unArrangedDates;
}

class OrdersInsights {
  final double hstPrice;
  final double lstPrice;
  final double avgPrice;
  final int hstNumOrders;
  final int lstNumOrders;
  final int avgNumOrder;
  final int ordersCount;
  final int returnsCount;
  final List<double> prices;
  final List<String> months;
  final Map<String, double> pricePerMonth;
  final Map<String, double> ordersPerMonth;

  const OrdersInsights({
    required this.hstPrice,
    required this.lstPrice,
    required this.avgPrice,
    required this.hstNumOrders,
    required this.lstNumOrders,
    required this.avgNumOrder,
    required this.ordersCount,
    required this.returnsCount,
    required this.prices,
    required this.months,
    required this.pricePerMonth,
    required this.ordersPerMonth,
  });

  factory OrdersInsights.empty() => const OrdersInsights(
        hstPrice: -1,
        lstPrice: -1,
        avgPrice: -1,
        hstNumOrders: -1,
        lstNumOrders: -1,
        avgNumOrder: -1,
        ordersCount: -1,
        returnsCount: -1,
        prices: [],
        months: [],
        pricePerMonth: {},
        ordersPerMonth: {},
      );
}
