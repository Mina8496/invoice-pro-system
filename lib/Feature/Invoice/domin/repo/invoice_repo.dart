import 'package:dartz/dartz.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_entity.dart';
import 'package:invoicepro/core/error/failure.dart';

abstract class InvoiceRepo {

  Future<Either<Failure, int>> createInvoice(InvoiceEntity invoice);

  Future<Either<Failure, List<InvoiceEntity>>> getInvoices();

  Future<Either<Failure, InvoiceEntity>> getInvoiceById(int id);

  Future<Either<Failure, void>> deleteInvoice(int id);
}