import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/controller/invoice_controller.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/widget/InvoiceDesign.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/widget/invoice_listView_prodact_item.dart';
import 'package:invoicepro/utils/Asset_Paths.dart';
import 'package:invoicepro/utils/widgets/app_textView.dart';

class InvoicePageBody extends GetView<InvoiceController> {
  const InvoicePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// المنتجات
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                ElevatedButton(
                  child: Text('Elevated Button'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {},
                ),
                ElevatedButton(
                  onPressed: controller.addItem,
                  style: ButtonStyle(),
                  child: AppText(text: "زوايا امامى"),
                ),
                const SizedBox(height: 10),
                InvoiceListViewProdactItem(controller: controller),
              ],
            ),
          ),
        ),

        /// ملخص الفاتورة
        Expanded(flex: 1, child: InvoiceDesign()),
      ],
    );
  }
}
