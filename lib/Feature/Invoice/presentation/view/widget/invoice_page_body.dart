import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_item_entity.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/featured_invoices_cubit.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/InvoiceDesign.dart';
import 'package:invoicepro/core/utils/Asset_Paths.dart';

class InvoicePageBody extends StatelessWidget {
  const InvoicePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetPaths.backGround),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        children: [
          /// المنتجات
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<FeaturedInvoicesCubit>().addItem(
                        InvoiceItemEntity(
                          name: "زوايا امامى",
                          quantity: 1,
                          price: 225,
                        ),
                      );
                    },
                    child: const Text("إضافة عنصر"),
                  ),

                  // ButtonAddService(controller: controller, text: "زوايا امامى"),

                  // InvoiceListViewProdactItem(controller: controller),
                ],
              ),
            ),
          ),

          /// ملخص الفاتورة
          SizedBox(
            width: 620,
            child: Card(elevation: 10, child: InvoiceDesign()),
          ),
        ],
      ),
    );
  }
}
