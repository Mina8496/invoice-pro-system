import 'package:flutter/material.dart';

class InvoiceDesign extends StatelessWidget {
  const InvoiceDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// اسم المحل
            const Center(
              child: Text(
                "اسم المحل",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            const Text("رقم الفاتورة: 1025"),
            const Text("التاريخ: 06-03-2026"),

            const Divider(),

            /// عناوين الجدول
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("المنتج"),
                Text("الكمية"),
                Text("السعر"),
                Text("الإجمالي"),
              ],
            ),

            const Divider(),

            /// مثال منتج
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("شيبسي"),
                Text("2"),
                Text("10"),
                Text("20"),
              ],
            ),

            const SizedBox(height: 6),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text("كولا"), Text("1"), Text("15"), Text("15")],
            ),

            const Divider(),

            /// الإجمالي
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                "الإجمالي: 35 جنيه",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),

            const SizedBox(height: 10),

            /// رسالة
            const Center(child: Text("شكراً لزيارتكم")),
          ],
        ),
      ),
    );
  }
}
