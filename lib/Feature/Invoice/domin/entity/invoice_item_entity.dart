class InvoiceItemEntity {
  final String name;
  final int quantity;
  final double price;

  InvoiceItemEntity({
    required this.name,
    required this.quantity,
    required this.price,
  });

  double get total => quantity * price;
}
