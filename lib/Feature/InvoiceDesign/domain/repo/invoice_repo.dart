import 'package:dartz/dartz.dart';
import 'package:invoicepro/Feature/InvoiceDesign/domain/entity/invoice_entity.dart';
import 'package:invoicepro/core/error/Failure.dart';

abstract class InvoiceRepo {

  Future<Either<Failure, List<InvoiceEntity>>> invoiceItem();
}
