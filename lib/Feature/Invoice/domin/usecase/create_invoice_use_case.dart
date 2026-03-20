import 'package:dartz/dartz.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_entity.dart';
import 'package:invoicepro/Feature/Invoice/domin/repo/invoice_repo.dart';
import 'package:invoicepro/core/error/failure.dart';
import 'package:invoicepro/core/use_cases/use_case.dart';

class CreateInvoiceUseCase extends UserCase<int, InvoiceEntity> {
  final InvoiceRepo invoiceRepo;

  CreateInvoiceUseCase(this.invoiceRepo);

  @override
  Future<Either<Failure, int>> call([InvoiceEntity? invoice]) async {
    return await invoiceRepo.createInvoice(invoice!);
  }
}
