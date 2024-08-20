import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'service_table.g.dart';

const uuid = Uuid();

@JsonSerializable()
class ServiceTable {
  String id;
  String name;
  DateTime? timeServed;

  ServiceTable({
    required this.name,
    required this.timeServed,
    id,
  }) : id = id ?? uuid.v4();

  factory ServiceTable.fromJson(Map<String, dynamic> json) =>
      _$ServiceTableFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceTableToJson(this);
}
