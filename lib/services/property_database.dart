import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:get/get.dart';
import 'dart:io';

import 'package:real_estate/models/property.dart';

class PropertyDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  final String fileName = Random().nextInt(10000000).toString();

  Future<String> uploadPropertyImage() async {
    // returns download url of image file
    var file = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    final ref = _firebaseStorage.ref().child("properties").child(fileName);
    late UploadTask uploadTask;
    if (file == null) {
      Get.snackbar(
        "Error",
        "No file selected",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      var filePath = file.files.single.path;
      File image = File(filePath!);
      try {
        uploadTask = ref.putFile(image);
      } on firebase_core.FirebaseException catch (e) {
        Get.snackbar(
          "Error",
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    Get.snackbar(
      "Success",
      "Image Uploaded",
      snackPosition: SnackPosition.BOTTOM,
    );
    return downloadUrl;
  }

  Future<bool> addProperty(PropertyModel property) async {
    try {
      await _firestore
          .collection('propertyData')
          .doc('propertyListing')
          .collection('properties')
          .add(
        {
          "ownerId": property.ownerId,
          "name": property.name,
          "description": property.description,
          "image": FieldValue.arrayUnion(property.images!),
          "liked": property.liked,
          "address": property.address,
          "price": property.price,
          "cover_image": property.coverImage,
          "property_status": property.propertyStatus,
          "category": property.propertyCategory,
          "location": property.location,
        },
      );

      Get.snackbar(
        "Success",
        "Property successfully added",
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } on FirebaseException catch (e) {
      Get.snackbar(
        "An Error Occurred",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<bool> bookProperty(String propertyId, String tenantId) async {
    try {
      await FirebaseFirestore.instance
          .collection('propertyData')
          .doc('propertyListing')
          .collection('properties')
          .doc(propertyId)
          .update({'tenant_id': tenantId, "property_status": sellProperty});
      Get.snackbar(
        "Success",
        "Property successfully booked",
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } on FirebaseException catch (e) {
      Get.snackbar(
        "An Error Occurred",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<bool> vacateProperty(String propertyId) async {
    try {
      await FirebaseFirestore.instance
          .collection('propertyData')
          .doc('propertyListing')
          .collection('properties')
          .doc(propertyId)
          .update({'tenant_id': "", "property_status": rentProperty});
      Get.snackbar(
        "Success",
        "Property successfully vacated",
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } on FirebaseException catch (e) {
      Get.snackbar(
        "An Error Occurred",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<bool> addFavorite(
    String id,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('propertyData')
          .doc('propertyListing')
          .collection('properties')
          .doc(id)
          .update({
        'liked': FieldValue.increment(1),
      });
      Get.snackbar(
        "Success",
        "Property successfully ❤️",
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } on FirebaseException catch (e) {
      Get.snackbar(
        "An Error Occurred",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<List<PropertyModel>> fetchProperties() async {
    final propertyData = await FirebaseFirestore.instance
        .collection('propertyData')
        .doc('propertyListing')
        .collection('properties')
        .get();
    List<PropertyModel> propData = [];

    for (var property in propertyData.docs) {
      propData
          .add(PropertyModel.fromDocumentSnapshot(documentSnapshot: property));
    }

    return propData;
  }
}
