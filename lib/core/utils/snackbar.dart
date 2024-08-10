import 'package:flutter/material.dart';
import 'package:blog_app/core/theme/app_color.dart';

void showCustomSnackBar(BuildContext context, String message,
    {bool isError = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: ShapeBorder.lerp(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          1,
        ),
        content: Text(
          message,
          style: TextStyle(
              color: isError ? AppColor.white : AppColor.primaryColor),
        ),
        backgroundColor: isError ? Colors.red : AppColor.subtleColor,
        action: SnackBarAction(
          label: 'DISMISS',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          textColor: isError ? AppColor.white : AppColor.primaryColor,
        ),
      ),
    );
}
 