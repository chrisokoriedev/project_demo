import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_demo/view/auth/utils.dart';
import 'package:project_demo/view/bottomnav/main_control.dart';
import 'package:project_demo/view/styles.dart';

class VerifyUser extends StatefulWidget {
  const VerifyUser({Key? key}) : super(key: key);

  @override
  State<VerifyUser> createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  bool isEmailVerified = false;
  bool canResentEmail = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerifyEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (timer) {
          checkEmailVerified();
        },
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerifyEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResentEmail = false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResentEmail = true;
      });
    } catch (e) {
      Utils.showSnackBar(e.toString(), Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const MainControlScreen()
      : Scaffold(
          appBar: AppBar(
            title: const Text('Verify Email'),
          ),
          body: Container(
            padding: kDefaultPadding,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Verification link has been sent your email,\ncheck your spam if you dont see it in your inbox',
                    style: TextStyle(fontSize: 22),
                  ),
                  sizedHeight(15),
                  TextButton(
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.resolveWith(
                            (states) => const Size(double.maxFinite, 50)),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.teal)),
                    onPressed: canResentEmail ? sendVerifyEmail : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.mail,
                          size: 20,
                          color: whiteColor,
                        ),
                        sizedWidth(20),
                        const Text(
                          'Resend Email',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.resolveWith(
                            (states) => const Size(double.maxFinite, 50)),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent)),
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.close,
                          size: 20,
                          color: whiteColor,
                        ),
                        sizedWidth(20),
                        const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
}
