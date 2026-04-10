import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoicepro/Feature/Login/presentation/controller/login_controller.dart';
import 'package:invoicepro/Feature/Login/presentation/view/widget/header_section.dart';
import 'package:invoicepro/Feature/Login/presentation/view/widget/login_button.dart';
import 'package:invoicepro/Feature/Login/presentation/view/widget/password_field.dart';

class LoginPageBody extends GetView<LoginController> {
  const LoginPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff1E3C72), Color(0xff2A5298)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const HeaderSection(),

              const SizedBox(height: 30),

              PasswordField(),

              const SizedBox(height: 25),

              LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
