import 'package:bloc/bloc.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_item_entity.dart';

part 'featured_invoices_state.dart';

class FeaturedInvoicesCubit extends Cubit<FeaturedInvoicesState> {
  FeaturedInvoicesCubit() : super(FeaturedInvoicesInitial());

  final List<InvoiceItemEntity> items = [];

  double total = 0;

  void addItem(InvoiceItemEntity item) {
    items.add(item);

    calculateTotal();
  }

  void removeItem(int index) {
    items.removeAt(index);

    calculateTotal();
  }

  void calculateTotal() {
    total = 0;

    for (var item in items) {
      total += item.total;
    }

    emit(InvoiceUpdated(List.from(items), total));
  }
}
