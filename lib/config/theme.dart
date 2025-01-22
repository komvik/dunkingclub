import 'package:dunkingclub/config/theme_dark_elevatedbutton.dart';
import 'package:dunkingclub/config/theme_dark_scaffold.dart';
import 'package:dunkingclub/config/theme_dark_textfield.dart';
import 'package:dunkingclub/config/theme_dart_snackbar.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,

//________________
  snackBarTheme: customSnackBarTheme,
//________________
  scaffoldBackgroundColor: customScaffoldTheme.scaffoldBackgroundColor,
//________________
  appBarTheme: customScaffoldTheme.appBarTheme,
//________________
  inputDecorationTheme: customTextFieldTheme,
//________________
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: customElevatedButtonStyle,
  ),
//________________
);
