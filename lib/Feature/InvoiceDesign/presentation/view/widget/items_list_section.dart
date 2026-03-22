import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/featured_invoices_cubit.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/invoice_state.dart';

class ItemsListSection extends StatelessWidget {
  const ItemsListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedInvoicesCubit, InvoiceState>(
      builder: (context, state) {
        final items = state.items;

        if (items.isEmpty) {
          return const Text("لا يوجد عناصر");
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return Card(
              child: ListTile(
                title: Text(item.name),
                subtitle: Text(
                    "الكمية: ${item.quantity} | السعر: ${item.price}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    context
                        .read<FeaturedInvoicesCubit>()
                        .removeItem(index);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}