import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ChatServicCont extends StatelessWidget {
  const ChatServicCont({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(tr('customer_service'), style: TextStyle(fontSize: 22, color: Colors.white),),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green
              ),
            ),
            const SizedBox(width: 3,),
            Text(
              tr('online'),
              style: TextStyle(fontSize: 16, color: Colors.white,),
            ),
          ],
        )
      ],
    );
  }
}
