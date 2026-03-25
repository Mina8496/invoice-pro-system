import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_entity.dart';

class PdfService {
  static Future<void> generateAndPrintInvoice(InvoiceEntity invoice) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Center(
                child: pw.Text(
                  'فاتورة',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),

              // Invoice Number and Date
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('رقم الفاتورة: ${invoice.invoiceNumber}'),
                  pw.Text('التاريخ: ${invoice.date.toString().split(' ')[0]}'),
                ],
              ),
              pw.SizedBox(height: 20),

              // Customer Information
              pw.Text('معلومات العميل:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text('الاسم: ${invoice.customerName}'),
              pw.Text('الهاتف: ${invoice.phone}'),
              if (invoice.carModel.isNotEmpty) pw.Text('موديل السيارة: ${invoice.carModel}'),
              if (invoice.carBrand.isNotEmpty) pw.Text('ماركة السيارة: ${invoice.carBrand}'),
              if (invoice.plateNumber.isNotEmpty) pw.Text('رقم اللوحة: ${invoice.plateNumber}'),
              pw.SizedBox(height: 20),

              // Items Table
              pw.Text('الخدمات:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  // Header Row
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('الخدمة', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('الكمية', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('السعر', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('الإجمالي', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                    ],
                  ),
                  // Data Rows
                  ...invoice.items.map((item) => pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(item.name),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(item.quantity.toString()),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(item.price.toStringAsFixed(2)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(item.total.toStringAsFixed(2)),
                      ),
                    ],
                  )),
                ],
              ),
              pw.SizedBox(height: 20),

              // Total
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                    'الإجمالي: ${invoice.total.toStringAsFixed(2)} ريال',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),

              // Notes
              if (invoice.notes.isNotEmpty) ...[
                pw.SizedBox(height: 20),
                pw.Text('ملاحظات:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(invoice.notes),
              ],
            ],
          );
        },
      ),
    );

    // Print the PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}