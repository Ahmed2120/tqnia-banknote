import 'package:banknote/src/app/utils/color.dart';
import 'package:flutter/material.dart';

class ArrowBackContainer extends StatelessWidget {
  const ArrowBackContainer({super.key, required this.onpress});
  final VoidCallback onpress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: p7,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
