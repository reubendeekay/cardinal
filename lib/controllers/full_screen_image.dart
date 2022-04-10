import 'package:flutter/material.dart';
import 'package:real_estate/controllers/cached_image.dart';

class FullscreenImage extends StatelessWidget {
  const FullscreenImage({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: cachedImage(
        image,
        width: double.infinity,
        fit: BoxFit.fitWidth,
      ),
    ));
  }
}
