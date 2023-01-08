import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final Color baseColor;
  final Color borderColor;
  final Color errorColor;
  final TextInputType inputType;
  final bool obscureText;
  final Function onChanged;
  final Icon? prefixIcon;

  const CustomInputField(
      {Key? key,
      required this.hint,
      required this.controller,
      required this.baseColor,
      required this.borderColor,
      required this.errorColor,
      this.inputType = TextInputType.text,
      this.obscureText = false,
      required this.onChanged,
      this.prefixIcon})
      : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = widget.borderColor;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: currentColor, width: 0.5),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: TextField(
          obscureText: widget.obscureText,
          onChanged: (text) {
            widget.onChanged(text);
          },
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.grey,
          //keyboardType: widget.inputType,
          controller: widget.controller,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: widget.baseColor,
              fontFamily: "OpenSans",
              fontWeight: FontWeight.w300,
            ),
            border: InputBorder.none,
            hintText: widget.hint,
          ),
        ),
      ),
    );
  }
}
