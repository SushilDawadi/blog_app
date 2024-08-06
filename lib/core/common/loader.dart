import 'package:flutter/material.dart';
import 'package:blog_app/core/theme/app_color.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColor.accentColor),
        backgroundColor: AppColor.subtleColor,
        strokeWidth: 4.0,
      ),
    );
  }
}
