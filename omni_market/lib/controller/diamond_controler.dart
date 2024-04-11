import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:omni_market/model/view_diamond.dart';
import 'package:omni_market/repository/services/view_diamond_service.dart';
import 'package:path/path.dart' as path;

class DiamondController extends GetxController {
  ViewDiamondModel viewDiamondModel = ViewDiamondModel();

  List<String> selectedDiamondCateogry = [];
  List<String> selectedDiamondCut = [];
  List<String> selectedPolishcolor = [];
  List<String> selectedPolishType = [];
  List<String> selectedRoughQuality = [];

  void setSelectedDiamondCateogry(List<String> values) {
    selectedDiamondCateogry = values;
    update(); // Update to trigger UI rebuild
  }

  void setSelectedDiamondCut(List<String> values) {
    selectedDiamondCut = values;
    update(); // Update to trigger UI rebuild
  }

  void setSelectedPolishcolor(List<String> values) {
    selectedPolishcolor = values;
    update(); // Update to trigger UI rebuild
  }

  void setSelectedPolishType(List<String> values) {
    selectedPolishType = values;
    update(); // Update to trigger UI rebuild
  }

  void setSelectedRoughQuality(List<String> values) {
    selectedRoughQuality = values;
    update(); // Update to trigger UI rebuild
  }

  DateTime? startDate = DateTime.now();
  DateTime? endDate = DateTime.now();
  String? forrmateStartDate;
  String? forrmateEndDate;

  Future<void> selectStartDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != startDate) {
      startDate = pickedDate;
      forrmateStartDate =
          DateFormat('yyyy-MM-dd').format(startDate ?? DateTime.now());
      update();
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != endDate) {
      endDate = pickedDate;
      forrmateEndDate =
          DateFormat('yyyy-MM-dd').format(endDate ?? DateTime.now());
      update(); // Update to trigger UI rebuild
    }
  }

  String formatDate(DateTime date) {
    return DateFormat.yMMMMd().format(date);
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
  }

  void _uploadImageAndStoreURL() async {
    await _uploadImageToFirebase();
    update(); // Update to trigger UI rebuild
  }

  @override
  void onInit() async {
    super.onInit();
    final result = await ViewDiamondImplementation().viewDiamonds();
    result.fold(
      (error) {
        print("error");
      },
      (data) {
        viewDiamondModel = data;
        print("data:viewDiamondModel${viewDiamondModel.data?[0].diamondName}");
      },
    );
    update();
  }
}
