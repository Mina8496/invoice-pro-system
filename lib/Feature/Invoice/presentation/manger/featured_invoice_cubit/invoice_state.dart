import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_entity.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_item_entity.dart';

class InvoiceState {
  final List<InvoiceItemEntity> items;
  final double total;
  final InvoiceEntity? customer;
  final int invoiceNumber;

  InvoiceState({
    this.items = const [],
    this.total = 0,
    this.customer,
    this.invoiceNumber = 1,
  });

  InvoiceState copyWith({
    List<InvoiceItemEntity>? items,
    double? total,
    InvoiceEntity? customer,
    int? invoiceNumber,
  }) {
    return InvoiceState(
      items: items ?? this.items,
      total: total ?? this.total,
      customer: customer ?? this.customer,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
    );
  }
}