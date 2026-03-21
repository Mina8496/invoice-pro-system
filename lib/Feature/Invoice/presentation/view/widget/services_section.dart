import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicepro/Feature/Invoice/data/models/service_item.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_item_entity.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/featured_invoices_cubit.dart';
import 'package:invoicepro/core/utils/Asset_Paths.dart';
import 'package:invoicepro/core/utils/widgets/app_textView.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  List<ServiceItem> services = [];

  void addServiceDialog() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          // 👈 مربع
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text("إضافة خدمة"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "اسم الخدمة"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "السعر"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  priceController.text.isNotEmpty) {
                setState(() {
                  services.add(
                    ServiceItem(
                      name: nameController.text,
                      quantity: 1,
                      price: double.parse(priceController.text),
                    ),
                  );
                });
                Navigator.pop(context);
              }
            },
            child: Text("إضافة"),
          ),
        ],
      ),
    );
  }

  void showOptions(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          // 👈 مربع
          borderRadius: BorderRadius.circular(8),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("تعديل"),
              onTap: () {
                Navigator.pop(context);
                editService(index);
              },
            ),
            ListTile(
              title: Text("حذف"),
              onTap: () {
                setState(() {
                  services.removeAt(index);
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void editService(int index) {
    final item = services[index];

    final nameController = TextEditingController(text: item.name);
    final priceController = TextEditingController(text: item.price.toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text("تعديل"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController),
            SizedBox(height: 10),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                item.name = nameController.text;
                item.price = double.parse(priceController.text);
              });
              Navigator.pop(context);
            },
            child: Text("حفظ"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// زر الإضافة
        ElevatedButton(onPressed: addServiceDialog, child: Text("إضافة بند")),

        SizedBox(height: 10),

        /// القائمة
        ListView.builder(
          // scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final item = services[index];

            return GestureDetector(
              onTap: () {
                context.read<FeaturedInvoicesCubit>().addItem(
                  InvoiceItemEntity(
                    name: item.name,
                    quantity: item.quantity,
                    price: item.price,
                  ),
                );
              },
              onLongPress: () => showOptions(index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: 0.09,
                          child: Image.asset(
                            AssetPaths.logo,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Center(
                          child: AppText(
                            text: item.name,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ListTile(
                  //   title: Text(),
                  //   subtitle: Text("الكمية: ${item.quantity}"),
                  //   trailing: Text("${item.price} ج"),
                  // ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
