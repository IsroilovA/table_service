import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:table_service/data/models/order.dart';
import 'package:table_service/services/table_service_repository.dart';

part 'table_orders_state.dart';

class TableOrdersCubit extends Cubit<TableOrdersState> {
  TableOrdersCubit({required TableServiceRepository tableServiceRepository})
      : _tableServiceRepository = tableServiceRepository,
        super(const TableOrdersInitial());

  final TableServiceRepository _tableServiceRepository;

  Order? orderItem;
  void loadTableOpenedOrder(String id) async {
    try {
      orderItem = await _tableServiceRepository.getTableOpenedOrder(id);
      if (orderItem == null) {
        emit(const NoTableOrders());
      } else {
        if (orderItem!.waiter == "Sarah") {
          emit(TableOrdersLoaded(
              orderItem!, const Color.fromARGB(255, 218, 105, 143)));
        } else {
          emit(TableOrdersLoaded(orderItem!, Colors.grey));
        }
      }
    } catch (e) {
      emit(TableOrdersError(e.toString(), state.tableColor));
    }
  }
}
