
import 'package:invoicepro/Feature/Invoice/data/models/invoice_item.dart';

class CalculateTotal {
  double call(List<InvoiceItem> items) {
    double sum = 0;
    for (var item in items) {
      sum += item.total;
    }
    return sum;
  }
}