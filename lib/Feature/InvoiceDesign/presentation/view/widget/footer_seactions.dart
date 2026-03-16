import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoicepro/core/utils/Asset_Paths.dart';

class FooterSeactions extends StatelessWidget {
  const FooterSeactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
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
    );
  }
}
