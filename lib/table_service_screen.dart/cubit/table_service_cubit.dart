import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:table_service/data/models/service_table.dart';
import 'package:table_service/services/table_service_repository.dart';

part 'table_service_state.dart';

class TableServiceCubit extends Cubit<TableServiceState> {
  TableServiceCubit({required TableServiceRepository tableServiceRepository})
      : _tableServiceRepository = tableServiceRepository,
        super(TableServiceInitial());

  final TableServiceRepository _tableServiceRepository;

  void loadData() async {
    emit(TableServiceLoading());
    try {
      final tables = await _tableServiceRepository.getAllTables();
      if (tables == null) {
        emit(TableServiceNoData());
      } else {
        emit(TableServiceDataLoaded(tables));
      }
    } catch (e) {
      emit(TableServiceError(e.toString()));
    }
  }
}
