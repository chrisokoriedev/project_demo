import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_demo/view/auth/utils.dart';
import 'package:project_demo/view/styles.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Recieve an email to reset password',
                style: TextStyle(fontSize: 25),
              ),
              sizedHeight(30),
              TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'Email'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    value != null && !EmailValidator.validate(value)
                        ? 'Enter value email'
                        : null,
                // decoration: ,
              ),
              const SizedBox(
                height: 15,
              ),
              TextButton(
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.resolveWith(
                        (states) => const Size(double.maxFinite, 50)),
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.teal)),
                onPressed: forgotPassowrd,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.mail),
                    SizedBox(width: 20),
                    Text(
                      'Reset Password',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              sizedHeight(30),
            ],
          ),
        ),
      ),
    );
  }

  Future forgotPassowrd() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar('Password reset email sent', Colors.teal);
      Get.back();
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message, Colors.red);
    }
    Get.back();
  }
}
