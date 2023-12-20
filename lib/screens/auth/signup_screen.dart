import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos_flutter_application/controllers/signup_controller.dart';

import '../../routes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GetBuilder<SignupController>(builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'My TODO',
                    style: TextStyle(
                      fontSize: 54,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  hint: 'Name',
                  controller: controller.nameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Address',
                  controller: controller.addressController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Contact',
                  controller: controller.contactController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Email',
                  controller: controller.emailController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Password',
                  obscureText: true,
                  controller: controller.passwordController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Confirm Password',
                  obscureText: true,
                  controller: controller.confirmPasswordController,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  label: 'Sign Up',
                  onPressed: () {
                    controller.checkSignup();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Already have an account? ',
                      ),
                      TextSpan(
                        text: 'Login',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(Routes.login);
                          },
                        style: const TextStyle(
                          color: Color(0xff6b7afc),
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
