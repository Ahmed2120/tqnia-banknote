import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({
    super.key,
    required this.onpress,
    required this.buttonText,
    required this.textColor,
    required this.buttonColor,
    required this.buttonRadius,
    required this.buttonHight,
    required this.buttonWidth,
    required this.textSize,
  });
  final VoidCallback onpress;
  String buttonText;
  Color textColor;
  Color buttonColor;
  double buttonRadius;
  double buttonHight;
  double buttonWidth;
  double textSize;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        height: buttonHight,
        width: buttonWidth,
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(buttonRadius)),
        child: Center(
            child: Text(
          buttonText,
          style: TextStyle(
            color: textColor,
            fontSize: textSize,
          ),
        )),
      ),
    );
  }
}
