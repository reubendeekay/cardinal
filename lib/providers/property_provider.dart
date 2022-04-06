import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:real_estate/models/property.dart';

class PropertyProvider with ChangeNotifier {
  List<PropertyModel> _properties = [];

  List<PropertyModel> get properties => [..._properties];

  Future<void> fetchProperties() async {
    final propertyData = await FirebaseFirestore.instance
        .collection('propertyData')
        .doc('propertyListing')
        .collection('properties')
        .get();
    List<PropertyModel> propData = [];

    for (var e in propertyData.docs) {
      propData.add(PropertyModel(
        propertyId: e.id,
        name: e['name'],
        coverImage: e['cover_image'],
        price: e['price'],
        location: e['location'],
        images: e['images'],
        ownerId: e['ownerId'],
        propertyCategory: e['propertyCategory'],
        description: e['description'],
      ));
    }

    _properties = propData;

    notifyListeners();
  }
}
