import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
          child: Text(text.toUpperCase(), style: TextStyle(fontSize: 16)),
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.withOpacity(0.65)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25)), side: BorderSide(color: Colors.blue)))),
          onPressed: onPressed),
    );
  }
}
