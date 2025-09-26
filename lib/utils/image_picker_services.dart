import 'dart:developer';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:matloob_admin/custom_widgets/custom_snackbar.dart';
import 'dart:typed_data';

class ImagePickerService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<String> uploadImageToFirebase(Uint8List fileBytes, String extension) async {
    try {
      String fileName = "images/${DateTime.now().millisecondsSinceEpoch}.$extension";
      TaskSnapshot snapshot = await _storage.ref(fileName).putData(fileBytes);
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      Get.back();
      log(e.toString(), name: "ImagePickerService");
      showCustomSnackbar("Error!", "Error uploading image: $e");
      return '';
    }
  }

  Future<String> uploadRfqImagesToFirebase(Uint8List fileBytes, String extension) async {
    try {
      String fileName = "rfq_images/${DateTime.now().millisecondsSinceEpoch}.$extension";
      TaskSnapshot snapshot = await _storage.ref(fileName).putData(fileBytes);
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      Get.back();
      log(e.toString(), name: "ImagePickerService");
      showCustomSnackbar("Error!", "Error uploading RFQ image: $e");
      return '';
    }
  }

  Future<String> uploadRfqFileToFirebase(Uint8List fileBytes, String fileName) async {
    try {
      String storageFileName =
          "rfq_files/${DateTime.now().millisecondsSinceEpoch}_$fileName";
      TaskSnapshot snapshot = await _storage.ref(storageFileName).putData(fileBytes);
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      Get.back();
      log(e.toString(), name: "ImagePickerService");
      showCustomSnackbar("Error!", "Error uploading RFQ file: $e");
      return '';
    }
  }

  Future<String> uploadProductImagesToFirebase(Uint8List fileBytes, String extension) async {
    try {
      String fileName = "product_images/${DateTime.now().millisecondsSinceEpoch}.$extension";
      TaskSnapshot snapshot = await _storage.ref(fileName).putData(fileBytes);
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      Get.back();
      log(e.toString(), name: "ImagePickerService");
      showCustomSnackbar("Error!", "Error uploading product image: $e");
      return '';
    }
  }
}
