import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'order_item.g.dart';

const uuid = Uuid();

@JsonSerializable()
class OrderItem {
  String id;
  String orderId;
  String productId;
  int quantity;

  OrderItem(
      {required this.orderId,
      required this.productId,
      required this.quantity,
      id})
      : id = id ?? uuid.v4();

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
