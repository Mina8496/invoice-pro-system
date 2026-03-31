import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicepro/Feature/Invoice/data/models/service_item.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_item_entity.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/featured_invoices_cubit.dart';
import 'package:invoicepro/core/utils/Asset_Paths.dart';
import 'package:invoicepro/core/utils/widgets/app_textView.dart';

class ServicesSection extends StatefulWidget {
  final List<ServiceItem> services;

  const ServicesSection({super.key, required this.services});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  void showOptions(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                context.read<FeaturedInvoicesCubit>().removeItem(index);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void editService(int index) {
    final item = widget.services[index];

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
              context.read<FeaturedInvoicesCubit>().updateService(
                index,
                ServiceItem(
                  name: nameController.text,
                  quantity: item.quantity,
                  price: double.parse(priceController.text),
                ),
              );
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
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.services.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 1200
            ? 5
            : 3, // 2 في الصف
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        // childAspectRatio: 1.1, // شكل الكارت
      ),
      itemBuilder: (context, index) {
        final item = widget.services[index];

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
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.09,
                    child: Image.asset(AssetPaths.logo, fit: BoxFit.cover),
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
          ),
        );
      },
    );
  }
}
