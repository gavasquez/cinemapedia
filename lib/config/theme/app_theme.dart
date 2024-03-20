import 'package:flutter/material.dart';

class AppTheme {
  final bool isDark;
  AppTheme({this.isDark = false});

  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: isDark ? Colors.white : Colors.blue,
      brightness: isDark ? Brightness.dark : Brightness.light);

  AppTheme copyWith({
    bool? isDark,
  }) =>
      AppTheme(isDark: isDark ?? this.isDark);
}
