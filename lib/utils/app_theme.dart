import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const darkGreen = Color(0xFF13221C);
const lightGreen = Color(0xFF439668);
const lightGrey = Color(0xFF98A1A6);
const darkGrey = Color(0xFF2C2C2C);
const green = Color(0xFF2A3A33);

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: lightGreen),
  useMaterial3: true,
  canvasColor: darkGreen,
  textTheme: GoogleFonts.robotoTextTheme().copyWith(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    headlineLarge: TextStyle(color: Colors.white),
    headlineMedium: TextStyle(color: Colors.white), 
    headlineSmall: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: Colors.white),
    labelLarge: TextStyle(color: Colors.white),
    labelMedium: TextStyle(color: Colors.white),
    labelSmall: TextStyle(color: Colors.white),
    displayLarge: TextStyle(color: Colors.white),
    displayMedium: TextStyle(color: Colors.white),
    displaySmall: TextStyle(color: Colors.white),
  ),
  scaffoldBackgroundColor: darkGreen,
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Colors.transparent,
    backgroundColor: darkGreen,
    foregroundColor: Colors.white,
    centerTitle: false,
    elevation: 0,
    iconTheme: IconThemeData(color: lightGrey),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(color: lightGrey),
    filled: true,
    fillColor: darkGrey,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      borderSide: BorderSide.none,
    ),
  ),
);
