import 'package:flutter/material.dart';

class BlogTextField extends StatelessWidget {
  BlogTextField({super.key, required this.hintText});

  final TextEditingController controller = TextEditingController();
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: null,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
      ),
    );
  }
}
