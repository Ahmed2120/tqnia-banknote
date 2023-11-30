import 'package:flutter/material.dart';

class InformationWidget extends StatelessWidget {
  InformationWidget({super.key, required this.infoText, required this.onpress});
  String infoText;
  final VoidCallback onpress;
  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //      SizedBox(
    //       height: MediaQuery.of(context).size.height/30
    //     ),
    //     const Divider(
    //       height: 20,
    //       color: Colors.black54,
    //       thickness: 1,
    //     ),
    //      SizedBox(
    //       height: MediaQuery.of(context).size.height/30
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text(infoText, style: TextStyle(fontSize: 16,
    //         color: Colors.white, fontWeight: FontWeight.w600),),
    //         GestureDetector(
    //           onTap: onpress,
    //           child: const Icon(
    //             Icons.arrow_forward_ios,
    //             color: Colors.grey,
    //           ),
    //         )
    //       ],
    //     ),
    //   ],
    // );

    return InkWell(
      onTap: onpress,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(infoText, style: TextStyle(fontSize: 18,
                color: Colors.white, fontWeight: FontWeight.w600),),
                GestureDetector(
                  onTap: onpress,
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                )
              ],
            ),
      ),
    );
  }
}
