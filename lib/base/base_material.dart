import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import '../presentation/resources/app_colors.dart';
import '../logic/load_orders/load_orders_cubit.dart';
import '../presentation/journey/home_screen/home_screen.dart';

class BaseMaterialApp extends StatefulWidget {
  const BaseMaterialApp({super.key});

  @override
  State<BaseMaterialApp> createState() => _BaseMaterialAppState();
}

class _BaseMaterialAppState extends State<BaseMaterialApp> {
  late final LoadOrdersCubit loadOrdersCubit;

  @override
  void initState() {
    super.initState();
    loadOrdersCubit = LoadOrdersCubit();
    loadOrdersCubit.loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      /// title
      title: 'Order Insights',

      /// responsive break points
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        maxWidth: 1700,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.autoScale(220, name: "S"),
          const ResponsiveBreakpoint.resize(350, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(600, name: TABLET),
          const ResponsiveBreakpoint.resize(800, name: DESKTOP),
          const ResponsiveBreakpoint.resize(1700, name: 'XL'),
        ],
      ),

      /// app theme
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.surfaceNeutralBase,

        //==> appBarTheme
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.surfaceNeutralBase,
          iconTheme: IconThemeData(color: AppColors.iconNeutralDefault),
          actionsIconTheme: IconThemeData(color: AppColors.iconNeutralDefault),
        ),
      ),

      /// home
      home: BlocProvider.value(
        value: loadOrdersCubit,
        child: const HomeScreen(),
      ),
    );
  }
}
