import 'package:flutter/material.dart';

final messengerKey = GlobalKey<ScaffoldMessengerState>();

class Utils {
  static showSnackBar(String? text,Color color) {
    if (text == null) return;
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: color.withOpacity(0.7),
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
