import 'package:flutter/material.dart';

class ChatServicCont extends StatelessWidget {
  const ChatServicCont({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 120,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 9,
            offset: const Offset(0, 3),
          ),
        ]
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage("assets/images/person.png"),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Customers Service", style: TextStyle(fontSize: 16),),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [
                        Color(0xFFFF4B4B),
                        Color(0xFFCC3232),
                      ])
                    ),
                  ),
                  const SizedBox(width: 3,),
                  const Text(
                    "Online",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
          const Spacer(),
          const Align(alignment: Alignment.topRight, child: Icon(Icons.more_vert))
        ],
      ),
    );
  }
}
