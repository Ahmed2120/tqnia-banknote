import 'package:banknote/src/app/Controller/home_view_controller.dart';
import 'package:banknote/src/app/utils/color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../app/providers/notification_provider.dart';

class ControlView extends StatelessWidget {
  const ControlView({super.key, this.initialIndex});

  final int? initialIndex;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControlViewModel>(
      init: Get.put(ControlViewModel(initialIndex)),
      builder: (controller) => Scaffold(
        body: controller.currentScreen,
        bottomNavigationBar: bottomNavigationBar(context),
      ),
    );
  }

  Widget bottomNavigationBar(context) {
    return GetBuilder<ControlViewModel>(
      init: ControlViewModel(initialIndex),
      builder: (controller) =>

          SalomonBottomBar(
       backgroundColor: p3,
        items: [
          SalomonBottomBarItem(
          icon: SizedBox(
              height: 30,
              width: 30,
              child: Image.asset("assets/icon/Icon Home Active.png")),
          title: Text(tr('home')),
        ),
          SalomonBottomBarItem(
          icon: SizedBox(
              height: 30,
              width: 30,
              child: Image.asset("assets/icon/Chat.png")),
          title: Text(tr('chat')),
        ),
          SalomonBottomBarItem(
            icon: SizedBox(
              height: 30,
              width: 30,
              child: Stack(
                children: [
                  Image.asset("assets/icon/Notification.png"),
                  if(Provider.of<NotificationProvider>(context).unReadNoti)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red
                        ),
                      ),
                    )
                ],
              ),
            ),
            title: Text(tr('notification'))),
          SalomonBottomBarItem(
          icon: SizedBox(
            height: 30,
            width: 30,
            child: Image.asset("assets/icon/Setting.png"),
          ),
          title: Text(tr('settings')),
        ),
      ],
       currentIndex: controller.navigatorValue!,
        onTap: (index) {
          controller.changeSelectedValue(index);
        },
        // elevation: 0,
        selectedItemColor: const Color.fromRGBO(0, 48, 96, 1),
      ),
    );
  }
}
