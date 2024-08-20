import 'package:sqflite/sqlite_api.dart';
import 'package:table_service/data/models/order_item.dart';

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
}
