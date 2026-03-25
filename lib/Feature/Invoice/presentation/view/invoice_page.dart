import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicepro/Feature/Invoice/data/repo/invoice_repo_impl.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/featured_invoices_cubit.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/widget/invoice_page_body.dart';
import 'package:invoicepro/Feature/InvoiceDesign/use_case/invoice_pagination_service.dart';
import 'package:invoicepro/core/database/database_helper.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final databaseHelper = DatabaseHelper();
    final invoiceRepo = InvoiceRepoImpl(databaseHelper);

    return BlocProvider(
      create: (context) =>
          FeaturedInvoicesCubit(InvoicePaginationService(), invoiceRepo)
            ..loadInvoices(),
      child: Scaffold(
        body: const InvoicePageBody(),

        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green,
          onPressed: () {
            _saveAndPrintInvoice(context);
          },
          icon: const Icon(Icons.print),
          label: const Text("حفظ وطباعة"),
        ),
      ),
    );
  }

  void _saveAndPrintInvoice(BuildContext context) async {
    final cubit = context.read<FeaturedInvoicesCubit>();

    final result = await cubit.saveInvoice();

    result.fold(
      (failure) {
        print("Error: ${failure.message}");
      },
      (id) {
        print("Saved with id: $id");
        cubit.generateInvoiceNumber();
      },
    );
  }
}
