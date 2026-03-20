import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_item_entity.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/featured_invoices_cubit.dart';
import 'package:invoicepro/core/utils/Asset_Paths.dart';
import 'package:invoicepro/core/utils/widgets/app_textView.dart';

class ButtonAddService extends StatelessWidget {
  final String text;
  final int quantity;
  final double price;

  const ButtonAddService({
    super.key,
    required this.text,
    required this.quantity,
    required this.price,
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
          onTap: () {
            context.read<FeaturedInvoicesCubit>().addItem(
              InvoiceItemEntity(
                name: "زوايا امامى",
                quantity: quantity,
                price: price,
              ),
            );
          },
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
