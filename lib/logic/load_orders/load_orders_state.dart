part of 'load_orders_cubit.dart';

sealed class LoadOrdersState extends Equatable {
  final OrdersInsights orderInsights;

  const LoadOrdersState({required this.orderInsights});

  @override
  List<Object> get props => [];
}

/// loading
final class LoadOrdersInitial extends LoadOrdersState {
  LoadOrdersInitial() : super(orderInsights: OrdersInsights.empty());
}

/// success
final class OrdersFetched extends LoadOrdersState {
  final OrdersInsights insights;

  const OrdersFetched({
    required this.insights,
  }) : super(orderInsights: insights);

  @override
  List<Object> get props => [insights];
}

/// error
final class ErrorWhileLoadingOrders extends LoadOrdersState {
  ErrorWhileLoadingOrders() : super(orderInsights: OrdersInsights.empty());
}
