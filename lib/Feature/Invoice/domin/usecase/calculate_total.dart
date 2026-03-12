import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_item_entity.dart';

class CalculateTotal {
  double call(List<InvoiceItemEntity> items) {
    double sum = 0;
    for (var item in items) {
      sum += item.total;
    }
    return sum;
  }
}
