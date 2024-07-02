import 'package:flutter/material.dart';

const primaryColor = Color(0xff082659);
const secondaryColor = Color.fromARGB(255, 10, 10, 10);

final appTheme = ThemeData(
    appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: secondaryColor, fontWeight: FontWeight.bold, fontSize: 30)),
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStatePropertyAll<TextStyle>(
                TextStyle(fontSize: 20)),
            iconColor: MaterialStatePropertyAll<Color>(secondaryColor))),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: primaryColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor, foregroundColor: secondaryColor),
    inputDecorationTheme: const InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: primaryColor),
        iconColor: secondaryColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: secondaryColor),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(8)))));
