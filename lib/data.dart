import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookShelf {
  final String title;
  final String imgDIr;
  final String des;

  BookShelf(this.title, this.imgDIr, this.des);
}

List<BookShelf> getBooks = [
  BookShelf('Book Lovers', 'assets/booka.jpg', 'hey'),
  BookShelf('The Paris Apartment', 'assets/bookb.jpg', 'hey'),
  BookShelf(
      'Our Missing Hearts: A Novel', 'assets/bookc.jpg', 'Book by Celeste Ng'),
  BookShelf('You Made a Fool of Death with Your Beauty', 'assets/bookd.jpg',
      'Novel by Akwaeke Emezi'),
];

class InsterestData {
  final String title;
  final Color color;
  final IconData iconData;

  InsterestData(this.title, this.color, this.iconData);
}

List<InsterestData> getInsterestList = [
  InsterestData(
      'Football', Colors.blue.withOpacity(0.7), FontAwesomeIcons.football),
  InsterestData('Reading', Colors.teal.withOpacity(0.7), FontAwesomeIcons.book),
  InsterestData(
      'Drawing', Colors.red.withOpacity(0.7), FontAwesomeIcons.paintbrush),
  InsterestData(
      'Singing', Colors.amber.withOpacity(0.7), FontAwesomeIcons.music),
];
