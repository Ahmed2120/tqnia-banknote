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
      // resizeToAvoidBottomInset: false,
      body:  PagesBackground(
        child: Column(
          children: [
            Expanded(
              child: Padding(
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
                        Center(child: Image.asset("assets/images/logo.png")),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 22,
                    ),
                    Text(
                      tr("recovery_password"),
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      tr("recovery_password_body"),
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffA29EB6)
                      ),
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
                        prefixIcon: Image.asset('assets/icon/Calling.png'),
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
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
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
    );
  }
}
