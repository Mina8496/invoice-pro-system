import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/controller/invoice_controller.dart';


class InvoiceListViewProdactItem extends StatelessWidget {
  const InvoiceListViewProdactItem({
    super.key,
    required this.controller,
  });

  final InvoiceController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx( 
        () =>ListView.builder(
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            final item = controller.items[index];
    
            return Card(
              child: ListTile(
                title: Text(item.customerName),
                subtitle: Text(
                  "الكمية: ${item.items} | السعر: ${item.carBrand}",
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => controller.removeItem(index),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}