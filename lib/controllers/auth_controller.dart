import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:real_estate/controllers/property_controller.dart';
import 'package:real_estate/controllers/user_controller.dart';
import 'package:real_estate/models/users.dart';
import 'package:real_estate/screens/authentication/authentication.dart';
import 'package:real_estate/screens/widgets/bottom_bar.dart';
import 'package:real_estate/services/property_database.dart';
import 'package:real_estate/services/property_queries.dart';
import 'package:real_estate/services/user_database.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isOnline = false;
  final RxBool _loading = false.obs;
  late Rx<User?> _user;
  User? get user => _user.value;
  bool get loading => _loading.value;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.userChanges());
    // takes a listener and a callback... notifies callback on state changes
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => const Authentication());
    } else {
      UserController.instance.user =
          await UserDatabase().getUser(AuthController.instance.user!.uid);
      PropertyController.instance.properties =
          await PropertyDatabase().fetchProperties();
      PropertyController.instance.yourBookedProps = await PropertyQueries()
          .fetchBookedProperties(UserController.instance.user.userId);
      Get.offAll(() => const BottomBar());
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      _loading(true);
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      UserController.instance.user =
          await UserDatabase().getUser(_authResult.user!.uid);
    } catch (e) {
      // print(e.toString());
      Get.snackbar(
        "Login Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _loading(false);
    }
  }

  Future createUser(
      String name, String email, String password, String phone) async {
    try {
      _loading(true);
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      //create user in database.dart
      SignUpUser _user = SignUpUser(
          id: _authResult.user?.uid,
          name: name,
          email: _authResult.user!.email,
          phone: phone);
      if (await UserDatabase().createNewUser(
        _user,
      )) {
        Get.back();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "Error creating Account",
          'No user found for that email.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "Error creating Account",
          'Wrong password provided for that user.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      _loading(false);
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      UserController.instance.clear();
    } catch (e) {
      // print(e.toString());
      Get.snackbar(
        "Error signing out",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {}
  }

  void getOnlineStatus() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final databaseRef = FirebaseDatabase.instance.ref('users/$uid');
    if (isOnline) {
      databaseRef.update({
        'isOnline': true,
        'lastSeen': DateTime.now().microsecondsSinceEpoch,
      });
      isOnline = true;
    }

    databaseRef.onDisconnect().update({
      'isOnline': false,
      'lastSeen': DateTime.now().microsecondsSinceEpoch,
    }).then((_) => {
          isOnline = false,
        });
  }

  void updateProfile(UserModel update) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'name': update.fullName,
      'email': update.email,
      'phone': update.phoneNumber,
      'address': update.address,
      'updatedAt': Timestamp.now(),
    });
  }
}
