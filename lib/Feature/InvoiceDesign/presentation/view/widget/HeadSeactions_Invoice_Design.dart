import 'package:flutter/material.dart';
import 'package:invoicepro/core/utils/Asset_Paths.dart';
import 'package:invoicepro/core/utils/widgets/app_textView.dart';

class HeadSeactionsInvoiceDesign extends StatelessWidget {
  const HeadSeactionsInvoiceDesign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(AssetPaths.logo, width: 80),
        const SizedBox(width: 10),
    
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText(
                text: "اسامة زعتر",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 10),
              Text("رقم الفاتورة: 54455"),
              Text("تحرير في يوم : 2026/02/20"),
            ],
          ),
        ),
      ],
    );
  }
}