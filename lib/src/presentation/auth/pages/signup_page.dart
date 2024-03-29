import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/app/widgets/button.dart';
import 'package:banknote/src/presentation/auth/pages/create_account.dart';
import 'package:banknote/src/app/widgets/input_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app/widgets/pages_background.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  PagesBackground(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(child: CircleAvatar(
                      backgroundColor: Colors.black38,
                      radius: 50,
                      child: Image.asset("assets/images/logodark.png"))),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 11,
                  ),
                  Image.asset(
                    "assets/images/rightLogo.png",
                    width: MediaQuery.of(context).size.width / 3.2,
                    height: MediaQuery.of(context).size.height / 5.5,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(children: [
                  const Text(
                    "Sign Up ",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  InputFormField(
                    hintText: tr(' Enter Phone'),
                    //  onSaved: (firstname) => _firstname = firstname,
                    prefixIcon: Image.asset('assets/icon/Calling.png'),
                    // validator: Validator(
                    //   rules: [
                    //     RequiredRule(validationMessage: tr('username_validation')),
                    //   ],
                    // ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2.2,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Button(
                        onpress: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => const CreateAccountPage(phoneNum: '',),
                            ),
                          );
                        },
                        buttonText: "Next",
                        textColor: Colors.white,
                        buttonColor: p7,
                        buttonRadius: 20,
                        buttonHight: 50,
                        buttonWidth: 130,
                        textSize: 16),
                  ),
                ]),
              ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
