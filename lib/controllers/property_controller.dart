import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:real_estate/models/property.dart';

class PropertyController extends GetxController {
  static PropertyController instance = Get.find();
  final Rx<List<PropertyModel>> _properties = Rx<List<PropertyModel>>([]);
  final Rx<List<PropertyModel>> _bookedProperties = Rx<List<PropertyModel>>([]);
  final Rx<List<PropertyModel>> _yourSearchedProps =
      Rx<List<PropertyModel>>([]);
  List<PropertyModel> get properties => [..._properties.value];
  List<PropertyModel> get yourBookedProps => [..._bookedProperties.value];
  List<PropertyModel> get searchedProps => [..._yourSearchedProps.value];

  set properties(List<PropertyModel> value) => _properties.value = value;
  set yourBookedProps(List<PropertyModel> value) =>
      _bookedProperties.value = value;
  set searchedProps(List<PropertyModel> value) =>
      _yourSearchedProps.value = value;

  Future<void> addRecentSearch(String searchTerm) async {
    if (searchTerm.isNotEmpty) {
      final searchData = await FirebaseFirestore.instance
          .collection('userData')
          .doc('recentSearch')
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (searchData.docs.contains(searchTerm)) {
        await FirebaseFirestore.instance
            .collection('userData')
            .doc('recentSearch')
            .collection(FirebaseAuth.instance.currentUser!.uid)
            .doc(searchData.docs
                .firstWhere((element) => element.data()['term'] == searchTerm)
                .id)
            .update({
          'createdAt': Timestamp.now(),
        });
      } else {
        await FirebaseFirestore.instance
            .collection('userData')
            .doc('recentSearch')
            .collection(FirebaseAuth.instance.currentUser!.uid)
            .doc()
            .set({
          'term': searchTerm,
          'createdAt': Timestamp.now(),
        });
      }
    }
  }

  // FirebaseFirestore.instance
  //     .collection('propertyData')
  //     .doc('propertyListing')
  //     .collection('properties')
  //     .doc(id)
  //     .get()
  //     .then((value) => FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(value['ownerId'])
  //         .collection('hosting')
  //         .doc('account')
  //         .update({'totalViews': FieldValue.increment(1)}));
}

Future<void> addHistory(
  String propertyId,
) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final history = FirebaseFirestore.instance
      .collection('userData')
      .doc('history')
      .collection(uid);
  final historyData = await history.get();

  if (historyData.docs.contains(propertyId)) {
    history.doc(propertyId).update({'createdAt': Timestamp.now()});
  } else {
    history.doc(propertyId).set({
      'createdAt': Timestamp.now(),
      'id': propertyId,
    });
  }
}

  // Future<void> fetchHistory() async {
  //   final uid = FirebaseAuth.instance.currentUser!.uid;
  //   final history = await FirebaseFirestore.instance
  //       .collection('userData')
  //       .doc('history')
  //       .collection(uid)
  //       .orderBy('createdAt')
  //       .get();
  //   List<PropertyModel> propData = [];

  //   Future.forEach(history.docs, (element) async {
  //     await FirebaseFirestore.instance
  //         .collection('propertyData')
  //         .doc('propertyListing')
  //         .collection('properties')
  //         .doc(element.id)
  //         .get()
  //         .then((e) => propData.add(PropertyModel(
  //               id: e.id,
  //               name: e['name'],
  //               coverImage: e['coverImage'],
  //               images: e['images'],
  //               ownerId: e['ownerId'],
  //               propertyTypes: e['propertyType'],
  //               description: e['description'],
  //               address: e['address'],
  //               price: e['price'],
  //             )));
  //   }).then((_) {
  //     _yourHistory = propData;
  //     notifyListeners();
  //   });

  //   notifyListeners();
  // }

  // Future<void> fetchWishlist() async {
  //   final uid = FirebaseAuth.instance.currentUser!.uid;
  //   final history =
  //       await FirebaseFirestore.instance.collection('users').doc(uid).get();
  //   List<PropertyModel> propData = [];
  //   List historyList = history.data()['wishlist'];

  //   await Future.forEach(historyList, (element) async {
  //     await FirebaseFirestore.instance
  //         .collection('propertyData')
  //         .doc('propertyListing')
  //         .collection('properties')
  //         .doc(element)
  //         .get()
  //         .then((e) => propData.add(PropertyModel(
  //               id: e.id,
  //               name: e['name'],
  //               coverImage: e['coverImage'],
  //               images: e['images'],
  //               ownerId: e['ownerId'],
  //               propertyTypes: e['propertyType'],
  //               description: e['description'],
  //               address: e['address'],
  //               price: e['price'],
  //             )));
  //   }).then((_) {
  //     _yourWishlist = propData;
  //     notifyListeners();
  //   });

  //   // print(_yourWishlist.first.name);

  //   notifyListeners();
  // }

