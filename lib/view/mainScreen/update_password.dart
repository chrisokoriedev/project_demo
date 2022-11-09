import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_demo/view/bottomnav/main_control.dart';
import 'package:project_demo/view/styles.dart';

import '../auth/utils.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final passowordController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    passowordController.dispose();
    super.dispose();
  }

  Future update() async {
    final isVaild = formKey.currentState!.validate();
    if (!isVaild) return;
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.currentUser!
          .updatePassword(passowordController.text.trim());

      Get.off(const MainControlScreen());

      Utils.showSnackBar('Updated', Colors.teal);
    } on FirebaseAuthException catch (e) {
      Get.back();
      Utils.showSnackBar(e.message, Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Container(
            padding: kDefaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Update password',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                sizedHeight(110),
                TextFormField(
                  controller: passowordController,
                  textInputAction: TextInputAction.next,
                  decoration: customInputdeco(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 6
                      ? 'Enter min 6 character'
                      : null,
                ),
                sizedHeight(30),
                TextButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.resolveWith(
                          (states) => const Size(double.maxFinite, 50)),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.teal)),
                  onPressed: update,
                  child: const Text(
                    'Update Pasowrod',
                    style: TextStyle(color: whiteColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration customInputdeco() {
    return InputDecoration(
        isCollapsed: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.3),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)));
  }
}
