import 'package:banknote/src/app/data/dio/exception/dio_error_extention.dart';
import 'package:banknote/src/app/data/models/user_model.dart';
import 'package:banknote/src/app/providers/auth_provider.dart';
import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/app/utils/global_methods.dart';
import 'package:banknote/src/app/utils/utils.dart';
import 'package:banknote/src/app/widgets/custom_snackbar.dart';
import 'package:banknote/src/app/widgets/input_form_field.dart';
import 'package:banknote/src/app/widgets/loading.dart';
import 'package:banknote/src/app/widgets/pages_background.dart';
import 'package:banknote/src/presentation/auth/pages/signin_page.dart';
import 'package:banknote/src/presentation/auth/widget/face&google_cont.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:quiver/strings.dart';
import '../../../app/widgets/button.dart';
import '../widget/arrow_back_cont.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key, required this.phoneNum});

  final String phoneNum;

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String? _firstname;
  String? _lastname;
  String? _email;
  String? _password;
  String? _confirmPass;
  bool _obscurePass = true;
  bool _obscureConfirm = true;
  bool _keep = false;
  bool value = true;
  _submit() async {
    if (!_formKey.currentState!.validate()) {
      if (!_autoValidate) setState(() => _autoValidate = true);

      return;
    }

    _formKey.currentState!.save();

    FocusScope.of(context).unfocus();
    try {
      LoadingScreen.show(context);

      final UserModel user = UserModel(
          email: _email, fName: _firstname, lName: _lastname, phone: widget.phoneNum);
      await context.read<AuthProvider>().register(user, _password!);
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
            builder: (_) => const SignInPage(),
          ),
          (route) => false);
    } catch (e) {
      Navigator.pop(context);
      showCustomSnackBar(readableError(e), context, isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool? checkedValue = false;
    return Scaffold(
      body: PagesBackground(
        child: Form(
          key: _formKey,
          autovalidateMode:
              _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 14,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ArrowBackContainer(
                      onpress: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 110,
                  ),
                  Image.asset("assets/images/logo.png"),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 22,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 20),
                child: Column(
                  children: [
                    const Text(
                      "Create Account ",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    InputFormField(
                      hintText: tr('firstname'),
                      onSaved: (firstname) => _firstname = firstname,
                      prefixIcon: const Icon(Icons.person),
                      validator: Validator(
                        rules: [
                          RequiredRule(
                              validationMessage: tr('username_validation')),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    InputFormField(
                      hintText: tr('lastname'),
                      onSaved: (lastname) => _lastname = lastname,
                      prefixIcon:  const Icon(Icons.person),
                      validator: Validator(
                        rules: [
                          RequiredRule(
                              validationMessage: tr('username_validation')),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    InputFormField(
                      hintText: tr('email'),
                      onSaved: (email) => _email = email,
                      prefixIcon:  const Icon(Icons.email),
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
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    InputFormField(
                      controller: TextEditingController(text: widget.phoneNum),
                      hintText: tr('phone'),
                      prefixIcon:  const Icon(Icons.phone),
                      enabled: false,
                      validator: Validator(
                        rules: [
                          MinLengthRule(8,
                              validationMessage: tr('phone_length')),
                          RequiredRule(
                              validationMessage: tr('phone_validation')),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    InputFormField(
                      obscure: _obscurePass,
                      hintText: tr('password'),
                      prefixIcon:  const Icon(Icons.lock),
                      onSaved: (password) => _password = password,
                      onChanged: (val){
                        _password = val;
                      },
                      suffixIcon: InkWell(
                        onTap: () {
                          _obscurePass = !_obscurePass;
                          setState(() {});
                        },
                        child: _obscurePass ? const Icon(CupertinoIcons.eye_slash_fill) : const Icon(
                      Icons.remove_red_eye_outlined,
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
                      prefixIcon:  const Icon(Icons.lock),
                      onSaved: (confirmPass) => _confirmPass = confirmPass,
                      suffixIcon: InkWell(
                        onTap: () {
                          _obscureConfirm = !_obscureConfirm;
                          setState(() {});
                        },
                        child: _obscureConfirm ? const Icon(CupertinoIcons.eye_slash_fill) : const Icon(
                          Icons.remove_red_eye_outlined,
                        ),
                      ),
                      validator: (val){
                        if(val!.isEmpty) {
                          return tr('confirm_password_validation');
                        }
                        if(val != _password) {
                          print(val);
                          print('_email');
                          print(_email);
                          return tr('password_not_match');
                        }
                        return null;
                      }
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 45,
                    ),
                    Row(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              // checkColor: ColorResources.white,
                              side: const BorderSide(color: Colors.white),
                              activeColor: Theme.of(context).primaryColor,
                              value: _keep,
                              onChanged: (val){
                                _keep = val!;
                                setState(() {});},),
                            // 4.pw,
                            Text(
                              tr('I accept all the Terms & Conditions'),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Button(
                        onpress: _keep ? _submit : (){},
                        buttonText: "Sign up",
                        textColor: Colors.white,
                        buttonColor: _keep ? p1 : Colors.grey,
                        buttonRadius: 20,
                        buttonHight: 60,
                        buttonWidth: 320,
                        textSize: 14),

                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        GlobalMethods.navigate(context, const SignInPage());
                      },
                      child: Center(
                          child: Text(
                        " have an account ?",
                        style: TextStyle(color: p1),
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
