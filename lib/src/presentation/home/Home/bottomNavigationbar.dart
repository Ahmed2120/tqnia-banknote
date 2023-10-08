import 'package:banknote/src/app/Controller/home_view_controller.dart';
import 'package:banknote/src/app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class ControlView extends StatelessWidget {
  const ControlView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControlViewModel>(
      init: Get.put(ControlViewModel()),
      builder: (controller) => Scaffold(
        body: controller.currentScreen,
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }

  Widget bottomNavigationBar() {
    return GetBuilder<ControlViewModel>(
      init: ControlViewModel(),
      builder: (controller) =>

          SalomonBottomBar(
       backgroundColor: p3, 
        items: [
          SalomonBottomBarItem(
          icon: SizedBox(
              height: 30,
              width: 30,
              child: Image.asset("assets/icon/Icon Home Active.png")),
          title: Text("Home"),
        ),
          SalomonBottomBarItem(
          icon: SizedBox(
              height: 30,
              width: 30,
              child: Image.asset("assets/icon/Chat.png")),
          title: Text("Chat"),
        ),
          SalomonBottomBarItem(
            icon: SizedBox(
              height: 30,
              width: 30,
              child: Image.asset("assets/icon/Notification.png"),
            ),
            title: Text("Notification")),
          SalomonBottomBarItem(
          icon: SizedBox(
            height: 30,
            width: 30,
            child: Image.asset("assets/icon/Setting.png"),
          ),
          title: Text("Setting"),
        ),
      ],
       currentIndex: controller.navigatorValue,
        onTap: (index) {
          controller.changeSelectedValue(index);
        },
        // elevation: 0,
        selectedItemColor: const Color.fromRGBO(0, 48, 96, 1),
      ),
    );
  }
}
