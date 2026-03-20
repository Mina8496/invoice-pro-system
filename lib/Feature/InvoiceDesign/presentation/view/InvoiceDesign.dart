import 'package:flutter/material.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/widget/HeadSeactions_Invoice_Design.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/widget/Invoice_Number_Saction.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/widget/calculator_totals_product_saction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/featured_invoices_cubit.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/widget/footer_seactions.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/widget/products_table_seaction.dart';

class InvoiceDesign extends StatelessWidget {
  const InvoiceDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedInvoicesCubit, FeaturedInvoicesState>(
      builder: (context, state) {
        final cubit = context.read<FeaturedInvoicesCubit>();
        final customer = cubit.customer;
        final items = cubit.items;

        final pages = splitItems(items, 12);

        return ListView.builder(
          shrinkWrap: true,
          itemCount: pages.isEmpty ? 1 : pages.length,
          itemBuilder: (context, index) {
            final pageItems = pages.isEmpty ? [] : pages[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              width: 595,
              height: 842,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /// HEADER
                  HeadSeactionsInvoiceDesign(),

                  SizedBox(height: 10),

                  /// رقم الفاتورة
                  InvoiceNumberSaction(),

                  SizedBox(height: 10),

                  /// بيانات العميل (أول صفحة فقط)
                  if (index == 0 && customer != null) ...[
                    Text("اسم العميل : ${customer.customerName}"),
                    SizedBox(height: 5),
                    Text("${customer.phone} : التليفون"),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("الموديل: ${customer.carModel}"),
                        Text("الماركة: ${customer.carBrand}"),
                        Text("رقم اللوحة : ${customer.plateNumber}"),
                      ],
                    ),
                    Text("${customer.notes} : ملاحظة"),
                  ],

                  SizedBox(height: 10),

                  /// الجدول
                  ProductsTableSeaction(items: pageItems),

                  /// الإجمالي (آخر صفحة فقط)
                  if (index == pages.length - 1 || pages.isEmpty)
                    CalculatorTotalsProductSaction(),
                  const Spacer(),

                  SizedBox(height: 10),
                  const Divider(),

                  /// الفوتر
                  FooterSeactions(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

List<List<dynamic>> splitItems(List items, int perPage) {
  List<List<dynamic>> pages = [];

  for (int i = 0; i < items.length; i += perPage) {
    pages.add(
      items.sublist(i, i + perPage > items.length ? items.length : i + perPage),
    );
  }

  return pages;
}
