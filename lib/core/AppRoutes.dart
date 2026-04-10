import 'package:get/get.dart';
import 'package:invoicepro/Feature/Invoice/presentation/view/invoice_page.dart';
import 'package:invoicepro/Feature/Login/presentation/view/login_page.dart';
import 'package:invoicepro/Feature/Login/presentation/login_binding/login_binding.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: '/login',
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '/ivoice',
      page: () => const InvoicePage(),
    ),
  ];
}