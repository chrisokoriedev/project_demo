import 'package:flutter/material.dart';
import 'package:project_demo/view/auth/loginPage.dart';
import 'package:project_demo/view/auth/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? LoginPage(onClickedSignup: toggle)
      : SignupPage(onClickedSigin: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
