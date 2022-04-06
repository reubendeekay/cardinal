import 'package:flutter/material.dart';
import 'package:real_estate/utils/constants.dart';


class ButtonGroupSpaced extends StatefulWidget {
  final List<String> items;

  const ButtonGroupSpaced({Key? key, required this.items}) : super(key: key);

  @override
  _ButtonGroupSpacedState createState() => _ButtonGroupSpacedState();
}

class _ButtonGroupSpacedState extends State<ButtonGroupSpaced> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.items.map((item) {
        int currentIndex = widget.items.indexOf(item);
        return GestureDetector(
          onTap: () {
            setState(() {
              activeIndex = currentIndex;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
            margin: const EdgeInsets.only(right: 8.0, bottom: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: activeIndex == currentIndex
                    ? Constants.primaryColor
                    : const Color.fromRGBO(163, 167, 168, 1),
              ),
            ),
            child: Text(item),
          ),
        );
      }).toList(),
    );
  }
}
