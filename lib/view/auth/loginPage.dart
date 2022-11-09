// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_demo/view/auth/forgotpassword.dart';
import 'package:project_demo/view/auth/utils.dart';

import '../styles.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickedSignup;
  const LoginPage({Key? key, required this.onClickedSignup}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final password = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(
              size: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Welcome back',
              style: TextStyle(fontSize: 30),
            ),
            sizedHeight(30),
            TextField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(hintText: 'Email'),
              // decoration: ,
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(hintText: 'Password'),
              textInputAction: TextInputAction.done,
            ),
            sizedHeight(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () => Get.to(const ForgotPassword()),
                    child: const Text('Forgot Password?'))
              ],
            ),
            sizedHeight(15),
            TextButton(
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.resolveWith(
                      (states) => const Size(double.maxFinite, 50)),
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.teal)),
              onPressed: signIn,
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
            sizedHeight(15),
            RichText(
              text: TextSpan(
                text: 'Dont have an account? ',
                children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignup,
                      text: 'Signup',
                      style: const TextStyle(color: Colors.teal))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(), password: password.text.trim());
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message,Colors.red);
    }
    Get.back();
  }
}
