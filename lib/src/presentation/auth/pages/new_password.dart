import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/app/widgets/button.dart';
import 'package:banknote/src/app/widgets/input_form_field.dart';
import 'package:banknote/src/presentation/auth/pages/signin_page.dart';
import 'package:banknote/src/presentation/auth/widget/arrow_back_cont.dart';
import 'package:banknote/src/presentation/home/Home/bottomNavigationbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flrx_validator/flrx_validator.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../app/data/dio/exception/dio_error_extention.dart';
import '../../../app/providers/reset_password_provider.dart';
import '../../../app/utils/global_methods.dart';
import '../../../app/widgets/custom_snackbar.dart';
import '../../../app/widgets/pages_background.dart';

class NewPassword extends StatefulWidget {

  NewPassword({super.key, required this.phoneNum});
  final String phoneNum;

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();

  String? _password;

  String? _confirmPass;

  bool _obscurePass = true;

  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:  PagesBackground(
        child: Stack(children: [
          // Image.asset(
          //   "assets/images/Screen.jpg",
          //   fit: BoxFit.cover,
          // ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Form(
              key: _formKey,
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
                    height: MediaQuery.of(context).size.height / 25,
                  ),
                  const Text(
                    "Reset your password \nhere  ",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Enter New Password and don’t forget it",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 25,
                  ),
                  InputFormField(
                    obscure: _obscurePass,
                    hintText: tr('password'),
                    prefixIcon: Image.asset('assets/icon/Lock.png'),
                    onSaved: (password) => _password = password,
                    onChanged: (val){
                      _password = val;
                    },
                    suffixIcon: InkWell(
                      onTap: () {
                        _obscurePass = !_obscurePass;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.remove_red_eye_outlined,
                        color: _obscurePass
                            ? null
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    validator: Validator(
                      rules: [
                        MinLengthRule(8,
                            validationMessage: tr('password_length')),
                        RequiredRule(
                            validationMessage: tr('password_validation')),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 25,
                  ),
                  InputFormField(
                      obscure: _obscureConfirm,
                      hintText: tr('confirm_password'),
                      prefixIcon: Image.asset('assets/icon/Lock.png'),
                      onSaved: (confirmPass) => _confirmPass = confirmPass,
                      suffixIcon: InkWell(
                        onTap: () {
                          _obscureConfirm = !_obscureConfirm;
                          setState(() {});
                        },
                        child: Icon(
                          Icons.remove_red_eye_outlined,
                          color: _obscureConfirm
                              ? null
                              : Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      validator: (val){
                        if(val!.isEmpty) {
                          return tr('confirm_password_validation');
                        }
                        if(val != _password) {
                          print(val);
                          return tr('password_not_match');
                        }
                        return null;
                      }
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3.2,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Consumer<ResetPasswordProvider>(
                        builder: (context, resetPasswordProvider, _) {
                          return resetPasswordProvider.resetPasswordLoading ? const CircularProgressIndicator() :Button(
                            onpress: () async{
                              try{
                                if (!_formKey.currentState!.validate()) return;

                                final isSuccess = await resetPasswordProvider.resetPassword(widget.phoneNum, _password!);
                                if(isSuccess){
                                  if(!mounted) return;
                                  showCustomSnackBar('The password has been changed successfully', context, isError: false);

                                  GlobalMethods.navigateReplaceALL(
                                      context, const SignInPage());
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
          ),
        ]),
      ),
    );
  }
}
