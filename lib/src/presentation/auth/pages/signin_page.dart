import 'package:banknote/src/app/data/dio/exception/dio_error_extention.dart';
import 'package:banknote/src/app/providers/app_provider.dart';
import 'package:banknote/src/app/providers/auth_provider.dart';
import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/app/utils/utils.dart';
import 'package:banknote/src/app/widgets/button.dart';
import 'package:banknote/src/app/widgets/custom_snackbar.dart';
import 'package:banknote/src/app/widgets/input_form_field.dart';
import 'package:banknote/src/app/widgets/loading.dart';
import 'package:banknote/src/presentation/auth/pages/create_account.dart';
import 'package:banknote/src/presentation/auth/pages/recovery_password.dart';
import 'package:banknote/src/presentation/auth/widget/face&google_cont.dart';
import 'package:banknote/src/presentation/home/Home/bottomNavigationbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

import '../../../app/widgets/pages_background.dart';
import 'phone_signup.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String? _email;
  String? _password;
  bool _obscure = true;

  _submit() async {
    if (!_formKey.currentState!.validate()) {
      if (!_autoValidate) setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState!.save();
    FocusScope.of(context).unfocus();
    try {
      LoadingScreen.show(context);
      // final fcmToken = await context.read<AppProvider>().getFCMToken();
      if (!mounted) return;
      await context.read<AuthProvider>().login(_email!, _password!);
      if (!mounted) return;
       Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
            builder: (_) => const ControlView(),
          ),
          (route) => false);
    } catch (e) {
      Navigator.pop(context);
      showCustomSnackBar(readableError(e), context, isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  PagesBackground(
        child: Form(
          key: _formKey,
          autovalidateMode:
              _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset("assets/images/logodark.png"),
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
                  padding: const EdgeInsets.only(
                      right: 14.0, left: 14.0, bottom: 14.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 35,
                      ),
                      Text(
                        tr('login_desc'),
                        style:
                            const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 16,
                      ),
                      InputFormField(
                        hintText: tr('email'),
                        onSaved: (username) => _email = username,
                        prefixIcon: const Icon(Icons.email_outlined),
                        validator: (email) {
                          if (isBlank(email)) {
                            return tr('email_validation');
                          }
                          if (EmailChecker.isNotValid(email!)) {
                            return tr('email_invalid');
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      InputFormField(
                        obscure: _obscure,
                        hintText: tr('password'),
                        prefixIcon: Image.asset('assets/icon/Lock.png'),
                        onSaved: (password) => _password = password,
                        suffixIcon: InkWell(
                          onTap: () {
                            _obscure = !_obscure;
                            setState(() {});
                          },
                          child: Icon(
                            Icons.remove_red_eye_outlined,
                            color: _obscure
                                ? null
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Consumer<AuthProvider>(
                              builder: (context, authProvider, child) => Checkbox(
                                // checkColor: ColorResources.white,
                                activeColor: Theme.of(context).primaryColor,
                                value: authProvider.remember,
                                onChanged: authProvider.changeRemember,),),


                            Text(tr('remember')),]),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) => RecoveryPasswordPage(),
                                ),
                              );
                            },
                            child: Text(
                              tr("forget_password"),
                              style: const TextStyle(
                                fontSize: 13,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      Button(
                          onpress: _submit,
                          buttonText: tr('login'),
                          textColor: Colors.white,
                          buttonColor: p1,
                          buttonRadius: 20,
                          buttonHight: 60,
                          buttonWidth: 320,
                          textSize: 14),
                      const SizedBox(
                        height: 30,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     const Text(
                      //       "______________     ",
                      //       style: TextStyle(color: Colors.grey, fontSize: 14),
                      //     ),
                      //     Text(
                      //       tr("or"),
                      //       style: const TextStyle(color: Colors.grey, fontSize: 14),
                      //     ),
                      //     const Text(
                      //       "   ______________",
                      //       style: TextStyle(color: Colors.grey, fontSize: 14),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 40,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     SinInMethod(
                      //       methodImage: "assets/icon/google.png",
                      //       methodText: "google",
                      //       onpress: () {},
                      //     ),
                      //     const SizedBox(
                      //       width: 30,
                      //     ),
                      //     SinInMethod(
                      //       methodImage: 'assets/icon/facebook.png',
                      //       methodText: 'Facebook',
                      //       onpress: () {},
                      //     )
                      //   ],
                      // ),
                      const SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => PhoneSignupPage(),
                            ),
                          );
                        },
                        child: Center(
                            child: Text(
                          tr("not_have_account"),
                          style: const TextStyle(color: Colors.blue),
                        )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
