import 'dart:io';

import 'package:blog_app/core/theme/app_color.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddBlogPage extends StatefulWidget {
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  List<String> selectedTag = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> tag = [
      'Technology',
      'Science',
      'Health',
      'Business',
      'Entertainment',
    ];

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.check_mark_circled),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              image != null
                  ? GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        strokeWidth: 2,
                        radius: const Radius.circular(15.0),
                        color: AppColor.focusColor,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 50.0),
                          child: Column(
                            children: [
                              Icon(CupertinoIcons.folder,
                                  size: 40, color: AppColor.white),
                              SizedBox(height: 15),
                              Center(
                                  child: Text(
                                'Select Your Image',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: tag
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedTag.contains(e)) {
                                    selectedTag.remove(e);
                                  } else {
                                    selectedTag.add(e);
                                  }
                                });
                              },
                              child: Chip(
                                side: BorderSide(
                                  color: selectedTag.contains(e)
                                      ? AppColor.focusColor
                                      : AppColor.secondaryColor,
                                  width: 2,
                                ),
                                color: selectedTag.contains(e)
                                    ? const WidgetStatePropertyAll(
                                        AppColor.focusColor)
                                    : const WidgetStatePropertyAll(
                                        AppColor.primaryColor),
                                label: Text(
                                  e,
                                  style: const TextStyle(color: AppColor.white),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
              BlogTextField(
                hintText: 'Enter your blog title',
              ),
              const SizedBox(height: 20),
              BlogTextField(
                hintText: 'Enter your blog content',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
