import 'package:flutter/material.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/widget/services_section.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/InvoiceDesign.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/widget/customer_dataForm_section.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/widget/items_list_section.dart';
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
                children: const [
                  CustomerDataFormSection(),
                  SizedBox(height: 10),
                  ServicesSection(),
                  SizedBox(height: 10),
                  ItemsListSection(),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 620,
              child: Card(elevation: 10, child: InvoiceDesign()),
            ),
          ),
          const SizedBox(width: 10),
          // زر حفظ وطباعة
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                // هنا سيتم استدعاء دالة حفظ الفاتورة
                _saveAndPrintInvoice(context);
              },
              child: Text("حفظ وطباعة"),
            ),
          ),
        ],
      ),
    );
  }

  void _saveAndPrintInvoice(BuildContext context) {
    // قم بتنفيذ منطق حفظ الفاتورة هنا
    // يمكنك استدعاء دالة من الـ Cubit لحفظ الفاتورة
    // وعند الانتهاء، يمكنك تنفيذ منطق الطباعة

    // على سبيل المثال:
    // context.read<FeaturedInvoicesCubit>().saveInvoice();
    // ثم قم بإضافة منطق الطباعة هنا.
  }
}