import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final cEmail = TextEditingController();
  final cPass = TextEditingController();

  get StreamAuthStatus => null;

  @override
  void onClose() {
    cEmail.dispose();
    cPass.dispose();
    super.onClose;
  }
}
