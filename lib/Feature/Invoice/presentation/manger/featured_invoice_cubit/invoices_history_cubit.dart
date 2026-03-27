import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicepro/Feature/Invoice/data/repo/invoice_repo_impl.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_entity.dart';

class InvoicesHistoryCubit extends Cubit<List<InvoiceEntity>> {
  final InvoiceRepoImpl repo;

  InvoicesHistoryCubit(this.repo) : super([]);

  Future<void> loadInvoices() async {
    final data = await repo.fetchInvoices();
    emit(data);
  }
}