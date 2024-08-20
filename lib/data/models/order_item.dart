import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:table_service/data/models/order.dart';
import 'package:table_service/data/models/product.dart';
import 'package:uuid/uuid.dart';

part 'order_item.g.dart';

const uuid = Uuid();

@JsonSerializable()
class OrderItem {
  String id;
  Order order;
  Product product;
  int quantity;

  OrderItem(
      {required this.order,
      required this.product,
      required this.quantity,
      id})
      : id = id ?? uuid.v4();

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
