import 'package:flutter/material.dart';

class ProductsTableSeaction extends StatelessWidget {
  final List items;

  const ProductsTableSeaction({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    const int maxRows = 4;

    int emptyRows = maxRows - items.length;

    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(12),
        1: FlexColumnWidth(4),
        2: FlexColumnWidth(4),
      },
      children: [
        /// Header
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
        ...List.generate(emptyRows > 0 ? emptyRows : 0, (index) {
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
