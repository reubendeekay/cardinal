import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId;
  String? fullName;
  String? email;
  String? profilePic;
  String? phoneNumber;
  String? address;
  Timestamp? createdAt;
  bool? isOnline;
  Timestamp? lastSeen;

  UserModel({
    this.userId,
    this.fullName,
    this.email,
    this.profilePic,
    this.phoneNumber,
    this.address,
    this.createdAt,
    this.isOnline,
    this.lastSeen,
  });

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    userId = documentSnapshot.id;
    fullName = documentSnapshot["name"];
    email = documentSnapshot["email"];
    profilePic = documentSnapshot["profilePic"];
    phoneNumber = documentSnapshot["phone"];
    isOnline = documentSnapshot["isOnline"];
    lastSeen = documentSnapshot["lastSeen"];
    address = documentSnapshot["address"];
  }
}

class SignUpUser {
  String? id;
  String? name;
  String? email;
  String? phone;

  SignUpUser({this.id, this.name, this.email, this.phone});
}
