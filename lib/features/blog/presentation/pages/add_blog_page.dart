import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/loader.dart';
import 'package:blog_app/core/routes/app_routes.dart';
import 'package:blog_app/core/theme/app_color.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/snackbar.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:blog_app/features/blog/presentation/blog_bloc/blog_bloc_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBlogPage extends StatefulWidget {
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
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
            onPressed: () {
              _showUploadRulesBottomSheet(context);
            },
            icon: const Icon(CupertinoIcons.info_circle_fill),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      body: BlocConsumer<BlogBlocBloc, BlogBlocState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            //  print(state.message);
            showCustomSnackBar(context, state.message);
          } else if (state is BlogUploadSucess) {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.blog, (route) => false);
          }
        },
        builder: (context, state) {
          if (state is BlogBlocLoading) {
            return const Center(
              child: CustomLoader(),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
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
                                        style: const TextStyle(
                                            color: AppColor.white),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlogTextField(
                      text: 'Blog Title',
                      controller: titleController,
                      hintText: 'Enter your blog title',
                    ),
                    const SizedBox(height: 20),
                    BlogTextField(
                      text: 'Blog Content',
                      controller: contentController,
                      hintText: 'Enter your blog content',
                    ),
                    const SizedBox(height: 20),
                    AuthGradientButton(
                        text: "Add Blog",
                        onPressed: () {
                          if (image == null && selectedTag.length == 0) {
                            showCustomSnackBar(
                              context,
                              'Please select an image and at least one topic for your blog.',
                              isError: true,
                            );
                          } else if (formKey.currentState!.validate() &&
                              image != null &&
                              selectedTag.length >= 1) {
                            final posterId = (context.read<AppUserCubit>().state
                                    as AppUserLoggedIn)
                                .user
                                .id;
                            context.read<BlogBlocBloc>().add(BlogUpload(
                                image: image!,
                                title: titleController.text.trim(),
                                content: contentController.text.trim(),
                                posterId: posterId,
                                topics: selectedTag));
                            // Add Blog
                          }
                        })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }
}

void _showUploadRulesBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColor.primaryColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0),
      ),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Rules for Uploading a Blog',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Icon(Icons.image, color: AppColor.subtleColor),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'You must select an image for your blog.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.topic, color: AppColor.subtleColor),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Your blog must be suitable for the selected topics.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.category, color: AppColor.subtleColor),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Please select at least one topic for your blog.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      );
    },
  );
}
