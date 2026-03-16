import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/widget/HeadSeactions_Invoice_Design.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/widget/Invoice_Number_Saction.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/widget/calculator_totals_product_saction.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/widget/footer_seactions.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/widget/products_table_seaction.dart';

class InvoiceDesign extends StatelessWidget {
  const InvoiceDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          // width: 595  - A4
          constraints: const BoxConstraints(maxWidth: 595),
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// HEADER
              HeadSeactionsInvoiceDesign(),
              SizedBox(height: 25.h),

              ///INVOICE NUMBER
              InvoiceNumberSaction(),

              SizedBox(height: 20.h),

              /// CUSTOMER DATA
              Text("اسم العميل : احمد سليمان", textAlign: TextAlign.start),
              Text("التليفون : 01020133108"),

              const SizedBox(height: 10),

              Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 10,
                runSpacing: 5,
                children: const [
                  Text("RX5 plus : الموديل"),
                  Text("MG : الماركة"),
                  Text("رقم اللوحة : ل ك ع 2741"),
                ],
              ),

              const SizedBox(height: 10),
              Text(":  ملاحطة"),
              const SizedBox(height: 10),

              /// PRODUCTS TABLE
              ProductsTableSeaction(),

              /// TOTALS
              CalculatorTotalsProductSaction(),

              SizedBox(height: 15.h),
              Divider(color: Colors.black, thickness: 1, height: 1),

              SizedBox(height: 15.h),

              /// FOOTER
              FooterSeactions(),
            ],
          ),
        ),
      ),
    );
  }
}
