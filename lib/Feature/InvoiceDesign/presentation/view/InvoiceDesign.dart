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
        final pages = cubit.pageModels.isEmpty ? [] : cubit.pageModels;
        final customer = cubit.state.customer;

        return SingleChildScrollView(
          child: Column(
            children: pages.map((page) {
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                width: 595,
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    HeadSeactionsInvoiceDesign(),
                    InvoiceNumberSaction(),

                    if (page.showCustomer && customer != null)
                      ...dataClent(customer),

                    ProductsTableSeaction(items: page.items),

                    if (page.showTotals) CalculatorTotalsProductSaction(),

                    const SizedBox(height: 20),
                    const Divider(),
                    FooterSeactions(),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  List<Widget> dataClent(InvoiceEntity customer) {
    return [
      Text("${customer.customerName} : اسم العميل"),
      SizedBox(height: 5),
      Text("${customer.phone} : التليفون"),
      SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${customer.carModel} : الموديل"),
          Text("${customer.carBrand} : الماركة"),
          Text("${customer.plateNumber} : رقم اللوحة"),
        ],
      ),
      SizedBox(height: 10),
      Text("${customer.notes} : ملاحظة"),
      SizedBox(height: 10),
    ];
  }
}
