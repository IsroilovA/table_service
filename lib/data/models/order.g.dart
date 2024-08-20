// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      tableId: json['tableId'] as String,
      waiter: json['waiter'] as String,
      status: $enumDecode(_$StatusEnumMap, json['status']),
      id: json['id'],
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'tableId': instance.tableId,
      'waiter': instance.waiter,
      'status': _$StatusEnumMap[instance.status]!,
    };

const _$StatusEnumMap = {
  Status.opened: 'opened',
  Status.closed: 'closed',
};
