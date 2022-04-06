import 'package:flutter/material.dart';
import 'package:real_estate/controllers/property_controller.dart';
import 'package:real_estate/models/property.dart';
import 'package:real_estate/screens/widgets/property_card.dart';
import 'package:real_estate/utils/constants.dart';

class BookedPage extends StatefulWidget {
  const BookedPage({Key? key}) : super(key: key);

  @override
  State<BookedPage> createState() => _BookedPageState();
}

class _BookedPageState extends State<BookedPage> {
  List<PropertyModel> properties = PropertyController.instance.yourBookedProps;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Your Booked Rooms",
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w800,
                            color: Constants.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                properties.isEmpty ? const Center(child: Text("No data here"),):
                ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 15.0,
                    );
                  },
                  itemCount: properties.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return PropertyCard(
                      property: properties[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
