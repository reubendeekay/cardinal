import 'package:flutter/material.dart';
import 'package:real_estate/controllers/property_controller.dart';
import 'package:real_estate/models/property.dart';
import 'package:real_estate/screens/widgets/property_card.dart';
import 'package:real_estate/utils/constants.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PropertyModel> properties = PropertyController.instance.searchedProps;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Results"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${properties.length} Properties Found",
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Constants.blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // const Text(
                  //   "View with Map",
                  //   style: TextStyle(
                  //     fontSize: 15.0,
                  //     color: Color.fromRGBO(255, 136, 0, 1),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
