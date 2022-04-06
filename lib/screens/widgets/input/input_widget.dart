import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputWidget extends StatefulWidget {
  final String hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final double height;
  final Function(String val) onChanged;
  final FormFieldValidator<String>? validator;
  const InputWidget(
      {Key? key,
      required this.hintText,
      required this.prefixIcon,
      this.height = 53.0,
      required this.onChanged,
      required this.obscureText,
      required this.validator})
      : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(widget.height),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.only(
        right: 16.0,
        left: widget.prefixIcon == null ? 16.0 : 0.0,
      ),
      child: TextFormField(
        onChanged: (val) {
          setState(() {
            widget.onChanged(val);
          });
        },
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon == null
              ? null
              : Icon(
                  widget.prefixIcon,
                  color: const Color.fromRGBO(105, 108, 121, 1),
                ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: const OutlineInputBorder(
            // ignore: unnecessary_const
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 14.0,
            color: Color.fromRGBO(105, 108, 121, 1),
          ),
        ),
      ),
    );
  }
}
