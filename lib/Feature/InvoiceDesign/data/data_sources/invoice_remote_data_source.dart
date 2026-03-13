import 'package:invoicepro/Feature/InvoiceDesign/domain/entity/invoice_entity.dart';

abstract class InvoiceRemoteDataSource {
  Future<List<InvoiceEntity>> invoiceItem();
}
