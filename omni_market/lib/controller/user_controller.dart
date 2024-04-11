import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omni_market/config/local_storage.dart';
import 'package:path/path.dart' as path;

class UserController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    emailController.text =
        LocalStorage.sharedPreferences.getString(LocalStorage.email) ?? '';
    nameController.text =
        LocalStorage.sharedPreferences.getString(LocalStorage.name) ?? '';
    phoneController.text =
        LocalStorage.sharedPreferences.getString(LocalStorage.phone) ?? '';
    update();
  }

  File? imageFile;
  String? uploadedFileURL;

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      _uploadImageAndStoreURL();
    }
  }

  Future<void> _uploadImageToFirebase() async {
    if (imageFile == null) return;

    String fileName = path.basename(imageFile!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    uploadedFileURL = await taskSnapshot.ref.getDownloadURL();
    LocalStorage.sharedPreferences
        .setString(LocalStorage.profile, uploadedFileURL ?? '');
  }

  void _uploadImageAndStoreURL() async {
    await _uploadImageToFirebase();
    update();
  }
}
