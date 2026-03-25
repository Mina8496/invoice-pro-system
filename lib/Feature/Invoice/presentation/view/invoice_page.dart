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
          FeaturedInvoicesCubit(InvoicePaginationService(), invoiceRepo),
      child: Scaffold(body: const InvoicePageBody()),
    );
  }
}
