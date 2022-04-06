import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_estate/models/property.dart';

class PropertyQueries{
  Future<List<PropertyModel>> fetchBookedProperties(String? tenantId) async {
    final propertyData = await FirebaseFirestore.instance
        .collection('propertyData')
        .doc('propertyListing')
        .collection('properties').where("tenant_id", isEqualTo: tenantId)
        .get();
    List<PropertyModel> propData = [];

    for (var property in propertyData.docs) {
      propData
          .add(PropertyModel.fromDocumentSnapshot(documentSnapshot: property));
    }
    return propData;
  }
  Future<List<PropertyModel>> fetchSearchedProperties(String? name) async {
    final propertyData = await FirebaseFirestore.instance
        .collection('propertyData')
        .doc('propertyListing')
        .collection('properties').where("name", isEqualTo: name)
        .get();
    List<PropertyModel> propData = [];

    for (var property in propertyData.docs) {
      propData
          .add(PropertyModel.fromDocumentSnapshot(documentSnapshot: property));
    }
    return propData;
  }
}