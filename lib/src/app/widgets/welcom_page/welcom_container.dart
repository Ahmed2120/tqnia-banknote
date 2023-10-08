import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/presentation/welcome_page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presentation/auth/pages/signin_page.dart';

class WelcomeContainer extends StatelessWidget {
  WelcomeContainer({
    super.key,
    required this.title,
    required this.supText,
    required this.onPressed,
  });
  String title;
  String supText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  supText,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.offAll(() => const SignInPage()),
                      child: Container(
                        height: 50,
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                          child: Text(
                            "Skip",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onPressed,
                      child: Container(
                        height: 50,
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20), color: p1),
                        child: const Center(
                          child: Text(
                            "Next",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
