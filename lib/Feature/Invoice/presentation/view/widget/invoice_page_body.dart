import 'package:flutter/material.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/widget/Button_Add_Service.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/InvoiceDesign.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/widget/customer_dataForm_section.dart';
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomerDataFormSection(),
                  ButtonAddService(
                    text: "زوايا امامى",
                    quantity: 1,
                    price: 225,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 620,
            child: Card(elevation: 10, child: InvoiceDesign()),
          ),
        ],
      ),
    );
  }
}
