import 'package:flutter/material.dart';

final Map<String, List<String>> avatarCategories = {
  'bayern': [
    'a1.png',
    'a2.png',
    'a3.png',
    'a4.png',
    'a5.png',
    'a6.png',
    'a7.png',
    'a8.png',
    'a9.png'
  ],
  'kaufbeuren': [
    'a1.png',
    'a2.png',
    'a3.png',
    'a4.png',
    'a5.png',
    'a6.png',
    'a7.png',
    'a8.png',
    'a9.png'
  ],
  'freelogo': [
    'a1.png',
    'a2.png',
    'a3.png',
    'a4.png',
    'a5.png',
    'a6.png',
    'a7.png',
    'a8.png',
    'a9.png'
  ],
  'goldenstate': [
    'a1.png',
    'a2.png',
    'a3.png',
    'a4.png',
    'a5.png',
    'a6.png',
    'a7.png',
    'a8.png',
    'a9.png'
  ],
};

final Map<String, Widget> categoryIcons = {
  'bayern': const SizedBox(
    width: 32,
    height: 32,
    child: Image(
        image: AssetImage(
            "assets/images_avatar/icon_club_logo/icon_fcbayern.png")),
  ),
  'kaufbeuren': const SizedBox(
    width: 32,
    height: 32,
    child: Image(
        image: AssetImage(
            "assets/images_avatar/icon_club_logo/icon_djkkaufbeuren.png")),
  ),
  'freelogo': const SizedBox(
    width: 32,
    height: 32,
    child: Image(
        image: AssetImage(
            "assets/images_avatar/icon_club_logo/icon_freelogo.png")),
  ),
  'goldenstate': const SizedBox(
    width: 32,
    height: 32,
    child: Image(
        image: AssetImage(
            "assets/images_avatar/icon_club_logo/icon_golden_state.png")),
  ),
};
