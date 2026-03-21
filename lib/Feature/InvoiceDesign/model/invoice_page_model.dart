import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_item_entity.dart';

class InvoicePageModel {
  final List<InvoiceItemEntity> items;
  final bool showCustomer;
  final bool showTotals;

  InvoicePageModel({
    required this.items,
    required this.showCustomer,
    required this.showTotals,
  });
}