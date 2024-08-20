part of 'table_details_cubit.dart';

@immutable
sealed class TableDetailsState {}

final class TableDetailsInitial extends TableDetailsState {}

final class TableDetailsLoaded extends TableDetailsState {
  final List<OrderItem> orderItems;
  TableDetailsLoaded(this.orderItems);
}

final class TableDetailsLoading extends TableDetailsState {}

final class TableDetailsError extends TableDetailsState {
  final String? message;

  TableDetailsError(this.message);
}
