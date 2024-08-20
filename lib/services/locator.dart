import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:table_service/services/table_service_repository.dart';

final GetIt locator = GetIt.instance;

Future<void> initialiseLocator() async {
  //key
  const int version = 1;
  const String dbName = "TestDraft.db";

  //database
  final db = await openDatabase(
    join(await getDatabasesPath(), dbName),
    onCreate: (db, version) async {
      var batch = db.batch();
      batch.execute('''
        CREATE TABLE tables (
          id TEXT PRIMARY KEY,
          name INTEGER NOT NULL,
          timeServed INTEGER
        )
      ''');
      batch.execute('''
        CREATE TABLE orders (
          id TEXT PRIMARY KEY,
          tableId TEXT FOREIGN KEY REFERENCES tables(id),
          status TEXT NOT NULL,
          waiter TEXT
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
          orderId TEXT FOREIGN KEY REFERENCES orders(id),
          productId TEXT FOREIGN KEY REFERENCES products(id),
          quantity int NOT NULL
        )
      ''');
      await batch.commit();
    },
    version: version,
  );

  locator.registerSingleton(TestDraftRepository(testDraftRepository: db));
}
