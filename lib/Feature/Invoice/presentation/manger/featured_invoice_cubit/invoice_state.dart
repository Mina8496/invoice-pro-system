import 'package:invoicepro/Feature/Invoice/data/models/service_item.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_entity.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_item_entity.dart';

class InvoiceState {
  final List<InvoiceItemEntity> items;
  final List<ServiceItem> services;
  final double total;
  final InvoiceEntity? customer;
  final int invoiceNumber;

  InvoiceState({
    this.services = const [],
    this.items = const [],
    this.total = 0,
    this.invoiceNumber = 1,
    this.customer,
  });

  InvoiceState copyWith({
    List<InvoiceItemEntity>? items,
    List<ServiceItem>? services,
    double? total,
    InvoiceEntity? customer,
    int? invoiceNumber,
  }) {
    return InvoiceState(
      items: items ?? this.items,
      services: services ?? this.services,
      total: total ?? this.total,
      customer: customer ?? this.customer,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
    );
  }
}
