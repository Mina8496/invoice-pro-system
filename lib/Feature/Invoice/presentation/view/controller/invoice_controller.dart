import 'package:get/get.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_item_entity.dart';
import 'package:invoicepro/Feature/Invoice/domin/usecase/calculate_total.dart';

class InvoiceController extends GetxController {
  final CalculateTotal calculateTotal;

  InvoiceController(this.calculateTotal);

  final items = <InvoiceItemEntity>[].obs;

  double get total => calculateTotal(items);

  void addItem() {
    items.add(InvoiceItemEntity(name: "منتج جديد", quantity: 1, price: 0));
  }

  void removeItem(int index) {
    items.removeAt(index);
  }
}
