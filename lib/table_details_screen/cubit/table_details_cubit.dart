import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:table_service/data/models/order_item.dart';
import 'package:table_service/services/table_service_repository.dart';

part 'table_details_state.dart';

class TableDetailsCubit extends Cubit<TableDetailsState> {
  TableDetailsCubit({required TableServiceRepository tableServiceRepository})
      : _tableServiceRepository = tableServiceRepository,
        super(TableDetailsInitial());

  final TableServiceRepository _tableServiceRepository;

  void loadOrderItems(String orderId) async {
    emit(TableDetailsLoading());
    try {
      final orderItems =
          await _tableServiceRepository.getTableOpenedOrderItems(orderId);
      if (orderItems != null) {
        emit(TableDetailsLoaded(orderItems));
      }
    } catch (e) {
      TableDetailsError(e.toString());
    }
  }
}
