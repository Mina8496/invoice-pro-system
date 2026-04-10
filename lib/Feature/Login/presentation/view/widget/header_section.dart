import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Icon(Icons.lock, size: 80, color: Colors.white),
        SizedBox(height: 20),
        Text(
          "تسجيل الدخول",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}