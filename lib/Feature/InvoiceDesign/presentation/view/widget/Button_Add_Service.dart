import 'package:flutter/material.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/controller/invoice_controller.dart';
import 'package:invoicepro/core/utils/Asset_Paths.dart';
import 'package:invoicepro/core/utils/widgets/app_textView.dart';

class ButtonAddService extends StatelessWidget {
  final String text;
  final InvoiceController controller;

  const ButtonAddService({
    super.key,
    required this.controller,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: GestureDetector(
          onTap: controller.addItem,
          child: Stack(
            children: [
              Opacity(
                opacity: 0.09,
                child: Image.asset(AssetPaths.logo, fit: BoxFit.cover),
              ),
              Center(
                child: AppText(
                  text: text,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
