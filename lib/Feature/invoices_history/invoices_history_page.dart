import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicepro/Feature/Invoice/data/repo/invoice_repo_impl.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/invoices_history_cubit.dart';
import 'package:invoicepro/core/database/database_helper.dart';

class InvoicesHistoryPage extends StatelessWidget {
  const InvoicesHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = InvoiceRepoImpl(DatabaseHelper());

    return BlocProvider(
      create: (_) => InvoicesHistoryCubit(repo)..loadInvoices(),
      child: Scaffold(
        appBar: AppBar(title: const Text("سجل الفواتير")),
        body: BlocBuilder<InvoicesHistoryCubit, List>(
          builder: (context, invoices) {
            if (invoices.isEmpty) {
              return const Center(child: Text("لا توجد فواتير"));
            }

            return ListView.builder(
              itemCount: invoices.length,
              itemBuilder: (context, index) {
                final invoice = invoices[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(invoice.customerName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("الموبايل: ${invoice.phone ?? "-"}"),
                        Text("الإجمالي: ${invoice.total}"),
                        Text("التاريخ: ${invoice.date.toString()}"),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // بعدين نفتح تفاصيل الفاتورة
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
