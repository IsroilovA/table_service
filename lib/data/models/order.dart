import 'package:json_annotation/json_annotation.dart';
import 'package:table_service/data/models/service_table.dart';
import 'package:uuid/uuid.dart';

part 'order.g.dart';

const uuid = Uuid();

enum Status { opened, closed }

@JsonSerializable()
class Order {
  String id;
  ServiceTable table;
  String waiter;
  Status status;

  Order({
    required this.table,
    required this.waiter,
    required this.status,
    id,
  }) : id = id ?? uuid.v4();

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
