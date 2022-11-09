import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_demo/data.dart';
import 'package:project_demo/view/mainScreen/edit_profile.dart';
import 'package:project_demo/view/mainScreen/setting.dart';
import 'package:project_demo/view/styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: kDefaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Profile',
                style: TextStyle(fontSize: 30),
              ),
              sizedHeight(20),
              Container(
                padding: kDefaultPadding,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      
                        colorFilter: ColorFilter.mode(
                            primayColor.withOpacity(0.3), BlendMode.darken),
                        image: const AssetImage('assets/coverpage.jpg'),
                        fit: BoxFit.cover)),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: primayColor),
                          child: const FlutterLogo(
                            size: 80,
                          ),
                        ),
                        sizedWidth(30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              user.displayName == null
                                  ? 'Add username'
                                  : user.displayName.toString(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(user.email!)
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () => Get.to(const EditProfile()),
                        icon: const Icon(
                          FontAwesomeIcons.pen,
                          size: 18,
                        ))
                  ],
                ),
              ),
              sizedHeight(30),
              const Text(
                'Insterest',
                style: TextStyle(fontSize: 20),
              ),
              sizedHeight(10),
              SizedBox(
                width: 900,
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getInsterestList.length,
                  itemBuilder: (context, index) {
                    final data = getInsterestList[index];
                    return Container(
                      margin: const EdgeInsets.only(right: 20),
                      width: 110,
                      decoration: BoxDecoration(
                          color: data.color,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(data.iconData),
                          sizedWidth(5),
                          Text(data.title)
                        ],
                      ),
                    );
                  },
                ),
              ),
              sizedHeight(30),
              menu('Setting', FontAwesomeIcons.gear,
                  () => Get.to(const SettingScreen())),
              sizedHeight(20),
              menu(
                'Logout',
                FontAwesomeIcons.doorOpen,
                () => FirebaseAuth.instance.signOut(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  menu(String title, IconData iconData, VoidCallback press) {
    return InkWell(
      onTap: press,
      child: Container(
        width: double.infinity,
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Icon(iconData),
              sizedWidth(20),
              Text(
                title,
                style: const TextStyle(fontSize: 20),
              )
            ]),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            )
          ],
        ),
      ),
    );
  }
}
