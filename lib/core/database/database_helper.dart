import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_entity.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_item_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    sqfliteFfiInit();

    final databaseFactory = databaseFactoryFfi;

    _database = await databaseFactory.openDatabase(
      join(await databaseFactory.getDatabasesPath(), "invoice_pro.db"),
      options: OpenDatabaseOptions(
        version: 2,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      ),
    );

    return _database!;
  }

  static Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      await db.execute('''
CREATE TABLE IF NOT EXISTS trial (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  start_date TEXT
)
''');
    }
  }

  static Future<void> insertTrialDate(String date) async {
    final db = await database;
    await db.delete('trial');
    await db.insert('trial', {'start_date': date});
  }

  static Future<String?> getTrialDate() async {
    final db = await database;
    final result = await db.query('trial', limit: 1);

    if (result.isNotEmpty && result.first['start_date'] != null) {
      return result.first['start_date'] as String;
    }
    return null;
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE invoices(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      customer_name TEXT,
      phone TEXT,
      carModel TEXT,
      carBrand TEXT,
      plateNumber TEXT,
      date TEXT,
      total REAL,
      notes TEXT
    )
  ''');

    await db.execute('''
    CREATE TABLE invoice_items(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      invoice_id INTEGER,
      name TEXT,
      quantity INTEGER,
      price REAL,
      total REAL,
      notes TEXT
    )
  ''');

    await db.execute('''
    CREATE TABLE services(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      price REAL
    )
  ''');

    await db.execute('''
CREATE TABLE IF NOT EXISTS trial (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  start_date TEXT
)
''');
  }

  static Future<void> ensureTrialTable() async {
    final db = await database;

    await db.execute('''
  CREATE TABLE IF NOT EXISTS trial (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    start_date TEXT
  )
  ''');
  }

  // إضافة خدمة
  static Future<int> insertService(String name, double price) async {
    final db = await database;

    return await db.insert('services', {'name': name, 'price': price});
  }

  // جلب كل الخدمات
  static Future<List<Map<String, dynamic>>> getServices() async {
    final db = await database;
    return await db.query('services');
  }

  // حذف خدمة
  static Future<void> deleteService(int id) async {
    final db = await database;

    await db.delete('services', where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> insertInvoice(
    InvoiceEntity invoice,
    List<InvoiceItemEntity> items,
  ) async {
    final db = await database;

    return await db.transaction((txn) async {
      int invoiceId = await txn.insert('invoices', {
        "customer_name": invoice.customerName,
        "phone": invoice.phone,
        "carModel": invoice.carModel,
        "carBrand": invoice.carBrand,
        "plateNumber": invoice.plateNumber,
        "date": invoice.date.toIso8601String(),
        "total": invoice.total,
        "notes": invoice.notes,
      });

      for (var item in items) {
        await txn.insert('invoice_items', {
          "invoice_id": invoiceId,
          "name": item.name,
          "quantity": item.quantity,
          "price": item.price,
          "total": item.total,
          // "notes": item.notes,
        });
      }

      return invoiceId;
    });
  }

  static Future<List<InvoiceItemEntity>> getInvoiceItems(int invoiceId) async {
    final db = await database;

    final items = await db.query(
      'invoice_items',
      where: 'invoice_id = ?',
      whereArgs: [invoiceId],
    );

    return items.map((e) {
      return InvoiceItemEntity(
        name: e['name'] as String,
        quantity: e['quantity'] as int,
        price: e['price'] as double,
      );
    }).toList();
  }

  static Future<List<InvoiceEntity>> getAllInvoices() async {
    final db = await database;

    final invoices = await db.query('invoices', orderBy: 'id DESC');

    final allItems = await db.query('invoice_items');

    Map<int, List<InvoiceItemEntity>> itemsMap = {};

    for (var item in allItems) {
      final invoiceId = item['invoice_id'] as int;

      itemsMap.putIfAbsent(invoiceId, () => []);

      itemsMap[invoiceId]!.add(
        InvoiceItemEntity(
          name: item['name'] as String,
          quantity: item['quantity'] as int,
          price: item['price'] as double,
        ),
      );
    }

    List<InvoiceEntity> result = [];

    for (var e in invoices) {
      final invoiceId = e['id'] as int;

      result.add(
        InvoiceEntity(
          invoiceNumber: invoiceId.toString(),
          date: DateTime.parse(e['date'] as String),

          customerName: e['customer_name'] as String,
          phone: e['phone'] as String? ?? "",
          carModel: e['carModel'] as String? ?? "",
          carBrand: e['carBrand'] as String? ?? "",
          plateNumber: e['plateNumber'] as String? ?? "",
          notes: e['notes'] as String? ?? "",

          items: itemsMap[invoiceId] ?? [],
        ),
      );
    }

    return result;
  }
}
