import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/featured_invoices_cubit.dart';

class ProductsTableSeaction extends StatelessWidget {
  const ProductsTableSeaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedInvoicesCubit, FeaturedInvoicesState>(
      builder: (context, state) {
        final cubit = context.read<FeaturedInvoicesCubit>();
    
        return Table(
          border: TableBorder.all(),
          columnWidths: const {
            0: FlexColumnWidth(12),
            1: FlexColumnWidth(4),
            2: FlexColumnWidth(4),
          },
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xffeeeeee)),
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("البيان", textAlign: TextAlign.center),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("الكمية", textAlign: TextAlign.center),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("السعر", textAlign: TextAlign.center),
                ),
              ],
            ),
    
            ...cubit.items.map((item) {
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      item.name,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      item.quantity.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      item.price.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            }).toList(),
          ],
        );
      },
    );
  }
}