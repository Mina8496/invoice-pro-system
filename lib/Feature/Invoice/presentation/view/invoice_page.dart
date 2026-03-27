import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicepro/Feature/Invoice/data/repo/invoice_repo_impl.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/featured_invoices_cubit.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/invoice_state.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/widget/invoice_page_body.dart';
import 'package:invoicepro/Feature/InvoiceDesign/use_case/invoice_pagination_service.dart';
import 'package:invoicepro/core/database/database_helper.dart';
import 'package:invoicepro/core/utils/pdf_service.dart';

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
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: const InvoicePageBody(),

            floatingActionButton:
                BlocBuilder<FeaturedInvoicesCubit, InvoiceState>(
                  builder: (context, state) {
                    final cubit = context.read<FeaturedInvoicesCubit>();

                    return FloatingActionButton.extended(
                      backgroundColor: Colors.green,
                      onPressed: cubit.isLoading
                          ? null
                          : () async {
                              cubit.setLoading(true);
                              final result = await cubit.saveInvoice();
                              cubit.setLoading(false);

                              result.fold(
                                (failure) => _showSnackBar(
                                  context,
                                  "فشل الحفظ: ${failure.message}",
                                  false,
                                ),
                                (id) async {
                                  _showSnackBar(
                                    context,
                                    "تم حفظ الفاتورة بنجاح",
                                    true,
                                  );
                                  cubit.generateInvoiceNumber();
                                  final invoiceEntity = cubit
                                      .getCurrentInvoiceEntity();

                                  // Pass pages here
                                  await PdfService.generateAndPrintInvoice(
                                    invoiceEntity,
                                    cubit.pageModels,
                                  );
                                },
                              );
                            },
                      icon: cubit.isLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.print),
                      label: Text(
                        cubit.isLoading ? "جاري الحفظ..." : "حفظ وطباعة",
                      ),
                    );
                  },
                ),
          );
        },
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String message, bool success) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: success ? Colors.green : Colors.red,
      duration: const Duration(seconds: 2),
    ),
  );
}
