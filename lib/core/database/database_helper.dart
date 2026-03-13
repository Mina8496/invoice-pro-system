import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    sqfliteFfiInit();

    final databaseFactory = databaseFactoryFfi;

    _database = await databaseFactory.openDatabase(
      join(await databaseFactory.getDatabasesPath(), "invoice_pro.db"),
      options: OpenDatabaseOptions(version: 1, onCreate: _onCreate),
    );

    return _database!;
  }

  static Future<void> _onCreate(Database db, int version) async {
    await _createServicesTable(db);
    await _createInvoicesTable(db);
    await _createInvoiceItemsTable(db);
  }

  static Future<void> _createServicesTable(Database db) async {
    await db.execute('''
      CREATE TABLE services(
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 name TEXT,
 price REAL,
 quantity INTEGER
);
    ''');
  }

  static Future<void> _createInvoicesTable(Database db) async {
    await db.execute('''
      CREATE TABLE invoices(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      customer_name TEXT,
      phone TEXT,
      carModel TEXT,
      carBrand TEXT,
      plateNumber TEXT,
      date TEXT,
      total REAL
      )
    ''');
  }

  static Future<void> _createInvoiceItemsTable(Database db) async {
    await db.execute('''
      CREATE TABLE invoice_items(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      invoice_id INTEGER,
      service_id INTEGER,
      name TEXT,
      quantity INTEGER,
      price REAL,
      total REAL,
      FOREIGN KEY(invoice_id) REFERENCES invoices(id),
      FOREIGN KEY(service_id) REFERENCES services(id)
      )
    ''');
  }
}
