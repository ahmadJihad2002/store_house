import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:store_house/src/theme/app_color.dart';

class AppUtil {
  static void debugPrint(var value) {
    if (kDebugMode) print(value);
  }

  static bool checkIsNull(value) {
    return [null, "null", ""].contains(value);
  }

  static showSnackbar(
      {required BuildContext context,
      required String message,
      Color color = AppColor.appBgColor}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  }

  static String? selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  static Future<Function?> selectDate(BuildContext context) async {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
    ).then((value) {
      if (value != null) {
        selectedDate = DateFormat('yyyy-MM-dd').format(value!);
      } else {
        selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      }
    });
  }

  static Future<XFile?> pickImageFromGallery() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  static Future<File?> cropSelectedImage(String filePath) async {
    CroppedFile? croppedFile;
    croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );

    if (croppedFile == null) {
      return null;
    } else {
      return File(croppedFile.path);
    }
  }
}
