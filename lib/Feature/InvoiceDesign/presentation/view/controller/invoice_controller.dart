import 'package:get/get.dart';
import 'package:invoicepro/Feature/Invoice/data/models/invoice_item.dart';
import 'package:invoicepro/Feature/Invoice/domin/usecase/calculate_total.dart';

class InvoiceController extends GetxController {
  final CalculateTotal calculateTotal;

  InvoiceController(this.calculateTotal);

  final items = <InvoiceItem>[].obs;

  double get total => calculateTotal(items);

  void addItem() {
    items.add(InvoiceItem(name: "منتج جديد", quantity: 1, price: 0));
  }

  void removeItem(int index) {
    items.removeAt(index);
  }
}
