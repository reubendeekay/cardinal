import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/controllers/property_controller.dart';
import 'package:real_estate/controllers/user_controller.dart';
import 'package:real_estate/models/property.dart';
import 'package:real_estate/models/users.dart';
import 'package:real_estate/providers/location_provider.dart';
import 'package:real_estate/screens/filters.dart';
import 'package:real_estate/screens/search_result.dart';
import 'package:real_estate/screens/user_profile.dart';
import 'package:real_estate/screens/widgets/property_card.dart';
import 'package:real_estate/services/property_queries.dart';
import 'package:real_estate/utils/constants.dart';
import 'package:real_estate/utils/helper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String searchTerm = '';
  List<PropertyModel> properties = PropertyController.instance.properties;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<LocationProvider>(context, listen: false)
          .getCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = UserController.instance.user;
    return Scaffold(
      body: SingleChildScrollView(
        child: user == null
            ? Center(
                child: SizedBox(
                height: 400,
                child: Lottie.asset(
                  'assets/squid.json',
                ),
              ))
            : SafeArea(
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
                        children: [
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Find a Thousand Homes\n",
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      height: 1.3,
                                      color: Color.fromRGBO(22, 27, 40, 70),
                                    ),
                                  ),
                                  TextSpan(
                                    text: "For Booking",
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
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                  () => const UserProfile(isFromDrawer: false));
                            },
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(user.profilePic!),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: ScreenUtil().setHeight(44),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.only(
                              right: 16.0,
                              left: 16.0,
                            ),
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  searchTerm = val;
                                });
                              },
                              onFieldSubmitted: (val) async {
                                PropertyController.instance.searchedProps =
                                    await PropertyQueries()
                                        .fetchSearchedProperties(searchTerm);
                                Get.to(const SearchResult());
                              },
                              onEditingComplete: () async {
                                PropertyController.instance.searchedProps =
                                    await PropertyQueries()
                                        .fetchSearchedProperties(searchTerm);
                                Get.to(const SearchResult());
                              },
                              decoration: const InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: Color.fromRGBO(105, 108, 121, 1),
                                ),
                              ),
                            ),
                          )),
                          const SizedBox(
                            width: 10.0,
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(44.0),
                            child: TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  Constants.primaryColor,
                                ),
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Helper.nextScreen(context, const Filters());
                              },
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.abc,
                                    // FlutterIcons.ios_options_ion,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    "Filters",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => const SearchResult());
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: ScreenUtil().setHeight(52.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromRGBO(255, 136, 0, 1),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: const Text(
                                  "For Sell",
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 136, 0, 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => const SearchResult());
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: ScreenUtil().setHeight(52.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromRGBO(255, 136, 0, 1),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: const Text(
                                  "For Rent",
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 136, 0, 1),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "New Properties",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Constants.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "View all",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
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
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
