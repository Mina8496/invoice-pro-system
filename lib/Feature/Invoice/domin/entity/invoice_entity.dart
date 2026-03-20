import 'invoice_item_entity.dart';

class InvoiceEntity {
  final String invoiceNumber;
  final DateTime date;

  final String customerName;
  final String phone;

  final String carModel;
  final String carBrand;
  final String plateNumber;
  final String notes;

  final List<InvoiceItemEntity> items;

  InvoiceEntity({
    required this.invoiceNumber,
    required this.date,
    required this.customerName,
    required this.phone,
    required this.carModel,
    required this.carBrand,
    required this.plateNumber,
    required this.items,
    required this.notes,
  });

  double get total {
    double sum = 0;
    for (var item in items) {
      sum += item.total;
    }
    return sum;
  }
}
