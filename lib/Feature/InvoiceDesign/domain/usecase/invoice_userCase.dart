import 'package:dartz/dartz.dart';
import 'package:invoicepro/Feature/InvoiceDesign/domain/entity/invoice_entity.dart';
import 'package:invoicepro/Feature/InvoiceDesign/domain/repo/invoice_repo.dart';
import 'package:invoicepro/core/error/Failure.dart';
import 'package:invoicepro/core/use_cases/use_case.dart';

class InvoiceUsercase extends UserCase<List<InvoiceEntity>, NoParam> {
  final InvoiceRepo invoiceRepo;

  InvoiceUsercase(this.invoiceRepo);

  @override
  Future<Either<Failure, List<InvoiceEntity>>> call([NoParam? param]) async {
    return await invoiceRepo.fetchFeaturedInvoice();
  }
}
