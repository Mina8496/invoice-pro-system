import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/featured_invoices_cubit.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/widget/invoice_page_body.dart';
import 'package:invoicepro/Feature/InvoiceDesign/use_case/invoice_pagination_service.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeaturedInvoicesCubit(InvoicePaginationService()),
      child: Scaffold(body: const InvoicePageBody()),
    );
  }
}