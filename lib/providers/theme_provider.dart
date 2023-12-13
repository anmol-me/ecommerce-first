import 'package:flutter/material.dart';

class ThemeProvider {
  ThemeData theme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        // color: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Colors.black,
        height: 70,
      ),
    );
  }
}
