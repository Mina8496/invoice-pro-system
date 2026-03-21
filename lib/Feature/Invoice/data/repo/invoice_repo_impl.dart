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
      final db = await DatabaseHelper.database;

      final invoiceId = await db.insert("invoices", {
        "customer_name": invoice.customerName,
        "phone": invoice.phone,
        "carModel": invoice.carModel,
        "carBrand": invoice.carBrand,
        "plateNumber": invoice.plateNumber,
        "date": invoice.date.toIso8601String(),
        "total": invoice.total,
      });

      for (var item in invoice.items) {
        await db.insert("invoice_items", {
          "invoice_id": invoiceId,
          "name": item.name,
          "quantity": item.quantity,
          "price": item.price,
          "total": item.total,
        });
      }

      return Right(invoiceId);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
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
          notes: invoice["notes"].toString(),
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
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<InvoiceEntity>>> getInvoices() async {
    try {
      final db = await DatabaseHelper.database;

      final invoicesMap = await db.query("invoices");

      final List<InvoiceEntity> invoices = [];

      for (var invoice in invoicesMap) {
        final itemsMap = await db.query(
          "invoice_items",
          where: "invoice_id = ?",
          whereArgs: [invoice["id"]],
        );

        final items = itemsMap.map((map) {
          return InvoiceItemEntity(
            name: map["name"].toString(),
            quantity: map["quantity"] as int,
            price: (map["price"] as num).toDouble(),
          );
        }).toList();

        invoices.add(
          InvoiceEntity(
            notes: invoice["notes"].toString(),
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
