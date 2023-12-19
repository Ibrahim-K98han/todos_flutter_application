import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
              const CustomTextField(
                hint: 'Name',
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomTextField(
                hint: 'Address',
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomTextField(
                hint: 'Contact',
              ),
              const SizedBox(
                height: 10,
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
                height: 10,
              ),
              const CustomTextField(
                hint: 'Confirm Password',
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                label: 'Sign Up',
                onPressed: () {},
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
          ),
        ),
      ),
    );
  }
}
