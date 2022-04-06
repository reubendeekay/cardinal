import 'package:get/get.dart';
import 'package:real_estate/models/users.dart';


class UserController extends GetxController {
  static UserController instance = Get.find();
  final Rx<UserModel> _userModel = UserModel().obs;

  UserModel get user => _userModel.value;

  set user(UserModel value) => _userModel.value = value;

  void clear() {
    _userModel.value = UserModel();
  }
}