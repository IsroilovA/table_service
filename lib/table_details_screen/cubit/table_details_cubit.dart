import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:table_service/data/models/order.dart';
import 'package:table_service/data/models/order_item.dart';
import 'package:table_service/data/models/product.dart';
import 'package:table_service/services/table_service_repository.dart';

part 'table_details_state.dart';

class TableDetailsCubit extends Cubit<TableDetailsState> {
  TableDetailsCubit({required TableServiceRepository tableServiceRepository})
      : _tableServiceRepository = tableServiceRepository,
        super(TableDetailsInitial());

  final TableServiceRepository _tableServiceRepository;

  List<OrderItem>? orderItems = [];

  void loadOrderItems(String orderId) async {
    emit(TableDetailsLoading());
    try {
      orderItems =
          await _tableServiceRepository.getTableOpenedOrderItems(orderId);
      if (orderItems != null) {
        emit(TableDetailsLoaded(orderItems!));
      }
    } catch (e) {
      TableDetailsError(e.toString());
    }
  }

  void addOrderItem(Order order, Product product) {
    bool containsProduct = false;
    for (var element in orderItems!) {
      if (element.product.id == product.id) {
        containsProduct = true;
        break;
      }
    }

    if (containsProduct) {
      return;
    }
    orderItems!.add(OrderItem(order: order, product: product, quantity: 1));
    emit(TableDetailsLoaded(orderItems!));
  }

  void changeOrderItemQuantity(
      {required OrderItem orderItem, required bool isPlus}) {
    final indexOfOrderItem = orderItems!.indexOf(orderItem);
    if (isPlus) {
      orderItems![indexOfOrderItem] = OrderItem(
          order: orderItem.order,
          product: orderItem.product,
          quantity: orderItem.quantity + 1);
    } else {
      if (orderItem.quantity > 1) {
        orderItems![indexOfOrderItem] = OrderItem(
            order: orderItem.order,
            product: orderItem.product,
            quantity: orderItem.quantity - 1);
      } else {
        orderItems!.removeAt(indexOfOrderItem);
      }
    }

    emit(TableDetailsLoaded(orderItems!));
  }
}
