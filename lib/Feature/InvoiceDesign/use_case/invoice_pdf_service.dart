import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoicePdfService {
  static Future<void> printInvoice() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Center(child: pw.Text("Invoice PDF"));
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }
}
