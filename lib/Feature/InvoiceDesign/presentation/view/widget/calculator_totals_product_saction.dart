import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/featured_invoices_cubit.dart';

class CalculatorTotalsProductSaction extends StatelessWidget {
  const CalculatorTotalsProductSaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 190,
        decoration: BoxDecoration(border: Border.all()),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text(
                    "${context.watch<FeaturedInvoicesCubit>().total}",
                  ),
                  const Text(":السعر المطلوب"),
                ],
              ),
            ),
            const Divider(height: 1),
          ],
        ),
      ),
    );
  }
}