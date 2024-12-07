import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/order_insight_entity.dart';

part 'load_orders_state.dart';

class LoadOrdersCubit extends Cubit<LoadOrdersState> {
  LoadOrdersCubit() : super(LoadOrdersInitial());

  /// try to load orders
  void loadOrders() async {
    try {
      final OrdersInsights insights = await buildOrderInsights();
      _emitIfNotClosed(OrdersFetched(insights: insights));
    } catch (e) {
      _emitIfNotClosed(ErrorWhileLoadingOrders());
    }
  }

  /// emit if not close
  void _emitIfNotClosed(LoadOrdersState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
