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
            style: TextStyle(fontSize: 12),
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(AssetPaths.qrCode, width: 80),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 8.h),
                  Text(": ارقام التواصل"),
                  SizedBox(height: 5.h),
                  Text("0120 3959 270", overflow: TextOverflow.ellipsis),
                  Text("0122 3017 289", overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30.h),

        const Center(
          child: Text("شكراً لزيارتكم", style: TextStyle(fontSize: 12)),
        ),
      ],
    );
  }
}
