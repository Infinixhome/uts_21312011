import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  final cAuth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignupView'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: controller.cEmail,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            TextField(
              controller: controller.cPass,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => cAuth.signup(
                controller.cEmail.text,
                controller.cPass.text,
              ),
              child: Text("Login"),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
