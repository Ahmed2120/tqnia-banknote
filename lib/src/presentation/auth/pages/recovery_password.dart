import 'package:banknote/src/app/data/dio/exception/dio_error_extention.dart';
import 'package:banknote/src/app/providers/reset_password_provider.dart';
import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/app/widgets/button.dart';
import 'package:banknote/src/app/widgets/custom_snackbar.dart';
import 'package:banknote/src/app/widgets/input_form_field.dart';
import 'package:banknote/src/presentation/auth/pages/new_password.dart';
import 'package:banknote/src/presentation/auth/pages/otp_page.dart';
import 'package:banknote/src/presentation/auth/widget/arrow_back_cont.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../app/utils/global_methods.dart';
import '../../../app/widgets/pages_background.dart';

class RecoveryPasswordPage extends StatelessWidget {
  RecoveryPasswordPage({super.key});

  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:  PagesBackground(
        child: Stack(children: [
          Image.asset(
            "assets/images/Screen.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 14,
                ),
                Row(
                  children: [
                    ArrowBackContainer(
                      onpress: () {
                        Navigator.pop(context);
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
                Form(
                  key: _formKey,
                  child: InputFormField(
                    controller: _phoneController,
                    hintText: tr(' Enter Phone'),
                    //  onSaved: (firstname) => _firstname = firstname,
                    prefixIcon: Image.asset('assets/icon/Calling.png'),
                    validator: Validator(
                      rules: [
                        RequiredRule(validationMessage: tr('phone_validation')),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Consumer<ResetPasswordProvider>(
                    builder: (context, resetPasswordProvider, _) {
                      return resetPasswordProvider.storeOtpLoading ? const CircularProgressIndicator() : Button(
                          onpress: () async{
                            try{
                              if(!_formKey.currentState!.validate()) return;
                            final isSuccess = await resetPasswordProvider.storeOtp(_phoneController.text);
                            if(isSuccess){
                              GlobalMethods.navigate(
                                  context, OtpPage(phoneNum: _phoneController.text));
                            }
                          }catch(e){
                              showCustomSnackBar(readableError(e), context);
                            }
                        },
                          buttonText: "Next",
                          textColor: Colors.white,
                          buttonColor: p1,
                          buttonRadius: 20,
                          buttonHight: 50,
                          buttonWidth: 130,
                          textSize: 16);
                    }
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
