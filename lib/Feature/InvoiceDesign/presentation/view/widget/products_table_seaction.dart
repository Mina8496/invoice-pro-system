import 'package:flutter/material.dart';

class ProductsTableSeaction extends StatelessWidget {
  final List items;

  const ProductsTableSeaction({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    const int maxRows = 8; // عدد الصفوف الثابت

    final int emptyRows = (maxRows - items.length).clamp(0, maxRows);

    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(10),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3),
      },
      children: [
        /// HEADER
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

        /// البيانات
        ...items.map((item) {
          return TableRow(
            children: [
              cell(item.name),
              cell(item.quantity.toString()),
              cell(item.price.toString()),
            ],
          );
        }),

        /// الصفوف الفاضية
        ...List.generate(emptyRows, (index) {
          return TableRow(children: [cell(""), cell(""), cell("")]);
        }),
      ],
    );
  }

  Widget cell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(text, textAlign: TextAlign.center),
    );
  }
}
