import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/app/widgets/button.dart';
import 'package:banknote/src/presentation/welcome_page/splash_page.dart';
import 'package:banknote/src/presentation/welcome_page/start_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../app/providers/lang_provider.dart';
import '../../app/utils/global_methods.dart';

class OnBoardingPage3 extends StatefulWidget {
  const OnBoardingPage3({super.key});

  @override
  State<OnBoardingPage3> createState() => _OnBoardingPage3State();
}

class _OnBoardingPage3State extends State<OnBoardingPage3> {
  bool _isEnglish = true;

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
                  height: MediaQuery.of(context).size.height / 4.3,
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
                          Center(
                            child: Text(
                              tr('set_Language'),
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 25,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     Expanded(
                          //       child: RadioListTile(
                          //         groupValue: _isEnglish,
                          //         value: true,
                          //         onChanged: (val){
                          //           _isEnglish = val!;
                          //           context.setLocale(const Locale('en'));
                          //           Provider.of<LangProvider>(context, listen: false).toggleLang(0);
                          //           setState(() {});
                          //         },
                          //         title: Text(
                          //           tr('english'),
                          //           style: TextStyle(color: Colors.grey),
                          //         ),
                          //       ),
                          //     ),
                          //     Expanded(
                          //       child: RadioListTile(
                          //         groupValue: _isEnglish,
                          //         value: false,
                          //         onChanged: (val){
                          //           _isEnglish = val!;
                          //           context.setLocale(const Locale('ar'));
                          //           Provider.of<LangProvider>(context, listen: false).toggleLang(1);
                          //           setState(() {});
                          //         },
                          //         title: Text(
                          //           tr('arabic'),
                          //           style: TextStyle(color: Colors.grey),
                          //         ),
                          //       ),
                          //     )
                          //   ],
                          // ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Button(
                                buttonHight: 52,
                                buttonWidth: 150,
                                buttonColor: context.locale.languageCode == 'en' ? p2 : p7,
                                buttonRadius: 25,
                                buttonText: tr('arabic'),
                                onpress: () {
                                  context.setLocale(const Locale('ar'));
                                  Provider.of<LangProvider>(context, listen: false).toggleLang(1);
                                  setState(() {});
                                  // GlobalMethods.navigateReplaceALL(context, const StartPage());
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (_) => const StartPage(),
                                    ),
                                  );
                                },
                                textColor: context.locale.languageCode == 'en' ? p7 : Colors.white,
                                textSize: 18,
                              ),
                              Button(
                                buttonHight: 52,
                                buttonWidth: 150,
                                buttonColor: context.locale.languageCode == 'en' ? p7 : p2,
                                buttonRadius: 25,
                                buttonText: tr('english'),
                                onpress: () {
                                  context.setLocale(const Locale('en'));
                                  Provider.of<LangProvider>(context, listen: false).toggleLang(0);
                                  setState(() {});
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (_) => const StartPage(),
                                    ),
                                  );
                                },
                                textColor: context.locale.languageCode == 'en' ? Colors.white : p7,
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
