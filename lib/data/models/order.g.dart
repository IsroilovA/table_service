// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      table: json['tableId'] is String
          ? ServiceTable.fromJson(jsonDecode(json['tableId']))
          : ServiceTable.fromJson(json['tableId']),
      waiter: json['waiter'] as String,
      status: $enumDecode(_$StatusEnumMap, json['status']),
      id: json['id'] as String,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'tableId': instance.table.id,
      'waiter': instance.waiter,
      'status': _$StatusEnumMap[instance.status]!,
    };

const _$StatusEnumMap = {
  Status.opened: 'opened',
  Status.closed: 'closed',
};
