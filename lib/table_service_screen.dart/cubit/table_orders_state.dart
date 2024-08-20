part of 'table_orders_cubit.dart';

@immutable
sealed class TableOrdersState {
  final Color tableColor;
  const TableOrdersState(this.tableColor);
}

final class TableOrdersInitial extends TableOrdersState {
  const TableOrdersInitial() : super(Colors.green);
}

final class TableOrdersLoaded extends TableOrdersState {
  final Order orderItem;
  const TableOrdersLoaded(this.orderItem, super.tableColor);
}

final class NoTableOrders extends TableOrdersState {
  const NoTableOrders() : super(Colors.green);
}

final class TableOrdersError extends TableOrdersState {
  final String? message;

  const TableOrdersError(this.message, super.tableColor);
}
