import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicepro/Feature/Invoice/data/models/service_item.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/featured_invoices_cubit.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/invoice_state.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/widget/services_section.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/InvoiceDesign.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/widget/customer_dataForm_section.dart';
import 'package:invoicepro/Feature/InvoiceDesign/presentation/view/widget/items_list_section.dart';
import 'package:invoicepro/core/utils/Asset_Paths.dart';

class InvoicePageBody extends StatelessWidget {
  final List<ServiceItem> services;
  const InvoicePageBody({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
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
                    const CustomerDataFormSection(),
                    const SizedBox(height: 10),
                    BlocBuilder<FeaturedInvoicesCubit, InvoiceState>(
                      builder: (context, state) {
                        final cubit = context.read<FeaturedInvoicesCubit>();

                        return ServicesSection(services: cubit.state.services);
                      },
                    ),

                    const SizedBox(height: 10),
                    const ItemsListSection(),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 620,
                  child: Card(elevation: 10, child: InvoiceDesign()),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
