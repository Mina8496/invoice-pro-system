class InvoiceItemModel {
  final int? id;
  final int? invoiceId;
  final String name;
  final int quantity;
  final double price;

  InvoiceItemModel({
    this.id,
    this.invoiceId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  double get total => quantity * price;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "invoice_id": invoiceId,
      "name": name,
      "quantity": quantity,
      "price": price,
      "total": total,
    };
  }

  factory InvoiceItemModel.fromMap(Map<String, dynamic> map) {
    return InvoiceItemModel(
      id: map["id"],
      invoiceId: map["invoice_id"],
      name: map["name"],
      quantity: map["quantity"],
      price: map["price"],
    );
  }
}
