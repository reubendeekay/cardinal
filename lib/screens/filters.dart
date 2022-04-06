import 'package:flutter/material.dart';
import 'package:real_estate/models/og_tab_item.dart';
import 'package:real_estate/models/property.dart';
import 'package:real_estate/screens/search_result.dart';
import 'package:real_estate/screens/widgets/buttons/button_group_spaced.dart';
import 'package:real_estate/screens/widgets/input/input_widget.dart';
import 'package:real_estate/screens/widgets/og_tab.dart';
import 'package:real_estate/screens/widgets/buttons/primary_button.dart';
import 'package:real_estate/utils/constants.dart';
import 'package:real_estate/utils/helper.dart';

class Filters extends StatefulWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  int price = 10000;
  int index = 0;
  String location = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filters"),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              child: const Text("Reset"),
            ),
          ),
          const SizedBox(
            width: 10.0,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: OgTab(
                  items: [
                    OgTabItem(
                      title: availableProperty,
                    ),
                    OgTabItem(
                      title: bookedProperty,
                    ),
                  ],
                  onChanged: (int val) {
                    index = val;
                  },
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Property Area",
                      style: TextStyle(
                        color: Constants.blackColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    InputWidget(
                      obscureText: false,
                      hintText: "Find more properties in nearby area",
                      prefixIcon: null,
                      onChanged: (String val) {},
                      validator: null,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Property Price",
                          style: TextStyle(
                            color: Constants.blackColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Slider(
                          label: "Select Property Price",
                          value: price.toDouble(),
                          min: 10000,
                          max: 10000000,
                          divisions: 10,
                          activeColor: Constants.primaryColor,
                          onChanged: (double value) {
                            setState(() {
                              price = value.toInt();
                            });
                          },
                        ),
                        Text(
                          price.toString() + " \$",
                          style: const TextStyle(
                            color: Constants.blackColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Property Type",
                      style: TextStyle(
                        color: Constants.blackColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const ButtonGroupSpaced(
                      items: [
                        "Any",
                        "House",
                        "Apartment",
                        "Office",
                        "Commercial",
                        "Swimming Pool",
                        "Gardens"
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      "Bedrooms",
                      style: TextStyle(
                        color: Constants.blackColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    OgTab(
                      onChanged: (val) => {},
                      items: [
                        OgTabItem(
                          title: "Any",
                        ),
                        OgTabItem(
                          title: "1",
                        ),
                        OgTabItem(
                          title: "2",
                        ),
                        OgTabItem(
                          title: "3",
                        ),
                        OgTabItem(
                          title: "4+",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      "Bathrooms",
                      style: TextStyle(
                        color: Constants.blackColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    OgTab(
                      onChanged: (val) => {},
                      items: [
                        OgTabItem(
                          title: "Any",
                        ),
                        OgTabItem(
                          title: "1",
                        ),
                        OgTabItem(
                          title: "2",
                        ),
                        OgTabItem(
                          title: "3",
                        ),
                        OgTabItem(
                          title: "4+",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    PrimaryButton(
                      text: "Apply Filters",
                      onPressed: () {
                        Helper.nextScreen(context, const SearchResult());
                      },
                    )
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
