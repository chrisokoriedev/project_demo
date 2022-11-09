import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_demo/view/mainScreen/update_password.dart';

import 'package:project_demo/view/styles.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kDefaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Setting & Privacy',
                style: TextStyle(fontSize: 25),
              ),
              sizedHeight(30),
              menu('Update Password', FontAwesomeIcons.lock,
                  () => Get.to(const UpdatePassword()))
            ],
          ),
        ),
      ),
    );
  }
}
