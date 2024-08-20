import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:table_service/services/table_service_repository.dart';
import 'package:table_service/services/test_data.dart';

final GetIt locator = GetIt.instance;

Future<void> initialiseLocator() async {
  //key
  const int version = 1;
  const String dbName = "TableService.db";

  //database
  final db = await openDatabase(
    join(await getDatabasesPath(), dbName),
    onCreate: (db, version) async {
      var batch = db.batch();
      batch.execute('''
        CREATE TABLE tables (
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          timeServed INTEGER
        )
      ''');
      batch.execute('''
        CREATE TABLE orders (
          id TEXT PRIMARY KEY,
          tableId TEXT NOT NULL,
          status TEXT NOT NULL,
          waiter TEXT NOT NULL,
          FOREIGN KEY (tableId) REFERENCES tables(id)
        )
      ''');
      batch.execute('''
        CREATE TABLE products (
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          price REAL NOT NULL,
          imagePath TEXT NOT NULL
        )
      ''');
      batch.execute('''
        CREATE TABLE order_items (
          id TEXT PRIMARY KEY,
          orderId TEXT NOT NULL,
          productId TEXT NOT NULL,
          quantity INTEGER NOT NULL,
          FOREIGN KEY (orderId) REFERENCES orders(id),
          FOREIGN KEY (productId) REFERENCES products(id)
        )
      ''');
      await batch.commit();
      await fillDatabaseWithTestData(db);
    },
    version: version,
  );

  locator.registerSingleton(TableServiceRepository(tableServiceDb: db));
}
