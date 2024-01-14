import 'package:banknote/src/app/data/dio/exception/dio_error_extention.dart';
import 'package:banknote/src/app/providers/auth_provider.dart';
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

import '../../../../main.dart';
import '../../../app/utils/global_methods.dart';
import '../../../app/widgets/pages_background.dart';

class PhoneSignupPage extends StatelessWidget {
  PhoneSignupPage({super.key});

  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body:  PagesBackground(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Expanded(
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
                        Center(child: Image.asset("assets/images/logo.png")),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 22,
                    ),
                    Text(
                      tr('signup'),
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Form(
                      key: _formKey,
                      child: InputFormField(
                        controller: _phoneController,
                        hintText: tr('enter_phone'),
                        //  onSaved: (firstname) => _firstname = firstname,
                        prefixIcon: const Icon(Icons.phone),
                        validator: Validator(
                          rules: [
                            RequiredRule(validationMessage: tr('phone_validation')),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Consumer<AuthProvider>(
                      builder: (context, authProvider, _) {
                        return authProvider.createPhoneLoading ? const CircularProgressIndicator() : Button(
                            onpress: () async{
                              try{
                                if(!_formKey.currentState!.validate()) return;
                                final isSuccess = await authProvider.createPhone(_phoneController.text);
                                if(isSuccess){
                                  GlobalMethods.navigate(
                                      context, OtpPage(phoneNum: _phoneController.text, flag: 1,));
                                }
                              }catch(e){
                                showCustomSnackBar(readableError(NavigationService.currentContext.locale.languageCode == 'en' ? e
                                    : 'رقم الهاتف تم أخذه.'), context);
                              }
                            },
                            buttonText: tr("next"),
                            textColor: Colors.white,
                            buttonColor: p7,
                            buttonRadius: 20,
                            buttonHight: 50,
                            buttonWidth: 130,
                            textSize: 16);
                      }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
