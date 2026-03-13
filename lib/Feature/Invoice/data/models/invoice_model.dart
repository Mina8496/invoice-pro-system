import 'invoice_item_model.dart';

class InvoiceModel {
  final int? id;
  final String customerName;
  final String phone;
  final String? carModel;
  final String? carBrand;
  final String? plateNumber;
  final DateTime date;
  final List<InvoiceItemModel> items;

  InvoiceModel({
    this.carModel,
    this.carBrand,
    this.plateNumber,
    this.id,
    required this.customerName,
    required this.phone,
    required this.date,
    required this.items,
  });

  double get total => items.fold(0, (sum, item) => sum + item.total);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "customer_name": customerName,
      "phone": phone,
      "carModel": carModel,
      "carBrand": carBrand,
      "plateNumber": plateNumber,

      "date": date.toIso8601String(),
      "total": total,
    };
  }

  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      id: map["id"],
      customerName: map["customer_name"],
      phone: map["phone"],
      carModel: map["carModel"],
      carBrand: map["carBrand"],
      plateNumber: map["plateNumber"],
      date: DateTime.parse(map["date"]),
      items: [],
    );
  }
}
