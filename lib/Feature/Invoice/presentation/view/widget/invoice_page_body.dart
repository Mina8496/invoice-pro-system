import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/controller/invoice_controller.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/widget/Button_Add_Service.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/widget/InvoiceDesign.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/widget/invoice_listView_prodact_item.dart';
import 'package:invoicepro/utils/Asset_Paths.dart';

class InvoicePageBody extends GetView<InvoiceController> {
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
                  ButtonAddService(controller: controller, text: "زوايا امامى"),
                  ButtonAddService(controller: controller, text: "زوايا خلفى"),
                  ButtonAddService(
                    controller: controller,
                    text: "زوايا امامى وخلفى",
                  ),
                  ButtonAddService(
                    controller: controller,
                    text: "زوايا زوجينة",
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
      ),
    );
  }
}
