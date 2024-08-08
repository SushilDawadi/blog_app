import 'dart:io';
import 'package:image_picker/image_picker.dart';


Future<File?> pickImage() async {
  try {
    print("Opening gallery...");
    final xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (xFile != null) {
      return File(xFile.path);
    }
    return null;
  } on Exception catch (e) {
    return null;
  }
}
