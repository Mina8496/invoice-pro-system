import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_item_entity.dart';

class InvoiceEntity {
  final String invoiceNumber;
  final String date;

  final String customerName;
  final String phone;

  final String carModel;
  final String carBrand;
  final String plateNumber;

  final List<InvoiceItemEntity> items;

  final double total;

  InvoiceEntity({
    required this.invoiceNumber,
    required this.date,
    required this.customerName,
    required this.phone,
    required this.carModel,
    required this.carBrand,
    required this.plateNumber,
    required this.items,
    required this.total,
  });
}
