import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/featured_invoices_cubit.dart';

class InvoiceNumberSaction extends StatelessWidget {
  const InvoiceNumberSaction({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<FeaturedInvoicesCubit>();
    final invoiceNumber = cubit.currentInvoiceNumber;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
            decoration: BoxDecoration(border: Border.all()),
            child: Text(
              "000000$invoiceNumber",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
