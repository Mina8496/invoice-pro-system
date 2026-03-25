import 'package:invoicepro/Feature/InvoiceDesign/model/invoice_page_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_entity.dart';

class PdfService {
  static Future<void> generateAndPrintInvoice(
    InvoiceEntity invoice,
    List<InvoicePageModel> pages,
  ) async {
    final pdf = pw.Document();

    for (var page in pages) {
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(20),
          build: (pw.Context context) {
            return [
              // Header Section
              pw.Center(
                child: pw.Text(
                  'فاتورة',
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 10),
              // Invoice Number Section
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('رقم الفاتورة: ${invoice.invoiceNumber}'),
                  pw.Text('التاريخ: ${invoice.date.toString().split(' ')[0]}'),
                ],
              ),
              pw.SizedBox(height: 10),
              // Customer Info
              if (page.showCustomer)
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text("${invoice.customerName} : اسم العميل"),
                    pw.SizedBox(height: 5),
                    pw.Text("${invoice.phone} : التليفون"),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("${invoice.carModel} : الموديل"),
                        pw.Text("${invoice.carBrand} : الماركة"),
                        pw.Text("${invoice.plateNumber} : رقم اللوحة"),
                      ],
                    ),
                    if (invoice.notes.isNotEmpty)
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(top: 10),
                        child: pw.Text("${invoice.notes} : ملاحظة"),
                      ),
                    pw.SizedBox(height: 10),
                  ],
                ),
              pw.SizedBox(height: 10),
              // Products Table
              pw.Table.fromTextArray(
                headers: ['الخدمة', 'الكمية', 'السعر', 'الإجمالي'],
                data: page.items
                    .map(
                      (item) => [
                        item.name,
                        item.quantity.toString(),
                        item.price.toStringAsFixed(2),
                        item.total.toStringAsFixed(2),
                      ],
                    )
                    .toList(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                cellAlignment: pw.Alignment.centerLeft,
                border: pw.TableBorder.all(width: 0.5),
              ),
              pw.SizedBox(height: 10),
              // Totals
              if (page.showTotals)
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text(
                      'الإجمالي: ${invoice.total.toStringAsFixed(2)} ريال',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              pw.SizedBox(height: 20),
              pw.Divider(),
              // Footer
              pw.Center(
                child: pw.Text(
                  'شكراً لتعاملكم معنا',
                  style: pw.TextStyle(fontStyle: pw.FontStyle.italic),
                ),
              ),
            ];
          },
        ),
      );
    }

    // Print PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}

// نموذج بيانات للصفحات
class PageModel {
  final bool showCustomer;
  final bool showTotals;
  final List<ItemModel> items;

  PageModel({
    required this.showCustomer,
    required this.showTotals,
    required this.items,
  });
}

class ItemModel {
  final String name;
  final int quantity;
  final double price;
  final double total;

  ItemModel({
    required this.name,
    required this.quantity,
    required this.price,
    required this.total,
  });
}
