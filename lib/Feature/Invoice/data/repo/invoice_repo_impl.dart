import 'package:dartz/dartz.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_entity.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_item_entity.dart';
import 'package:invoicepro/Feature/Invoice/domin/repo/invoice_repo.dart';
import 'package:invoicepro/core/error/failure.dart';
import 'package:invoicepro/core/database/database_helper.dart';

class InvoiceRepoImpl implements InvoiceRepo {
  final DatabaseHelper databaseHelper;

  InvoiceRepoImpl(this.databaseHelper);

  @override
  Future<Either<Failure, int>> createInvoice(InvoiceEntity invoice) async {
    try {
      final invoiceId = await DatabaseHelper.insertInvoice(
        invoice,
        invoice.items,
      );
      print("Saved Invoice ID: $invoiceId");
      return Right(invoiceId);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<List<InvoiceEntity>> fetchInvoices() async {
    return await DatabaseHelper.getAllInvoices();
  }

  @override
  Future<Either<Failure, void>> deleteInvoice(int id) async {
    try {
      final db = await DatabaseHelper.database;

      await db.delete(
        "invoice_items",
        where: "invoice_id = ?",
        whereArgs: [id],
      );

      await db.delete("invoices", where: "id = ?", whereArgs: [id]);

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, InvoiceEntity>> getInvoiceById(int id) async {
    try {
      final db = await DatabaseHelper.database;

      final invoiceMap = await db.query(
        "invoices",
        where: "id = ?",
        whereArgs: [id],
      );

      if (invoiceMap.isEmpty) {
        return Left(CacheFailure("Invoice not found"));
      }

      final invoice = invoiceMap.first;

      final itemsMap = await db.query(
        "invoice_items",
        where: "invoice_id = ?",
        whereArgs: [id],
      );

      final items = itemsMap.map((map) {
        return InvoiceItemEntity(
          name: map["name"].toString(),
          quantity: map["quantity"] as int,
          price: (map["price"] as num).toDouble(),
        );
      }).toList();

      return Right(
        InvoiceEntity(
          invoiceNumber: invoice["id"].toString(),
          date: DateTime.parse(invoice["date"].toString()),
          customerName: invoice["customer_name"].toString(),
          phone: invoice["phone"].toString(),
          carModel: invoice["carModel"]?.toString() ?? "",
          carBrand: invoice["carBrand"]?.toString() ?? "",
          plateNumber: invoice["plateNumber"]?.toString() ?? "",
          items: items,
          notes: '',
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<InvoiceEntity>>> getInvoices() async {
    try {
      final db = await DatabaseHelper.database;

      final invoicesMap = await db.query("invoices");
      final allItems = await db.query("invoice_items");

      final List<InvoiceEntity> invoices = [];

      for (var invoice in invoicesMap) {
        final items = allItems
            .where((item) => item["invoice_id"] == invoice["id"])
            .map((map) {
              return InvoiceItemEntity(
                name: map["name"].toString(),
                quantity: map["quantity"] as int,
                price: (map["price"] as num).toDouble(),
              );
            })
            .toList();

        invoices.add(
          InvoiceEntity(
            notes: "",
            invoiceNumber: invoice["id"].toString(),
            date: DateTime.parse(invoice["date"].toString()),
            customerName: invoice["customer_name"].toString(),
            phone: invoice["phone"].toString(),
            carModel: invoice["carModel"]?.toString() ?? "",
            carBrand: invoice["carBrand"]?.toString() ?? "",
            plateNumber: invoice["plateNumber"]?.toString() ?? "",
            items: items,
          ),
        );
      }

      return Right(invoices);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
