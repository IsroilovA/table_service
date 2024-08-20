import 'package:sqflite/sqflite.dart';
import 'package:table_service/data/models/order.dart';
import 'package:table_service/data/models/order_item.dart';
import 'package:table_service/data/models/product.dart';
import 'package:table_service/data/models/service_table.dart';

List<ServiceTable> serviceTables = [
  ServiceTable(
    name: 'Table 1',
    timeServed: DateTime.now().subtract(const Duration(hours: 1)), // 1 hour ago
  ),
  ServiceTable(
    name: 'Table 2',
    timeServed:
        DateTime.now().subtract(const Duration(hours: 2)), // 2 hours ago
  ),
  ServiceTable(
    name: 'Table 3',
    timeServed:
        DateTime.now().subtract(const Duration(minutes: 30)), // 30 minutes ago
  ),
];

List<Product> products = [
  Product(
    name: 'Sushi Roll',
    price: 12.99,
  ),
  Product(
    name: 'Ramen Bowl',
    price: 9.99,
  ),
  Product(
    name: 'Green Tea',
    price: 2.99,
  ),
];

List<Order> orders = [
  Order(
    table: serviceTables[0],
    waiter: 'John Doe',
    status: Status.closed, // Assuming Status is an enum
  ),
  Order(
    table: serviceTables[1],
    waiter: 'Jane Smith',
    status: Status.opened,
  ),
  Order(
    table: serviceTables[2],
    waiter: 'Emily Johnson',
    status: Status.closed,
  ),
];

List<OrderItem> orderItems = [
  OrderItem(
    order: orders[0],
    product: products[0],
    quantity: 2,
  ),
  OrderItem(
    order: orders[0],
    product: products[1],
    quantity: 1,
  ),
  OrderItem(
    order: orders[1],
    product: products[2],
    quantity: 3,
  ),
  OrderItem(
    order: orders[2],
    product: products[0],
    quantity: 1,
  ),
];

Future<void> fillDatabaseWithTestData(Database db) async {
  Batch batch = db.batch();

  for (var entry in serviceTables) {
    batch.insert("tables", entry.toJson());
  }

  for (var product in products) {
    batch.insert("products", product.toJson());
  }

  for (var orderItem in orderItems) {
    batch.insert("order_items", orderItem.toJson());
  }

  for (var order in orders) {
    batch.insert("orders", order.toJson());
  }

  await batch.commit();
}
