import 'package:flutter/material.dart';

class InvoiceNumberSaction extends StatelessWidget {
  const InvoiceNumberSaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}