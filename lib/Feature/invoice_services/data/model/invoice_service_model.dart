class ServiceModel {

  final int? id;
  final String name;
  final double price;
  final int quantity;

  ServiceModel({
    this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "quantity": quantity,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map["id"],
      name: map["name"],
      price: map["price"],
      quantity: map["quantity"],
    );
  }
}