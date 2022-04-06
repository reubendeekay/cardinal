import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:real_estate/controllers/property_controller.dart';
import 'package:real_estate/controllers/user_controller.dart';
import 'package:real_estate/models/property.dart';
import 'package:real_estate/models/users.dart';
import 'package:real_estate/screens/widgets/input/input_widget.dart';
import 'package:real_estate/screens/widgets/buttons/primary_button.dart';
import 'package:real_estate/services/property_database.dart';

import 'widgets/bottom_bar.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({Key? key}) : super(key: key);

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  late String name;
  late String address;
  late String price;
  late String description;
  late String image;
  late String category;
  late GeoPoint location;
  late PropertyModel property;
  bool _loading = false;
  void _uploadImage() async {
    setState(() {
      _loading = true;
    });
    image = await PropertyDatabase().uploadPropertyImage();
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = UserController.instance.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Property'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: ListView(
          children: [
            const SizedBox(height: 15.0),
            InputWidget(
              obscureText: false,
              hintText: "Name of property",
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              prefixIcon: null,
              validator: null,
            ),
            const SizedBox(height: 15.0),
            InputWidget(
              obscureText: false,
              hintText: "Detailed Description",
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
              validator: null,
              prefixIcon: null,
            ),
            const SizedBox(height: 15.0),
            InputWidget(
              obscureText: false,
              hintText: "Location address",
              onChanged: (value) {
                setState(() {
                  address = value;
                });
              },
              validator: null,
              prefixIcon: null,
            ),
            const SizedBox(height: 15.0),
            InputWidget(
              obscureText: false,
              hintText: "Price of property",
              onChanged: (value) {
                setState(() {
                  price = value;
                });
              },
              validator: null,
              prefixIcon: null,
            ),
            const SizedBox(height: 15.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              child: PrimaryButton(
                onPressed: () => _uploadImage(),
                text: 'Add Image',
              ),
            ),
            const SizedBox(height: 15.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              child: PrimaryButton(
                onPressed: () async {
                  setState(() {
                    _loading = true;
                  });
                  property = PropertyModel(
                      ownerId: user.userId,
                      name: name,
                      images: [image],
                      coverImage: image,
                      description: description,
                      address: address,
                      propertyStatus: availableProperty,
                      liked: 0,
                      price: price);
                  await PropertyDatabase().addProperty(property);
                  PropertyController.instance.properties =
                      await PropertyDatabase().fetchProperties();
                  setState(() {
                    _loading = false;
                  });
                  Get.offAll(() => const BottomBar());
                },
                text: 'Add Property',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
