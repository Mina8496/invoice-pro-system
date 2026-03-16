import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/featured_invoices_cubit.dart';
import 'package:invoicepro/core/utils/Asset_Paths.dart';
import 'package:invoicepro/core/utils/widgets/app_textView.dart';

class InvoiceDesign extends StatelessWidget {
  const InvoiceDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          // width: 595  - A4
          constraints: const BoxConstraints(maxWidth: 595),
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// HEADER
              Row(
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
              ),
              SizedBox(height: 25.h),

              ///INVOICE NUMBER
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(border: Border.all()),
                      child: const Text(
                        "0000005170",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// CUSTOMER DATA
              Text("اسم العميل : احمد سليمان", textAlign: TextAlign.start),
              Text("التليفون : 01020133108"),

              const SizedBox(height: 10),

              Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 10,
                runSpacing: 5,
                children: const [
                  Text("RX5 plus : الموديل"),
                  Text("MG : الماركة"),
                  Text("رقم اللوحة : ل ك ع 2741"),
                ],
              ),

              const SizedBox(height: 10),
              Text(":  ملاحطة"),
              const SizedBox(height: 10),

              /// PRODUCTS TABLE
              BlocBuilder<FeaturedInvoicesCubit, FeaturedInvoicesState>(
                builder: (context, state) {
                  final cubit = context.read<FeaturedInvoicesCubit>();

                  return Table(
                    border: TableBorder.all(),
                    columnWidths: const {
                      0: FlexColumnWidth(12),
                      1: FlexColumnWidth(4),
                      2: FlexColumnWidth(4),
                    },
                    children: [
                      const TableRow(
                        decoration: BoxDecoration(color: Color(0xffeeeeee)),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text("البيان", textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text("الكمية", textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text("السعر", textAlign: TextAlign.center),
                          ),
                        ],
                      ),

                      ...cubit.items.map((item) {
                        return TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                item.name,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                item.quantity.toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                item.price.toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  );
                },
              ),

              /// TOTALS
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 190,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Text(
                              "${context.watch<FeaturedInvoicesCubit>().total}",
                            ),
                            const Text(":السعر المطلوب"),
                          ],
                        ),
                      ),
                      const Divider(height: 1),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15.h),
              Divider(color: Colors.black, thickness: 1, height: 1),

              SizedBox(height: 15.h),

              /// FOOTER
              const Center(
                child: Text(
                  "مراجعة الزوايا : 15 يوم  - استكمال الزوايا خلال 3 اشهر بفاتورة الكشف عند استكمال الزوايا يتم اخذ دور جديد",
                  style: TextStyle(fontSize: 10),
                ),
              ),
              SizedBox(height: 25.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(AssetPaths.qrCode, width: 80),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 10.h),
                        Text(": ارقام التواصل"),
                        SizedBox(height: 10.h),
                        Text("632541256321", overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),

              const Center(
                child: Text("شكراً لزيارتكم", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
