import 'package:bloc/bloc.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_entity.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_item_entity.dart';

part 'featured_invoices_state.dart';

class FeaturedInvoicesCubit extends Cubit<FeaturedInvoicesState> {
  FeaturedInvoicesCubit() : super(FeaturedInvoicesInitial());

  final List<InvoiceItemEntity> items = [];

  double total = 0;
  InvoiceEntity? customer;

  void setCustomer(InvoiceEntity data) {
    customer = data;
    emit(InvoiceSuccess());
  }

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

  int invoiceCounter = 1;

int currentInvoiceNumber = 1;

void generateInvoiceNumber() {
  currentInvoiceNumber = invoiceCounter;
  invoiceCounter++;
  emit(InvoiceSuccess());
}
}
