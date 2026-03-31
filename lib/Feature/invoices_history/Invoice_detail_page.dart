import 'package:flutter/material.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_entity.dart';
import 'package:invoicepro/Feature/InvoiceDesign/model/invoice_page_model.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/InvoiceDesign.dart';
import 'package:invoicepro/core/utils/pdf_service.dart';

class InvoiceDetailPage extends StatelessWidget {
  final InvoiceEntity invoice;

  const InvoiceDetailPage({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("فاتورة رقم ${invoice.invoiceNumber}")),
      body: Center(
        child: SizedBox(
          width: 620,
          child: Card(
            elevation: 10,
            child: Builder(
              builder: (context) {
                return InvoiceDesign();
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.print),
        label: const Text("طباعة"),
        onPressed: () async {
          await PdfService.generateAndPrintInvoice(invoice, [
            InvoicePageModel(
              items: invoice.items,
              showCustomer: true,
              showTotals: true,
            ),
          ]);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("تم إرسال الفاتورة للطباعة")),
          );
        },
      ),
    );
  }
}
