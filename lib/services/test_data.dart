import 'package:sqflite/sqflite.dart';
import 'package:table_service/data/models/order.dart';
import 'package:table_service/data/models/order_item.dart';
import 'package:table_service/data/models/product.dart';
import 'package:table_service/data/models/service_table.dart';

List<ServiceTable> tables = [
  ServiceTable(
      name: 'T 1',
      timeServed: DateTime.now().subtract(const Duration(hours: 1))),
  ServiceTable(
      name: 'T 2',
      timeServed: DateTime.now().subtract(const Duration(hours: 2))),
  ServiceTable(
      name: 'T 3',
      timeServed: DateTime.now().subtract(const Duration(hours: 3))),
  ServiceTable(
      name: 'T 4',
      timeServed: DateTime.now()
          .subtract(const Duration(hours: 10))), // Added timeServed
  ServiceTable(
      name: 'T 5',
      timeServed: DateTime.now().subtract(const Duration(hours: 4))),
  ServiceTable(
      name: 'T 6',
      timeServed: DateTime.now()
          .subtract(const Duration(hours: 11))), // Added timeServed
  ServiceTable(
      name: 'T 7',
      timeServed: DateTime.now().subtract(const Duration(hours: 5))),
  ServiceTable(
      name: 'T 8',
      timeServed: DateTime.now()
          .subtract(const Duration(hours: 12))), // Added timeServed
  ServiceTable(
      name: 'T 9',
      timeServed: DateTime.now().subtract(const Duration(hours: 6))),
  ServiceTable(
      name: 'T 10',
      timeServed: DateTime.now()
          .subtract(const Duration(hours: 13))), // Added timeServed
  ServiceTable(
      name: 'T 11',
      timeServed: DateTime.now().subtract(const Duration(hours: 7))),
  ServiceTable(
      name: 'T 12',
      timeServed: DateTime.now()
          .subtract(const Duration(hours: 14))), // Added timeServed
  ServiceTable(
      name: 'T 13',
      timeServed: DateTime.now().subtract(const Duration(hours: 8))),
  ServiceTable(
      name: 'T 14',
      timeServed: DateTime.now()
          .subtract(const Duration(hours: 15))), // Added timeServed
  ServiceTable(
      name: 'T 15',
      timeServed: DateTime.now().subtract(const Duration(hours: 9))),
];

List<Product> products = [
  Product(name: 'Cheeseburger', price: 5.99),
  Product(name: 'Pepperoni Pizza', price: 8.99),
  Product(name: 'Caesar Salad', price: 6.49),
  Product(name: 'Spaghetti Bolognese', price: 12.99),
  Product(name: 'Grilled Chicken Sandwich', price: 7.49),
  Product(name: 'Fish and Chips', price: 9.99),
  Product(name: 'Chicken Alfredo', price: 13.99),
  Product(name: 'Vegetarian Pizza', price: 10.99),
  Product(name: 'Tuna Salad', price: 7.99),
  Product(name: 'Beef Tacos', price: 8.49),
  Product(name: 'Margherita Pizza', price: 9.99),
  Product(name: 'BBQ Ribs', price: 15.99),
  Product(name: 'Chicken Wings', price: 7.99),
  Product(name: 'Greek Salad', price: 6.99),
  Product(name: 'Chocolate Cake', price: 4.99),
  Product(name: 'Pancakes', price: 5.49),
  Product(name: 'Ice Cream Sundae', price: 4.49),
  Product(name: 'Apple Pie', price: 5.99),
  Product(name: 'Lemonade', price: 2.99),
  Product(name: 'Iced Tea', price: 2.49),
  Product(name: 'Latte', price: 3.99),
  Product(name: 'Espresso', price: 2.99),
  Product(name: 'Cappuccino', price: 3.49),
  Product(name: 'Orange Juice', price: 3.99),
  Product(name: 'Mineral Water', price: 1.99),
];

List<Order> orders = [
  Order(table: tables[0], waiter: 'Waiter 1', status: Status.opened),
  Order(table: tables[1], waiter: 'Waiter 2', status: Status.closed),
  Order(table: tables[2], waiter: 'Waiter 3', status: Status.opened),
  Order(table: tables[4], waiter: 'Waiter 4', status: Status.closed),
  Order(table: tables[6], waiter: 'Sarah', status: Status.opened),
  Order(table: tables[8], waiter: 'Waiter 6', status: Status.closed),
  Order(table: tables[10], waiter: 'Sarah', status: Status.opened),
  Order(table: tables[12], waiter: 'Waiter 8', status: Status.closed),
];

List<OrderItem> orderItems = [
  OrderItem(order: orders[0], product: products[0], quantity: 2),
  OrderItem(order: orders[0], product: products[1], quantity: 1),
  OrderItem(order: orders[1], product: products[2], quantity: 3),
  OrderItem(order: orders[1], product: products[3], quantity: 2),
  OrderItem(order: orders[2], product: products[4], quantity: 4),
  OrderItem(order: orders[2], product: products[5], quantity: 2),
  OrderItem(order: orders[3], product: products[6], quantity: 1),
  OrderItem(order: orders[3], product: products[7], quantity: 3),
  OrderItem(order: orders[4], product: products[8], quantity: 5),
  OrderItem(order: orders[4], product: products[9], quantity: 2),
  OrderItem(order: orders[5], product: products[10], quantity: 2),
  OrderItem(order: orders[5], product: products[11], quantity: 4),
  OrderItem(order: orders[6], product: products[12], quantity: 3),
  OrderItem(order: orders[6], product: products[13], quantity: 1),
  OrderItem(order: orders[7], product: products[14], quantity: 2),
  OrderItem(order: orders[7], product: products[15], quantity: 3),
];

Future<void> fillDatabaseWithTestData(Database db) async {
  Batch batch = db.batch();

  for (var entry in tables) {
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
