import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/models/property.dart';
import 'package:real_estate/screens/property_details.dart/details_page.dart';
import 'package:real_estate/utils/constants.dart';

class ViewAllCard extends StatefulWidget {
  final PropertyModel property;
  const ViewAllCard(this.property, {Key? key}) : super(key: key);

  @override
  State<ViewAllCard> createState() => _ViewAllCardState();
}

class _ViewAllCardState extends State<ViewAllCard> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      widget.property.coverImage!,
      ...widget.property.images!
    ];

    return GestureDetector(
      onTap: () {
        Get.to(() => DetailsPage(propertyModel: widget.property));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).cardColor,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: [
            Stack(
              children: [
                CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        disableCenter: true,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                    items: List.generate(
                        images.length,
                        (i) => ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            child: Image.network(
                              images[i],
                              fit: BoxFit.cover,
                            )))),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: images.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                            width: _current == entry.key ? 8.0 : 6.0,
                            height: _current == entry.key ? 8.0 : 6.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == entry.key
                                    ? Constants.primaryColor
                                    : Colors.grey[300])),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'KES ${widget.property.price} ',
                        style: const TextStyle(
                            color: Constants.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.property.name!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            height: 1.3),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.circle,
                        size: 5,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.hotel,
                            color: Colors.grey,
                            size: 10,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${widget.property.propertyCategory}',
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.grey,
                      size: 14,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.property.address!,
                      style: const TextStyle(
                          fontSize: 12,
                          height: 1.5,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                  ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
