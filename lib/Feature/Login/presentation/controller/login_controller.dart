import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/usecase/login_usecase.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  LoginController(this.loginUseCase);

  final passwordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> loginAction() async {
    isLoading.value = true;

    final (success, message) = await loginUseCase(
      passwordController.text.trim(),
    );

    isLoading.value = false;

    if (success) {
      Get.offAllNamed('/ivoice');
    } else {
      Get.snackbar(
        "خطأ",
        message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
