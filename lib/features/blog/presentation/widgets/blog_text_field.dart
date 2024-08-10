import 'package:flutter/material.dart';

class BlogTextField extends StatelessWidget {
  const BlogTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.text});

  final TextEditingController controller;
  final String hintText;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => value!.isEmpty ? '$text is missing!' : null,
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
