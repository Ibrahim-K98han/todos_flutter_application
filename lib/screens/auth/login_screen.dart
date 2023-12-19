import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos_flutter_application/routes.dart';
import 'package:todos_flutter_application/widgets/custom_textfield.dart';

import '../../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 120,
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
                height: 50,
              ),
              const CustomTextField(
                hint: 'Email',
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomTextField(
                hint: 'Password',
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                label: 'Login',
                onPressed: () {
                  Get.offAllNamed(Routes.home);
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
                      text: 'Don\'t have an account? ',
                    ),
                    TextSpan(
                      text: 'Sign Up',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed(Routes.signup);
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
          ),
        ),
      ),
    );
  }
}
