import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todos_flutter_application/models/user_model.dart';
import 'package:todos_flutter_application/utils/shared_prefs.dart';
import '../routes.dart';
import '../utils/baseurl.dart';
import '../utils/custom_snackbar.dart';
import '../widgets/loader.dart';

class LoginController extends GetxController {
  late TextEditingController emailController, passwordController;
  @override
  void onInit() {
    checkUser();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  checkUser() async {
    var user = SharedPrefs().getUser();
    if (user != null) {
      Get.to(Routes.home);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  checkLogin() {
    if (emailController.text.isEmpty ||
        GetUtils.isEmail(emailController.text) == false) {
      customSnackbar('Error', 'A Valid email is required', 'error');
    } else if (passwordController.text.isEmpty) {
      customSnackbar('Error', 'Password is required', 'error');
    } else {
      Get.showOverlay(
          asyncFunction: () => login(), loadingWidget: const Loader());
    }
  }

  login() async {
    var response = await http.post(Uri.parse('${baseurl}login.php'), body: {
      'email': emailController.text,
      'password': passwordController.text,
    });
    var res = await json.decode(response.body);
    if (res['success']) {
      customSnackbar('Success', res['message'], 'success');
      UserModel userModel = UserModel.fromJson(res['user']);
      await SharedPrefs().storeUser(json.encode(userModel));
      Get.offAllNamed(Routes.home);
    } else {
      customSnackbar('Error', res['message'], 'error');
    }
  }
}
