import 'package:flutter/material.dart';
import 'package:real_estate/controllers/color_loader.dart';

class MyLoader extends StatelessWidget {
  const MyLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ColorLoader4(
      dotOneColor: Colors.white,
      dotTwoColor: Colors.white,
      dotThreeColor: Colors.white,
      duration: Duration(milliseconds: 1200),
    );
  }
}
