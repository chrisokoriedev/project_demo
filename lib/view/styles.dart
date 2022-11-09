import 'package:flutter/material.dart';

const kDefaultPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 20);
const whiteColor = Colors.white;
const blackColor = Colors.black;
const geryColor = Colors.grey;
const primayColor = Colors.teal;
SizedBox sizedHeight(double height) => SizedBox(
      height: height,
    );
SizedBox sizedWidth(double width) => SizedBox(
      width: width,
    );
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
            Icon(
              iconData,
              size: 18,
            ),
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
