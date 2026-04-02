import 'package:invoicepro/Feature/InvoiceDesign/model/invoice_page_model.dart';
import 'package:invoicepro/core/utils/Asset_Paths.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_entity.dart';
import 'package:flutter/services.dart' show rootBundle;

class PdfService {
  static Future<void> generateAndPrintInvoice(
    InvoiceEntity invoice,
    List<InvoicePageModel> pages,
  ) async {
    // تحميل الخطوط
    final fontRegular = pw.Font.ttf(
      await rootBundle.load("assets/fonts/Almarai-Bold.ttf"),
    );
    final fontBold = pw.Font.ttf(
      await rootBundle.load("assets/fonts/Almarai-Bold.ttf"),
    );
    final theme = pw.ThemeData.withFont(base: fontRegular, bold: fontBold);

    // تحميل الصور مرة واحدة
    final logoBytes = await rootBundle.load(AssetPaths.logo);
    final logoImage = pw.MemoryImage(logoBytes.buffer.asUint8List());

    final qrBytes = await rootBundle.load(AssetPaths.qrCode);
    final qrImage = pw.MemoryImage(qrBytes.buffer.asUint8List());

    final pdf = pw.Document(theme: theme);

    for (var page in pages) {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(20),
          textDirection: pw.TextDirection.rtl,
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                _header(invoice, logoImage),
                _invoiceNumber(invoice),
                if (page.showCustomer) _customer(invoice),
                _table(page),
                if (page.showTotals) _total(invoice),
                pw.SizedBox(height: 20),
                pw.Divider(),
                _footer(qrImage),
              ],
            );
          },
        ),
      );
    }

    await Printing.layoutPdf(
      usePrinterSettings: true,
      name: "Invoice ${invoice.invoiceNumber}",
      onLayout: (format) async => pdf.save(),
    );
  }
}

_header(InvoiceEntity invoice, pw.ImageProvider logoImage) {
  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Expanded(
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "اسامة زعتر",
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 15),
            pw.Text("رقم الفاتورة: ${invoice.invoiceNumber}"),
            pw.SizedBox(height: 10),
            pw.Text(
              "تحرير في يوم : ${invoice.date.year}/${invoice.date.month}/${invoice.date.day}",
            ),
          ],
        ),
      ),
      pw.Spacer(),
      pw.Container(child: pw.Image(logoImage), width: 80, height: 80), // logo
    ],
  );
}

pw.Widget _invoiceNumber(InvoiceEntity invoice) {
  return pw.Center(
    child: pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 6),
      decoration: pw.BoxDecoration(border: pw.Border.all()),
      child: pw.Text(
        "000000${invoice.invoiceNumber}",
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      ),
    ),
  );
}

pw.Widget _customer(InvoiceEntity c) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text("اسم العميل : ${c.customerName}"),
      pw.SizedBox(height: 5),
      pw.Text("التليفون : ${c.phone}"),
      pw.SizedBox(height: 5),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text("${c.carModel} : الموديل"),
          pw.Text("${c.carBrand} : الماركة"),
          pw.Text("رقم اللوحة : ${c.plateNumber}"),
        ],
      ),
      pw.SizedBox(height: 10),
      pw.Text("ملاحظة : ${c.notes}"),
      pw.SizedBox(height: 10),
    ],
  );
}

pw.Widget _table(InvoicePageModel page) {
  const maxRows = 8;
  final dynamic emptyRows = (maxRows - page.items.length).clamp(0, maxRows);

  return pw.Table(
    border: pw.TableBorder.all(),
    columnWidths: {
      0: const pw.FlexColumnWidth(10),
      1: const pw.FlexColumnWidth(3),
      2: const pw.FlexColumnWidth(3),
    },
    children: [
      pw.TableRow(
        decoration: const pw.BoxDecoration(color: PdfColors.grey300),
        children: [_cell("البيان"), _cell("الكمية"), _cell("السعر")],
      ),

      ...page.items.map<pw.TableRow>((item) {
        return pw.TableRow(
          children: [
            _cell(item.name),
            _cell(item.quantity.toString()),
            _cell(item.price.toString()),
          ],
        );
      }),

      ...List.generate(emptyRows, (_) {
        return pw.TableRow(children: [_cell(""), _cell(""), _cell("")]);
      }),
    ],
  );
}

pw.Widget _cell(String text) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(8),
    child: pw.Center(child: pw.Text(text)),
  );
}

pw.Widget _total(InvoiceEntity invoice) {
  return pw.Align(
    alignment: pw.Alignment.centerRight,
    child: pw.Container(
      width: 190,
      decoration: pw.BoxDecoration(border: pw.Border.all()),
      child: pw.Padding(
        padding: const pw.EdgeInsets.all(8),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [pw.Text("الإجمـــالى :"), pw.Text("${invoice.total}")],
        ),
      ),
    ),
  );
}

_footer(pw.ImageProvider logoImage) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.end,
    children: [
      pw.Center(
        child: pw.Text(
          "مراجعة الزوايا : 15 يوم  - استكمال الزوايا خلال 3 اشهر بفاتورة الكشف عند استكمال الزوايا يتم اخذ دور جديد",

          style: pw.TextStyle(fontSize: 12),
        ),
      ),
      pw.SizedBox(height: 10),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.SizedBox(height: 8),
              pw.Text("ارقام التواصل :"),
              pw.SizedBox(height: 5),
              pw.Text("0120 3959 270"),
              pw.Text("0122 3017 289"),
            ],
          ),
          pw.Spacer(),
          pw.Container(child: pw.Image(logoImage), width: 80, height: 80), // QR
        ],
      ),
      pw.SizedBox(height: 30),
      pw.Center(
        child: pw.Text("شكراً لزيارتكم", style: pw.TextStyle(fontSize: 12)),
      ),
    ],
  );
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
