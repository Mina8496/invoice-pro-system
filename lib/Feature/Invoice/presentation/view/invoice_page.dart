import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoicepro/Feature/Invoice/domin/usecase/calculate_total.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/controller/invoice_controller.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/widget/invoice_page_body.dart';

class InvoicePage extends StatelessWidget {
  InvoicePage({super.key});

  final controller = Get.put(InvoiceController(CalculateTotal()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: InvoicePageBody());
  }
}
