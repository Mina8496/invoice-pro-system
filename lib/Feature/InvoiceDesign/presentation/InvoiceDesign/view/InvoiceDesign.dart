import 'package:flutter/material.dart';
import 'package:invoicepro/core/utils/Asset_Paths.dart';
import 'package:invoicepro/core/utils/widgets/app_textView.dart';

class InvoiceDesign extends StatelessWidget {
  const InvoiceDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 595, // A4 width
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(AssetPaths.logo, width: 80),
                    const SizedBox(width: 5),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText(
                      text: "اسامة زعتر",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 10),
                    Text("رقم الفاتورة: 5170"),
                    Text("تحرير في يوم : 2026/02/20"),

                    // Text("رقم السجل التجاري: 28484"),
                    // Text("رقم التسجيل الضريبي: 10011015"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 25),

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
                      "0000004976",
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

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("RX5 plus : الموديل"),
                Text("MG : الماركة"),
                Text("رقم اللوحة : ل ك ع 2741"),
              ],
            ),

            const SizedBox(height: 10),
            Text(":  ملاحطة"),
            const SizedBox(height: 10),

            /// PRODUCTS TABLE
            Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(12),
                1: FlexColumnWidth(4),
                2: FlexColumnWidth(4),
              },
              children: [
                /// HEADER
                const TableRow(
                  decoration: BoxDecoration(color: Color(0xffeeeeee)),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "البيـــــــان",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "الكمية",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "السعر",
                        textAlign: TextAlign.center,

                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                /// PRODUCT
                const TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("زوايا امامى", textAlign: TextAlign.center),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("1", textAlign: TextAlign.center),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("225", textAlign: TextAlign.center),
                    ),
                  ],
                ),
                const TableRow(
                  children: [
                    Padding(padding: EdgeInsets.all(8), child: Text("")),
                    Padding(padding: EdgeInsets.all(8), child: Text("")),
                    Padding(padding: EdgeInsets.all(8), child: Text("")),
                  ],
                ),
                const TableRow(
                  children: [
                    Padding(padding: EdgeInsets.all(8), child: Text("")),
                    Padding(padding: EdgeInsets.all(8), child: Text("")),
                    Padding(padding: EdgeInsets.all(8), child: Text("")),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 5),

            /// TOTALS
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 190,
                decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("225"), Text(":السعر المطلوب")],
                      ),
                    ),
                    Divider(height: 1),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),
            Divider(color: Colors.black, thickness: 1, height: 1),

            const SizedBox(height: 15),

            /// FOOTER
            const Center(
              child: Text(
                "مراجعة الزوايا : 15 يوم  - استكمال الزوايا خلال 3 اشهر بفاتورة الكشف عند استكمال الزوايا يتم اخذ دور جديد",
                style: TextStyle(fontSize: 10),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(AssetPaths.qrCode, width: 80),
                    const SizedBox(width: 5),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // AppText(
                    //   text: "اسامة زعتر",
                    //   fontSize: 15,
                    //   fontWeight: FontWeight.bold,
                    // ),
                    SizedBox(height: 10),
                    Text(": ارقام التواصل"),
                    SizedBox(height: 10),
                    Text("632541256321"),

                    // Text("رقم السجل التجاري: 28484"),
                    // Text("رقم التسجيل الضريبي: 10011015"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),

            const Center(
              child: Text("شكراً لزيارتكم", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
