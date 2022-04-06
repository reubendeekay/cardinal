import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:real_estate/controllers/property_controller.dart';
import 'package:real_estate/controllers/user_controller.dart';
import 'package:real_estate/models/property.dart';
import 'package:real_estate/screens/property_details.dart/details_page.dart';
import 'package:real_estate/screens/widgets/bottom_bar.dart';
import 'package:real_estate/services/property_database.dart';
import 'package:real_estate/services/property_queries.dart';
import 'package:real_estate/utils/constants.dart';

class PropertyCard extends StatelessWidget {
  final PropertyModel property;
  const PropertyCard({Key? key, required this.property}) : super(key: key);

  void likeProperty() async {
    PropertyDatabase().addFavorite(property.propertyId!);
    PropertyController.instance.properties =
        await PropertyDatabase().fetchProperties();
  }

  void bookProperty() async {
    PropertyDatabase().bookProperty(
        property.propertyId!, UserController.instance.user.userId!);
    PropertyController.instance.properties =
        await PropertyDatabase().fetchProperties();
    PropertyController.instance.yourBookedProps = await PropertyQueries()
        .fetchBookedProperties(UserController.instance.user.userId);
    Get.offAll(() => const BottomBar());
  }

  void doVacate() async {
    PropertyDatabase().vacateProperty(property.propertyId!);
    PropertyController.instance.properties =
        await PropertyDatabase().fetchProperties();
    PropertyController.instance.yourBookedProps = await PropertyQueries()
        .fetchBookedProperties(UserController.instance.user.userId);
    Get.offAll(() => const BottomBar());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DetailsPage(propertyModel: property));
      },
      child: AspectRatio(
        aspectRatio: 16 / 12,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            property.coverImage!,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10.0,
                      right: 10.0,
                      child: InkWell(
                        onTap: () => likeProperty(),
                        child: Container(
                          width: 45.0,
                          height: 45.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: property.liked! != 0
                                ? const Color.fromRGBO(255, 136, 0, 1)
                                : const Color(0xFFC4C4C4),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -15.0,
                      left: 10.0,
                      child: Container(
                        width: 45.0,
                        height: 45.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: property.propertyStatus == availableProperty
                              ? Constants.primaryColor
                              : const Color.fromRGBO(255, 136, 0, 1),
                        ),
                        child: Center(
                          child: Text(
                            property.propertyStatus == availableProperty
                                ? availableProperty
                                : bookedProperty,
                            style: const TextStyle(
                              fontSize: 8.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            property.name!,
                            style: const TextStyle(
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                        Text(
                          "KES ${property.price!}",
                          style: const TextStyle(
                            fontSize: 17.0,
                            color: Constants.primaryColor,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      property.address!,
                      style: const TextStyle(
                        fontSize: 13.0,
                        color: Color(0xFF343434),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 5.0,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Row(
                    //       children: [
                    //         const Icon(
                    //           Icons.map_outlined,
                    //           //FlutterIcons.map_pin_fea,
                    //           size: 15.0,
                    //           color: Color.fromRGBO(255, 136, 0, 1),
                    //         ),
                    //         const SizedBox(
                    //           width: 5.0,
                    //         ),
                    //         Text(
                    //           property.address!,
                    //           style: const TextStyle(
                    //             fontSize: 13.0,
                    //             color: Color(0xFF343434),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     property.propertyStatus != bookedProperty
                    //         ? TextButton(
                    //             onPressed: () => bookProperty(),
                    //             style: ButtonStyle(
                    //                 shape: MaterialStateProperty.all(
                    //                   RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.circular(8.0),
                    //                   ),
                    //                 ),
                    //                 backgroundColor: MaterialStateProperty.all(
                    //                   Constants.primaryColor,
                    //                 ),
                    //                 padding: MaterialStateProperty.all(
                    //                   const EdgeInsets.symmetric(
                    //                     horizontal: 15.0,
                    //                   ),
                    //                 )),
                    //             child: const Text(
                    //               "Book now",
                    //               style: TextStyle(
                    //                 color: Colors.white,
                    //               ),
                    //             ),
                    //           )
                    //         : property.tenantId ==
                    //                 UserController.instance.user.userId
                    //             ? TextButton(
                    //                 onPressed: () => doVacate(),
                    //                 style: ButtonStyle(
                    //                   shape: MaterialStateProperty.all(
                    //                     RoundedRectangleBorder(
                    //                       borderRadius:
                    //                           BorderRadius.circular(8.0),
                    //                     ),
                    //                   ),
                    //                   backgroundColor: MaterialStateProperty.all(
                    //                     const Color.fromRGBO(255, 136, 0, 1),
                    //                   ),
                    //                   padding: MaterialStateProperty.all(
                    //                     const EdgeInsets.symmetric(
                    //                       horizontal: 15.0,
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 child: const Text(
                    //                   "Vacate",
                    //                   style: TextStyle(
                    //                     color: Colors.white,
                    //                   ),
                    //                 ),
                    //               )
                    //             : TextButton(
                    //                 onPressed: () {},
                    //                 style: ButtonStyle(
                    //                     shape: MaterialStateProperty.all(
                    //                       RoundedRectangleBorder(
                    //                         borderRadius:
                    //                             BorderRadius.circular(8.0),
                    //                       ),
                    //                     ),
                    //                     backgroundColor:
                    //                         MaterialStateProperty.all(
                    //                       const Color.fromRGBO(255, 136, 0, 1),
                    //                     ),
                    //                     padding: MaterialStateProperty.all(
                    //                       const EdgeInsets.symmetric(
                    //                         horizontal: 15.0,
                    //                       ),
                    //                     )),
                    //                 child: const Text(
                    //                   "Booked",
                    //                   style: TextStyle(
                    //                     color: Colors.white,
                    //                   ),
                    //                 ),
                    //               ),
                    //   ],
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
