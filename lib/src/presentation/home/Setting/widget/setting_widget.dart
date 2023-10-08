import 'package:flutter/material.dart';

class InformationWidget extends StatelessWidget {
  InformationWidget({super.key, required this.infoText, required this.onpress});
  String infoText;
  final VoidCallback onpress;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         SizedBox(
          height: MediaQuery.of(context).size.height/30
        ),
        const Divider(
          height: 5,
        ),
         SizedBox(
          height: MediaQuery.of(context).size.height/30
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(infoText, style: TextStyle(fontSize: 16),),
            GestureDetector(
              onTap: onpress,
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ],
    );
  }
}
