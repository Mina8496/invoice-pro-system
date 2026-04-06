import 'package:bloc/bloc.dart';
import 'package:invoicepro/Feature/Invoice/data/models/service_item.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_entity.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_item_entity.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/invoice_state.dart';
import 'package:invoicepro/Feature/InvoiceDesign/model/invoice_page_model.dart';
import 'package:invoicepro/Feature/InvoiceDesign/use_case/invoice_pagination_service.dart';
import 'package:invoicepro/Feature/Invoice/domin/repo/invoice_repo.dart'; // استيراد الـ InvoiceRepo
import 'package:dartz/dartz.dart';
import 'package:invoicepro/core/database/database_helper.dart';
import 'package:invoicepro/core/error/failure.dart';

part 'featured_invoices_state.dart';

class FeaturedInvoicesCubit extends Cubit<InvoiceState> {
  final InvoicePaginationService paginationService;
  final InvoiceRepo invoiceRepo; // إضافة الـ InvoiceRepo
  int resetCounter = 0;
  static const int itemsPerPage = 8;

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    emit(state);
  }

  List<List<InvoiceItemEntity>> get pages {
    return paginationService.splitItems(state.items, itemsPerPage);
  }

  FeaturedInvoicesCubit(this.paginationService, this.invoiceRepo)
    : super(
        InvoiceState(
          items: [],
          services: [],
          total: 0,
          invoiceNumber: 1,
          customer: null,
        ),
      );
  Future<void> addService(ServiceItem service) async {
    await DatabaseHelper.insertService(service.name, service.price);

    await loadServices();
  }

  Future<void> loadServices() async {
    final data = await DatabaseHelper.getServices();

    final services = data.map((e) {
      return ServiceItem(name: e['name'], price: e['price'], quantity: 1);
    }).toList();

    emit(state.copyWith(services: services));
  }

  Future<void> initInvoiceNumberOnly() async {
    final result = await invoiceRepo.getInvoices();

    result.fold((_) {}, (invoices) {
      emit(state.copyWith(invoiceNumber: invoices.length + 1));
    });
  }

  void resetInvoice() {
    resetCounter++;
    emit(
      state.copyWith(
        items: [],
        services: state.services,
        total: 0,
        customer: null,
        // تزوّد رقم الفاتورة تلقائي
        invoiceNumber: state.invoiceNumber + 1,
      ),
    );
  }

  void removeService(int index) {
    final updated = List.of(state.services)..removeAt(index);
    emit(state.copyWith(services: updated));
  }

  void updateService(int index, ServiceItem newItem) {
    final updated = List.of(state.services);
    updated[index] = newItem;
    emit(state.copyWith(services: updated));
  }

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
        InvoicePageModel(items: [], showCustomer: true, showTotals: true),
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

  // دالة حفظ الفاتورة
  Future<Either<Failure, int>> saveInvoice() async {
    final invoiceEntity = InvoiceEntity(
      invoiceNumber: state.invoiceNumber.toString(),
      date: DateTime.now(),
      customerName: state.customer?.customerName ?? '',
      phone: state.customer?.phone ?? '',
      carModel: state.customer?.carModel ?? '',
      carBrand: state.customer?.carBrand ?? '',
      plateNumber: state.customer?.plateNumber ?? '',
      items: state.items,
      notes: '', // أضف أي ملاحظات إذا كان لديك
    );

    return await invoiceRepo.createInvoice(invoiceEntity);
  }

  InvoiceEntity getCurrentInvoiceEntity() {
    return InvoiceEntity(
      invoiceNumber: state.invoiceNumber.toString(),
      date: DateTime.now(),
      customerName: state.customer?.customerName ?? '',
      phone: state.customer?.phone ?? '',
      carModel: state.customer?.carModel ?? '',
      carBrand: state.customer?.carBrand ?? '',
      plateNumber: state.customer?.plateNumber ?? '',
      items: state.items,
      notes: '',
    );
  }

  Future<void> loadInvoices() async {
    emit(state.copyWith(items: []));

    final result = await invoiceRepo.getInvoices();

    result.fold(
      (failure) {
        print("Error loading invoices: ${failure.message}");
      },
      (invoices) {
        if (invoices.isNotEmpty) {
          emit(state.copyWith(invoiceNumber: invoices.length + 1));
        }
      },
    );
  }
}
