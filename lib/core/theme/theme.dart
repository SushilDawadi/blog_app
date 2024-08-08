import 'package:blog_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppColor.secondaryColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppColor.primaryColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(27),
        enabledBorder: _border(),
        focusedBorder: _border(AppColor.focusColor),
      ));
}
