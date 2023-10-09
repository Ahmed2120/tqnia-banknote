import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/presentation/home/Setting/setting_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/utils/global_methods.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          "assets/images/Screen.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
           SizedBox(
           height: MediaQuery.of(context).size.height/30,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Center(child: Image.asset("assets/images/logodark.png")),
                       SizedBox(
                     height: MediaQuery.of(context).size.height/30,
                  ),
                  Text(
                    tr('notification'),
                    style: TextStyle(fontSize: 20),
                  ),
                   SizedBox(
                     height: MediaQuery.of(context).size.height/30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(tr('recent'),
                              style: TextStyle(fontSize: 20, color: p4)),
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: p1),
                            child: const Center(
                                child: Text("4",
                                    style: TextStyle(color: Colors.white))),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          GlobalMethods.navigate(context, const SettingPage());
                        },
                        child: Text(
                          tr('clear_all'),
                          style: TextStyle(color: p1),
                        ),
                      )
                    ],
                  ),
                   SizedBox(
                     height: MediaQuery.of(context).size.height/30,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/icon/recivmessage.png"),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Kathryn Sent You a Message"),
                            Text(
                              "Tap to see the message",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        const Text(
                          "2m ago",
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        )
                      ]),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.grey,
                  )
                ]),
          ),
        ]),
      ]),
    );
  }
}
