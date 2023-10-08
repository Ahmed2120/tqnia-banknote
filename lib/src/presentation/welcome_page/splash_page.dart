import 'dart:async';
import 'package:banknote/src/presentation/welcome_page/onboarding_page1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 1), () {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => const OnBoardingPage1(),
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          "assets/images/Splash.png",
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Center(
          child: Image.asset("assets/images/logo1.png"),
        ),
      ]),
    );
  }
}
