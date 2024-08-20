part of 'table_service_cubit.dart';

@immutable
sealed class TableServiceState {}

final class TableServiceInitial extends TableServiceState {}

final class TableServiceDataLoaded extends TableServiceState {
  final List<ServiceTable> tables;
  TableServiceDataLoaded(this.tables);
}

final class TableServiceNoData extends TableServiceState {}

final class TableServiceLoading extends TableServiceState {}

final class TableServiceError extends TableServiceState {
  final String? message;
  TableServiceError(this.message);
}
