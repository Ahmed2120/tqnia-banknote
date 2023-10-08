import 'package:banknote/src/presentation/welcome_page/onboarding_page3.dart';
import 'package:banknote/src/app/widgets/welcom_page/welcom_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardingPage2 extends StatelessWidget {
  const OnBoardingPage2({super.key});

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
              SizedBox(
                height: MediaQuery.of(context).size.height / 12,
              ),
              Expanded(child: Center(child: Image.asset("assets/images/coin2.png"))),
              
              WelcomeContainer(
                onPressed: (() {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => const OnBoardingPage3(),
                    ),
                  );
                }),
                title: 'Registration in all kinds of loans and associations',
                supText:
                    'Hire expert & professional service provider to make your daily life work easier',
              ),
            ],
          )
        ],
      ),
    );
  }
}
