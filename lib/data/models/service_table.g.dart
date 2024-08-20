// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceTable _$ServiceTableFromJson(Map<String, dynamic> json) => ServiceTable(
      name: json['name'] as String,
      timeServed:
          DateTime.fromMillisecondsSinceEpoch(json['timeServed'] as int),
      id: json['id'],
    );

Map<String, dynamic> _$ServiceTableToJson(ServiceTable instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'timeServed': instance.timeServed.millisecondsSinceEpoch,
    };
