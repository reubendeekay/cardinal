import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:real_estate/controllers/user_controller.dart';
import 'package:real_estate/models/users.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class UserDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<bool> createNewUser(
    SignUpUser user,
  ) async {
    try {
      await _firestore.collection("users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
        "profilePic":
            'https://www.theupcoming.co.uk/wp-content/themes/topnews/images/tucuser-avatar-new.png',
        "phone": user.phone,
        "address": "",
        'isAdmin': false,
        'isActive': false,
        'isVerified': false,
        'isBlocked': false,
        'lastSeen': Timestamp.now(),
        'isOnline': true,
        'isDeleted': false,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      UserController.instance.user = await getUser(user.id);
      return true;
    } on FirebaseException catch (e) {
      Get.snackbar(
        "Error creating user",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<UserModel> getUser(String? uid) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection("users").doc(uid).get();
      return UserModel.fromDocumentSnapshot(documentSnapshot: _doc);
    } on FirebaseException catch (e) {
      Get.snackbar(
        "Error fetching user",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      rethrow;
    }
  }

  Future<bool> updateProfilePic(String userId) async {
    try {
      var file = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
      );
      final ref = _firebaseStorage.ref().child("userData")..child("profilePics").child(userId);
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

      await _firestore
          .collection("users")
          .doc(userId)
          .update({"profilePic": downloadUrl});
      Get.snackbar(
        "Success",
        "Profile pic updated",
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } on FirebaseException catch (e) {
      Get.snackbar(
        "Error updating profile picture",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }
}
