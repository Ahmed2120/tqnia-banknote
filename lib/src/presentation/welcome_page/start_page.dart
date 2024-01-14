import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/app/widgets/button.dart';
import 'package:banknote/src/presentation/auth/pages/signin_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: p4,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              height: 80,
            ),
            Expanded(child: Image.asset("assets/images/start.png")),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            Image.asset("assets/images/startText.png"),
            SizedBox(
              height: 20,
            ),
            Button(
              buttonColor: p3,
              buttonHight: 52,
              buttonRadius: 25,
              buttonText: tr('start_app'),
              buttonWidth: 230,
              onpress: () async{
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('opened', true);

                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => const SignInPage(),
                  ),
                );
              },
              textColor: Colors.black,
              textSize: 18,
            ),
          ]),
        ),
      ),
    );
  }
}
