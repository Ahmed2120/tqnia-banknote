import 'dart:async';
import 'package:banknote/src/app/providers/auth_provider.dart';
import 'package:banknote/src/app/utils/global_methods.dart';
import 'package:banknote/src/presentation/auth/pages/signin_page.dart';
import 'package:banknote/src/presentation/welcome_page/onboarding_page1.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../app/data/models/gift.dart';
import '../../app/data/models/news.dart';
import '../home/Home/bottomNavigationbar.dart';
import '../home/gifts/gifts_page.dart';
import '../home/news/news.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.remoteMessage});

  final RemoteMessage? remoteMessage;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 1), () async{
      if( await isOnBoardOpened){
        if(await isLogin){
          if(widget.remoteMessage != null && widget.remoteMessage!.data != {}){
            handleNavigate(widget.remoteMessage!);
          }
          else{
            if (!mounted) return;
            GlobalMethods.navigateReplaceALL(context, const ControlView());

            await Provider.of<AuthProvider>(context, listen: false)
                .getUserData();
            if (!mounted) return;
            Provider.of<AuthProvider>(context, listen: false)
                .updateDeviceToken();
          }
        }
        else{
          if(!mounted) return;
          GlobalMethods.navigateReplaceALL(context, const SignInPage());
        }
      }else{
        if(!mounted) return;
        GlobalMethods.navigateReplaceALL(context, const OnBoardingPage1());

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

  void handleNavigate(RemoteMessage message) async {


      if (message.data['type'] == "news") {
        GlobalMethods.navigateReplaceALL(
            NavigationService.navigatorKey.currentState!.context,
            NewsPage());
      }
      else if (message.data['type'] == "gifts") {
        GlobalMethods.navigateReplaceALL(
            NavigationService.navigatorKey.currentState!.context,
            GiftsPage());
      }
      else if (message.data['type'] == "message") {
        GlobalMethods.navigate(
            NavigationService.navigatorKey.currentState!.context,
            const ControlView(initialIndex: 1));
      }
  }
}
