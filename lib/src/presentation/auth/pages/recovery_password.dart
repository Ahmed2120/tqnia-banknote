import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/app/widgets/button.dart';
import 'package:banknote/src/app/widgets/input_form_field.dart';
import 'package:banknote/src/presentation/auth/pages/new_password.dart';
import 'package:banknote/src/presentation/auth/widget/arrow_back_cont.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecoveryPasswordPage extends StatelessWidget {
  const RecoveryPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          "assets/images/Screen.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 14,
              ),
              Row(
                children: [
                  ArrowBackContainer(
                    onpress: () {
                      Get.back();
                    },
                  ),
                  const SizedBox(
                    width: 110,
                  ),
                  Image.asset("assets/images/logodark.png"),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 22,
              ),
              const Text(
                "recovery Your \nPassword  ",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter Your Phone To get otp to reset \nPassword  ",
                style: TextStyle(
                  fontSize: 12,
                ),
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
                height: MediaQuery.of(context).size.height / 2.5,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Button(
                    onpress: () {
                      Get.to(() => const NewPassword());
                    },
                    buttonText: "Next",
                    textColor: Colors.white,
                    buttonColor: p1,
                    buttonRadius: 20,
                    buttonHight: 50,
                    buttonWidth: 130,
                    textSize: 16),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
