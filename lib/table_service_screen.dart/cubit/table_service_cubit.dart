import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_service/data/models/order.dart';
import 'package:table_service/data/models/service_table.dart';
import 'package:table_service/services/locator.dart';
import 'package:table_service/services/table_service_repository.dart';
import 'package:table_service/table_details_screen/cubit/table_details_cubit.dart';
import 'package:table_service/table_details_screen/table_details_screen.dart';

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

  void navigateToDetails(
      BuildContext context, ServiceTable table, Order? order) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => TableDetailsCubit(
            tableServiceRepository: locator<TableServiceRepository>()),
        child: TableDetailsScreen(
          table: table,
          order: order,
        ),
      ),
    ));
    emit(TableServiceInitial());
  }
}
