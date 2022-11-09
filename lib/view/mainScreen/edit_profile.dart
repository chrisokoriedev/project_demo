import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:project_demo/view/bottomnav/main_control.dart';
import 'package:project_demo/view/styles.dart';

import '../auth/utils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final emailController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    usernameController.text = user.displayName.toString();
    emailController.text = user.email.toString();
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
          .updateDisplayName(usernameController.text.trim());
      await FirebaseAuth.instance.currentUser!
          .updateEmail(emailController.text.trim());
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
                  'Edit Profile',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                sizedHeight(110),
                TextFormField(
                  initialValue: user.displayName,
                  textInputAction: TextInputAction.next,
                  decoration:
                      customInputdeco().copyWith(hintText: 'add username '),
                  onChanged: (value) {
                    setState(() {
                      usernameController.text = value;
                    });
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 6
                      ? 'Enter min 6 character'
                      : null,
                ),
                sizedHeight(20),
                TextFormField(
                  initialValue: user.email,
                  textInputAction: TextInputAction.next,
                  decoration: customInputdeco(),
                  onChanged: (value) {
                    setState(() {
                      emailController.text = value;
                    });
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      value != null && !EmailValidator.validate(value)
                          ? 'Enter value email'
                          : null,
                ),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   decoration: BoxDecoration(
                //     color: geryColor.withOpacity(0.3),
                //     border: Border.all(
                //       color: geryColor,
                //     ),
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: Stack(
                //     children: [
                //       InternationalPhoneNumberInput(
                //         initialValue:
                //             PhoneNumber(phoneNumber: user.phoneNumber.toString()),
                //         textFieldController: phoneNumberController,
                //         onInputValidated: (bool value) => print(value),
                //         autoValidateMode: AutovalidateMode.disabled,
                //         ignoreBlank: false,
                //         onInputChanged: (value) {},
                //         cursorColor: whiteColor,
                //         formatInput: false,
                //         selectorConfig: const SelectorConfig(
                //           selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                //         ),
                //         textStyle: const TextStyle(color: whiteColor),
                //         inputDecoration: const InputDecoration(
                //           isCollapsed: true,
                //           border: InputBorder.none,
                //           hintText: 'Phone number',
                //           hintStyle: TextStyle(
                //             color: whiteColor,
                //           ),
                //           contentPadding: EdgeInsets.symmetric(vertical: 10),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                sizedHeight(30),
                TextButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.resolveWith(
                          (states) => const Size(double.maxFinite, 50)),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.teal)),
                  onPressed: update,
                  child: const Text(
                    'Update profile',
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
