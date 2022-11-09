import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_demo/view/auth/utils.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback onClickedSigin;

  const SignupPage({Key? key, required this.onClickedSigin}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final password = TextEditingController();
  final confrimPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    password.dispose();
    confrimPassword.dispose();
    super.dispose();
  }

  Future signUp() async {
    final isVaild = formKey.currentState!.validate();
    if (!isVaild) return;
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(), password: password.text.trim());
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message,Colors.red);
    }
    Get.back();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
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
                'Welcome',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'Email'),
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    value != null && !EmailValidator.validate(value)
                        ? 'Enter value email'
                        : null,
              ),
              TextFormField(
                controller: password,
                decoration: const InputDecoration(hintText: 'Password'),
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? 'Enter min 6 character'
                    : null,
              ),
              TextFormField(
                controller: confrimPassword,
                decoration: const InputDecoration(hintText: 'Confrim Password'),
                textInputAction: TextInputAction.done,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    value != null && confrimPassword.text != password.text
                        ? 'Password dont match'
                        : null,
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.resolveWith(
                        (states) => const Size(double.maxFinite, 50)),
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.teal)),
                onPressed: signUp,
                child: const Text('Sign up'),
              ),
              const SizedBox(height: 30),
              RichText(
                  text: TextSpan(text: 'Already have an account? ', children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSigin,
                    text: 'Login',
                    style: const TextStyle(color: Colors.teal))
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
