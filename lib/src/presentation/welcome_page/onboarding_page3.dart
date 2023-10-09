import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/app/widgets/button.dart';
import 'package:banknote/src/presentation/welcome_page/splash_page.dart';
import 'package:banknote/src/presentation/welcome_page/start_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingPage3 extends StatelessWidget {
  const OnBoardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/Splash.png",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              Center(child: Image.asset("assets/images/logo.png")),
              const SizedBox(
                height: 10,
              ),
              Expanded(child: Center(child: Image.asset("assets/images/page3.png"))),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Center(
                            child: Text(
                              "Set Language",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                                width:
                                    MediaQuery.of(context).size.width / 2.7,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: p3),
                                child: const Center(
                                  child: Text(
                                    "English",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                                width:
                                    MediaQuery.of(context).size.width / 2.7,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: p3),
                                child: const Center(
                                  child: Text(
                                    "Arabic",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Button(
                                buttonHight: 52,
                                buttonWidth: 150,
                                buttonColor: Colors.white,
                                buttonRadius: 25,
                                buttonText: 'Skip',
                                onpress: () {
                                  Get.offAll(() => const StartPage());
                                },
                                textColor: Colors.grey,
                                textSize: 18,
                              ),
                              Button(
                                buttonHight: 52,
                                buttonWidth: 150,
                                buttonColor: p1,
                                buttonRadius: 25,
                                buttonText: 'Next',
                                onpress: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (_) => const StartPage(),
                                    ),
                                  );
                                },
                                textColor: Colors.white,
                                textSize: 18,
                              )
                            ],
                          )
                        ]),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
