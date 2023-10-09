import 'dart:async';
import 'package:banknote/src/app/providers/auth_provider.dart';
import 'package:banknote/src/presentation/auth/pages/signin_page.dart';
import 'package:banknote/src/presentation/welcome_page/onboarding_page1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/Home/bottomNavigationbar.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 1), () async{
      if( await isOnBoardOpened){
        if(await isLogin){
          Get.offAll(() => const ControlView());

          Provider.of<AuthProvider>(context, listen: false).getUserData();
        }
        else{
          Get.offAll(() => const SignInPage());
        }
      }else{
        Get.offAll(() => const OnBoardingPage1());

      }
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

  Future<bool>  get isOnBoardOpened async {
    final prefs = await SharedPreferences.getInstance();
    final bool isOpened = prefs.getBool('opened') ?? false;

    return isOpened;

  }

  Future<bool>  get isLogin async {
    final prefs = await SharedPreferences.getInstance();
    final bool isLogin = prefs.getBool('remember') ?? false;

    return isLogin;

  }
}
