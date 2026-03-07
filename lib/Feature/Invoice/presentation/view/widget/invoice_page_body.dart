import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/controller/invoice_controller.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/widget/InvoiceDesign.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/widget/invoice_listView_prodact_item.dart';

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
                Card(
                  child: ElevatedButton(
                    onPressed: controller.addItem,
                    child: const Text("إضافة منتج"),
                  ),
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
