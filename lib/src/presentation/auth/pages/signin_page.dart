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
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 35,
              ),
              Center(child: Image.asset("assets/images/logo.png")),
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
                          const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
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
                      prefixIcon: const Icon(Icons.lock),
                      onSaved: (password) => _password = password,
                      suffixIcon: InkWell(
                        onTap: () {
                          _obscure = !_obscure;
                          setState(() {});
                        },
                        child: _obscure ? const Icon(CupertinoIcons.eye_slash_fill) : const Icon(
                          Icons.remove_red_eye_outlined,
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
                              side: const BorderSide(color: Colors.white),
                              activeColor: Theme.of(context).primaryColor,
                              value: authProvider.remember,
                              onChanged: authProvider.changeRemember,),),


                          Text(tr('remember'), style: const TextStyle(color: Colors.white),),]),
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
                            style: TextStyle(
                              // fontSize: 15,
                              decoration: TextDecoration.underline,
                              color: p7
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
                        buttonColor: p7,
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
                    //       style: TextStyle(color: Colors.grey, fontSize: 16),
                    //     ),
                    //     Text(
                    //       tr("or"),
                    //       style: const TextStyle(color: Colors.grey, fontSize: 16),
                    //     ),
                    //     const Text(
                    //       "   ______________",
                    //       style: TextStyle(color: Colors.grey, fontSize: 16),
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
                        style: TextStyle(color: p7, fontSize: 16),
                      )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
