import 'package:flutter/material.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_entity.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/invoice_state.dart';
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
    return BlocBuilder<FeaturedInvoicesCubit, InvoiceState>(
      builder: (context, state) {
        final cubit = context.watch<FeaturedInvoicesCubit>();
        final pages = cubit.pageModels;
        final customer = cubit.state.customer;
        final items = state.items;

        return ListView.builder(
          shrinkWrap: true,
          itemCount: pages.isEmpty ? 1 : pages.length,
          itemBuilder: (context, index) {
            final page = pages[index];

            ProductsTableSeaction(items: items);

            if (page.showTotals) {
              CalculatorTotalsProductSaction();
            }

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
                  if (page.showCustomer && customer != null)
                    ...dataClent(customer),

                  SizedBox(height: 10),

                  /// الجدول
                  ProductsTableSeaction(items: page.items),

                  /// الإجمالي (آخر صفحة فقط)
                  if (page.showTotals) CalculatorTotalsProductSaction(),
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

  List<Widget> dataClent(InvoiceEntity customer) {
    return [
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
    ];
  }
}
