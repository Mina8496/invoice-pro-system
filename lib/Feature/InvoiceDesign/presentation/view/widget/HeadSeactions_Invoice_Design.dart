import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/featured_invoices_cubit.dart';
import 'package:invoicepro/core/utils/Asset_Paths.dart';
import 'package:invoicepro/core/utils/widgets/app_textView.dart';

class HeadSeactionsInvoiceDesign extends StatelessWidget {
  const HeadSeactionsInvoiceDesign({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<FeaturedInvoicesCubit>().state;

    String formatDate(DateTime date) {
      return "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}";
    }

    final customer = state.customer;
    final invoiceNumber = state.invoiceNumber;
    final date = customer?.date ?? DateTime.now();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(AssetPaths.logo, width: 80),
        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText(
                text: "اسامة زعتر",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 10),
              Text("رقم الفاتورة: $invoiceNumber"),

              Text("تحرير في يوم : ${formatDate(date)}"),
            ],
          ),
        ),
      ],
    );
  }
}
