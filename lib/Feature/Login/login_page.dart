import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/getDeviceId.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/invoice_page.dart';
import 'package:invoicepro/core/database/database_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController passwordController = TextEditingController();

  static const String mainPassword = "123456";
  static const String trialPassword = "0000";

  int remainingDays = 30;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    DatabaseHelper.ensureTrialTable();
    loadTrialStatus();

    passwordController.addListener(() {
      setState(() {});
    });
  }

  Future<void> loadTrialStatus() async {
    final trial = await DatabaseHelper.getTrial();

    if (!mounted) return;

    String? savedDate = trial?['start_date'];

    if (savedDate != null) {
      DateTime startDate = DateTime.parse(savedDate);
      int daysPassed = DateTime.now().difference(startDate).inDays;

      setState(() {
        remainingDays = (30 - daysPassed).clamp(0, 30);
      });
    } else {
      setState(() {
        remainingDays = 30;
      });
    }
  }

  Future<void> handleLogin() async {
    setState(() => isLoading = true);

    String password = passwordController.text.trim();

    bool success = false;
    String message = "";

    // تحقق من الفاضي
    if (password.isEmpty) {
      message = "ادخل كلمة المرور";
    }
    // الباسورد الأساسي
    else if (password == mainPassword) {
      success = true;
    }
    // الباسورد التجريبي
    else if (password == trialPassword) {
      final deviceId = await getDeviceId();
      await DatabaseHelper.ensureTrialTable();

      final trial = await DatabaseHelper.getTrial();

      if (trial == null) {
        // أول استخدام
        await DatabaseHelper.insertTrial(
          deviceId,
          DateTime.now().toIso8601String(),
        );

        success = true;
        message = "تم تفعيل النسخة التجريبية 30 يوم";
      } else {
        final savedDeviceId = trial['device_id'];
        final startDate = DateTime.parse(trial['start_date']);

        // تحقق من نفس الجهاز
        if (savedDeviceId != deviceId) {
          message = "غير مسموح باستخدام التجربة على جهاز آخر";
        } else {
          int daysPassed = DateTime.now().difference(startDate).inDays;

          // حماية من تغيير الوقت
          if (DateTime.now().isBefore(startDate)) {
            message = "تم التلاعب بتاريخ الجهاز";
          } else if (daysPassed < 30) {
            success = true;
          } else {
            message = "انتهت مدة التجربة";
          }
        }
      }
    }
    // باسورد غلط
    else {
      message = "كلمة المرور غير صحيحة";
    }

    setState(() => isLoading = false);

    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("تم تسجيل الدخول")));

      Get.off(() => const InvoicePage());
      passwordController.clear();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }

    loadTrialStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1E3C72), Color(0xff2A5298)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, size: 80, color: Colors.white),
            const SizedBox(height: 20),

            const Text(
              "تسجيل الدخول",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "ادخل كلمة المرور",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Text(
              "متبقي من التجربة: $remainingDays يوم",
              style: const TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("دخول", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
