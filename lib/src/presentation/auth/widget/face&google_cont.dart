import 'package:flutter/material.dart';

class SinInMethod extends StatelessWidget {
  SinInMethod({super.key, required this.methodImage, required this.methodText, required this.onpress});
  String methodText;
  String methodImage;
  final VoidCallback onpress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        height: 60,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black12,
          ),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(methodImage),
          const SizedBox(
            width: 10,
          ),
           Text(methodText),
        ]),
      ),
    );
  }
}
