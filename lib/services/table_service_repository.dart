import 'package:sqflite/sqlite_api.dart';
import 'package:table_service/data/models/order.dart';
import 'package:table_service/data/models/order_item.dart';
import 'package:table_service/data/models/product.dart';
import 'package:table_service/data/models/service_table.dart';

class TableServiceRepository {
  TableServiceRepository({required Database tableServiceDb})
      : _tableServiceDb = tableServiceDb;

  //database
  final Database _tableServiceDb;

  Future<List<OrderItem>?> getOrderItems() async {
    List<Map<String, dynamic>> maps = await _tableServiceDb.rawQuery('''
          SELECT 
          order_items.id AS id,
          order_items.quantity AS quantity,
          json_object(
            'id', orders.id,
            'status', orders.status,
            'waiter', orders.waiter,
            'tableId', json_object(
              'id', tables.id,
              'name', tables.name,
              'timeServed', tables.timeServed
            )
          ) AS orderId,
          json_object(
            'id', products.id,
            'name', products.name,
            'price', products.price,
            'imagePath', products.imagePath
          ) AS productId
        FROM 
          order_items
        JOIN 
          orders ON order_items.orderId = orders.id
        JOIN 
          products ON order_items.productId = products.id
        JOIN 
          tables ON orders.tableId = tables.id;
        ''');

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
      maps.length,
      (index) => OrderItem.fromJson(
        maps[index],
      ),
    );
  }

  Future<List<OrderItem>?> getTableOpenedOrderItems(String orderId) async {
    List<Map<String, dynamic>> maps = await _tableServiceDb.rawQuery('''
          SELECT 
          order_items.id AS id,
          order_items.quantity AS quantity,
          json_object(
            'id', orders.id,
            'status', orders.status,
            'waiter', orders.waiter,
            'tableId', json_object(
              'id', tables.id,
              'name', tables.name,
              'timeServed', tables.timeServed
            )
          ) AS orderId,
          json_object(
            'id', products.id,
            'name', products.name,
            'price', products.price,
            'imagePath', products.imagePath
          ) AS productId
        FROM 
          order_items
        JOIN 
          orders ON order_items.orderId = orders.id
        JOIN 
          products ON order_items.productId = products.id
        JOIN 
          tables ON orders.tableId = tables.id
        WHERE
          orders.id = ? AND orders.status = ?;
        ''', [orderId, Status.opened.name]);

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
      maps.length,
      (index) => OrderItem.fromJson(
        maps[index],
      ),
    );
  }

  Future<Order?> getTableOpenedOrder(String tableId) async {
    List<Map<String, dynamic>> maps = await _tableServiceDb.rawQuery('''
         SELECT 
          orders.id AS id,
          json_object(
            'id', tables.id,
            'name', tables.name,
            'timeServed', tables.timeServed
          ) AS tableId,
          orders.status AS status,
          orders.waiter AS waiter
        FROM 
          orders
        JOIN
          tables ON orders.tableId = tables.id
        WHERE
          tables.id = ? AND orders.status = ?

        ''', [tableId, Status.opened.name]);

    if (maps.isEmpty) {
      return null;
    }
    return Order.fromJson(
      maps.first,
    );
  }

  Future<List<ServiceTable>?> getAllTables() async {
    List<Map<String, dynamic>> maps = await _tableServiceDb.query("tables");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
      maps.length,
      (index) => ServiceTable.fromJson(
        maps[index],
      ),
    );
  }

  Future<List<Product>?> getAllProducts() async {
    List<Map<String, dynamic>> maps = await _tableServiceDb.query("products");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
      maps.length,
      (index) => Product.fromJson(
        maps[index],
      ),
    );
  }
}
