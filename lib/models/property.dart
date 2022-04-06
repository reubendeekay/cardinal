import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const String sellProperty = "sell";
const String rentProperty = "rent";

class PropertyModel {
  String? propertyId;
  String? ownerId;
  String? name;
  String? description;
  String? address;
  String? price;
  String? coverImage;
  List<dynamic>? images;
  String? propertyStatus;
  GeoPoint? location;
  String? propertyCategory;
  int? liked;

  PropertyModel(
      {this.propertyId,
      this.ownerId,
      this.name,
      this.description,
      this.address,
      this.price,
      this.coverImage,
      this.images,
      this.liked,
      this.location,
      this.propertyStatus,
      this.propertyCategory});
  PropertyModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    propertyId = documentSnapshot.id;
    ownerId = documentSnapshot["ownerId"];
    name = documentSnapshot["name"];
    description = documentSnapshot["description"];
    address = documentSnapshot["address"];
    price = documentSnapshot["price"];
    coverImage = documentSnapshot["cover_image"];
    images = documentSnapshot["image"];
    liked = documentSnapshot["liked"];
    propertyStatus = documentSnapshot["property_status"];
    propertyCategory = documentSnapshot["category"];
  }
}
