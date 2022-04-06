import 'package:flutter/material.dart';
import 'package:real_estate/screens/authentication/authentication.dart';
import 'package:real_estate/screens/filters.dart';
import 'package:real_estate/screens/search_result.dart';
import 'package:real_estate/screens/widgets/bottom_bar.dart';
import 'package:real_estate/welcome.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(builder: (BuildContext context) {
        //return const Authentication();
        return const BottomBar();
      });
    case "/welcome":
      return MaterialPageRoute(builder: (BuildContext context) {
        return const Welcome();
      });
    case "/authentication":
      return MaterialPageRoute(builder: (BuildContext context) {
        return const Authentication();
      });
    case "/search-result":
      return MaterialPageRoute(builder: (BuildContext context) {
        return const SearchResult();
      });
    case "/filters":
      return MaterialPageRoute(builder: (BuildContext context) {
        return const Filters();
      });
    default:
      return MaterialPageRoute(builder: (BuildContext context) {
        return const BottomBar();
      });
  }
}
