import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_entity.dart';

abstract class InvoiceRemoteDataSource {
  Future<List<InvoiceEntity>> invoiceItem();
}
