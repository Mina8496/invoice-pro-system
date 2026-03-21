import 'package:bloc/bloc.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_entity.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_item_entity.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/invoice_state.dart';
import 'package:invoicepro/Feature/InvoiceDesign/model/invoice_page_model.dart';
import 'package:invoicepro/Feature/InvoiceDesign/use_case/invoice_pagination_service.dart';

part 'featured_invoices_state.dart';

class FeaturedInvoicesCubit extends Cubit<InvoiceState> {
  final InvoicePaginationService paginationService;


  List<List<InvoiceItemEntity>> get pages {
    return paginationService.splitItems(state.items, 12);
  }

  FeaturedInvoicesCubit(this.paginationService)
    : super(InvoiceState(items: [], total: 0, invoiceNumber: 1));

  void setCustomer(InvoiceEntity data) {
    emit(state.copyWith(customer: data));
  }

  void addItem(InvoiceItemEntity item) {
    final updatedItems = List.of(state.items)..add(item);
    final total = _calculateTotal(updatedItems);
    emit(state.copyWith(items: updatedItems, total: total));
  }

  void removeItem(int index) {
    final updatedItems = List.of(state.items)..removeAt(index);

    final total = _calculateTotal(updatedItems);

    emit(state.copyWith(items: updatedItems, total: total));
  }

  double _calculateTotal(List<InvoiceItemEntity> items) {
    double sum = 0;
    for (var item in items) {
      sum += item.total;
    }
    return sum;
  }

  void generateInvoiceNumber() {
    emit(state.copyWith(invoiceNumber: state.invoiceNumber + 1));
  }
  
  List<InvoicePageModel> get pageModels {
  final pages = paginationService.splitItems(state.items, 12);

  if (pages.isEmpty) {
    return [
      InvoicePageModel(
        items: [],
        showCustomer: true,
        showTotals: true,
      ),
    ];
  }

  return List.generate(pages.length, (index) {
    return InvoicePageModel(
      items: pages[index],
      showCustomer: index == 0,
      showTotals: index == pages.length - 1,
    );
  });
}
}
