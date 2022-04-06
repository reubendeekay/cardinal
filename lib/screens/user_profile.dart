import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:real_estate/controllers/auth_controller.dart';
import 'package:real_estate/controllers/user_controller.dart';
import 'package:real_estate/models/users.dart';
import 'package:real_estate/services/user_database.dart';
import 'package:real_estate/utils/constants.dart';

class UserProfile extends StatefulWidget {
  final bool isFromDrawer;
  const UserProfile({Key? key, required this.isFromDrawer}) : super(key: key);
  static const routeName = '/user-profile';
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String fullName = '';
  String email = '';
  String phoneNumber = '';
  String nationalId = '123';
  String dateofBirth = '';
  String postal = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserModel user = UserController.instance.user;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top + 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                UserPicture(),
              ],
            ),
            SizedBox(height: size.height * 0.05),
//FORM INPUT

            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: TextFormField(
                      // controller: controller,
                      initialValue: user.fullName ?? 'Enter your full name',
                      onChanged: (val) {
                        setState(() {
                          fullName = val;
                        });
                      },
                      validator: (val) {
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          fullName = val!;
                        });
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          labelText: 'Full name',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                  ),
                  ///////////////////////////////////////////
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: TextFormField(
                      // controller: controller,
                      validator: (val) {
                        return null;
                      },
                      initialValue: user.email ?? 'Enter your email address',
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      onSaved: (val) {
                        setState(() {
                          email = val!;
                        });
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          labelText: 'Email address',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                  ),
                  //////////////////////////////////////////
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: TextFormField(
                      initialValue:
                          user.phoneNumber ?? 'Enter your phone number',
                      onChanged: (val) {
                        setState(() {
                          phoneNumber = val;
                        });
                      },
                      validator: (val) {
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          phoneNumber = val!;
                        });
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          labelText: 'Phone number',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                  ),

                  //////////////////////////////
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: TextFormField(
                      // controller: controller,
                      validator: (val) {
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          postal = val!;
                        });
                      },
                      initialValue: user.address ?? 'Enter your Postal address',
                      onChanged: (val) {
                        setState(() {
                          postal = val;
                        });
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          labelText: 'Postal Address',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: size.height * 0.05),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                primary: Constants.primaryColor,
              ),
              onPressed: () async {
                _formKey.currentState!.save();
                AuthController.instance.updateProfile(
                  UserModel(
                    email: email,
                    address:
                        postal != 'Enter your Postal address' ? postal : null,
                    fullName: fullName,
                    phoneNumber: phoneNumber,
                  ),
                );
                //Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 15),
                child: Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                primary: Constants.primaryColor,
              ),
              onPressed: () async {
                AuthController.instance.signOut();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 15),
                child: Text(
                  'Log out',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            
          ],
        ),
      ),
    );
  }
}

class UserPicture extends StatefulWidget {
  const UserPicture({Key? key}) : super(key: key);

  @override
  _UserPictureState createState() => _UserPictureState();
}

class _UserPictureState extends State<UserPicture> {
  List<Media> mediaList = [];
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    UserModel? user = UserController.instance.user;
    void openImagePicker() => UserDatabase().updateProfilePic(user.userId!);
    return SizedBox(
      height: 110,
      width: 110,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    )
                  ])),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: CachedNetworkImageProvider(user.profilePic!),
            ),
          ),
          Positioned(
            right: -10,
            bottom: -2,
            child: GestureDetector(
              onTap: () => openImagePicker(),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  backgroundColor: Constants.primaryColor,
                  radius: 16,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
