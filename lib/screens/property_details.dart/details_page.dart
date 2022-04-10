import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/controllers/cached_image.dart';
import 'package:real_estate/models/property.dart';
import 'package:real_estate/models/users.dart';
import 'package:real_estate/providers/chat_provider.dart';
import 'package:real_estate/screens/chat/chat_room.dart';
import 'package:real_estate/screens/property_details.dart/property_location.dart';
import 'package:real_estate/utils/constants.dart';

class DetailsPage extends StatefulWidget {
  final PropertyModel propertyModel;
  const DetailsPage({
    Key? key,
    required this.propertyModel,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    Provider.of<ChatProvider>(context, listen: false).getChats();
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselwithIndicatorDemo(
                  propertyModel: widget.propertyModel,
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.propertyModel.name!,
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const Spacer(),
                          const Icon(
                            LineIcons.starAlt,
                            color: Colors.amber,
                          ),
                          Text(
                            '4.0',
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),

                      Text(
                        widget.propertyModel.address.toString(),
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Colors.black.withOpacity(0.5),
                            ),
                      ),
                      // const SizedBox(
                      //   height: 32,
                      // ),
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: Row(
                      //     children: [
                      //       specWidget(
                      //         context,
                      //         LineIcons.home,
                      //         "${propertyModel.} Rooms",
                      //       ),
                      //       specWidget(
                      //         context,
                      //         LineIcons.areaChart,
                      //         "${propertyModel.area} Sqft",
                      //       ),
                      //       specWidget(
                      //         context,
                      //         LineIcons.building,
                      //         "${propertyModel.floors} Floors",
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        widget.propertyModel.description!,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Colors.black.withOpacity(0.5),
                              letterSpacing: 1.1,
                              height: 1.4,
                            ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Location',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      MechanicDetailsLocation(
                        imageUrl: widget.propertyModel.coverImage,
                        location: LatLng(
                          widget.propertyModel.location!.latitude,
                          widget.propertyModel.location!.longitude,
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final users =
                          Provider.of<ChatProvider>(context, listen: false)
                              .contactedUsers;
                      List<String> room = users.map<String>((e) {
                        return e.chatRoomId!.contains(
                                FirebaseAuth.instance.currentUser!.uid +
                                    '_' +
                                    widget.propertyModel.ownerId!)
                            ? FirebaseAuth.instance.currentUser!.uid +
                                '_' +
                                widget.propertyModel.ownerId!
                            : widget.propertyModel.ownerId! +
                                '_' +
                                FirebaseAuth.instance.currentUser!.uid;
                      }).toList();
                      print(room.length);
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.propertyModel.ownerId!)
                          .get()
                          .then((value) {
                        Navigator.of(context)
                            .pushNamed(ChatRoom.routeName, arguments: {
                          'user': UserModel(
                            userId: value.id,
                            fullName: value['name'],
                            profilePic: value['profilePic'],
                            lastSeen: value['lastSeen'],
                            isOnline: value['isOnline'],
                          ),
                          'chatRoomId': room.first,
                        });
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(4, 4),
                            blurRadius: 20,
                            spreadRadius: 4,
                          )
                        ],
                      ),
                      height: 55,
                      width: 55,
                      child: const Icon(
                        LineIcons.facebookMessenger,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(4, 4),
                            blurRadius: 20,
                            spreadRadius: 4,
                          )
                        ],
                      ),
                      height: 55,
                      width: 55,
                      child: Icon(
                        isLiked ? LineIcons.heartAlt : LineIcons.heart,
                        color: isLiked ? Colors.red : null,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "To be Implemented",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Constants.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Constants.primaryColor,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(4, 4),
                              blurRadius: 20,
                              spreadRadius: 4,
                            )
                          ],
                        ),
                        height: 55,
                        width: 55,
                        child: Center(
                          child: Text(
                            "Request Buy",
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget specWidget(BuildContext context, IconData iconData, String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(
                0xffE7CD6B,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }
}

// this is the first way to do this. But instead of making this iteratively you can make a function instead of extracting the widget!

// class DetailsSpecItem extends StatelessWidget {
//   const DetailsSpecItem({
//     Key? key,
//     required this.propertyModel,
//   }) : super(key: key);

//   final PropertyModel propertyModel;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: const BoxDecoration(
//               color: Color(
//                 0xffE7CD6B,
//               ),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.home),
//           ),
//           const SizedBox(
//             width: 8,
//           ),
//           Text(
//             "${propertyModel.rooms} Rooms",
//             style: Theme.of(context).textTheme.subtitle1,
//           ),
//           const SizedBox(
//             width: 8,
//           ),
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: const BoxDecoration(
//               color: Color(
//                 0xffE7CD6B,
//               ),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.home),
//           ),
//           const SizedBox(
//             width: 8,
//           ),
//           Text(
//             "${propertyModel.area} Sqft",
//             style: Theme.of(context).textTheme.subtitle1,
//           ),
//         ],
//       ),
//     );
//   }
// }

class CarouselwithIndicatorDemo extends StatefulWidget {
  final PropertyModel propertyModel;
  const CarouselwithIndicatorDemo({
    Key? key,
    required this.propertyModel,
  }) : super(key: key);

  @override
  _CarouselwithIndicatorDemoState createState() =>
      _CarouselwithIndicatorDemoState();
}

class _CarouselwithIndicatorDemoState extends State<CarouselwithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _controller,
          items: widget.propertyModel.images!
              .map((item) => cachedImage(
                    item,
                    fit: BoxFit.cover,
                    width: 1000,
                  ))
              .toList(),
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            viewportFraction: 0.9,
            autoPlay: true,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.propertyModel.images!.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                width: 12,
                height: _current == entry.key ? 6 : 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(
                    _current == entry.key ? 0.5 : 0.2,
                  ),
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
