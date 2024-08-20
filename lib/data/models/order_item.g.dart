// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      order: Order.fromJson(jsonDecode(json['orderId'])),
      product: Product.fromJson(jsonDecode(json['productId'])),
      quantity: (json['quantity'] as num).toInt(),
      id: json['id'],
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      'orderId': instance.order.id,
      'productId': instance.product.id,
      'quantity': instance.quantity,
    };
