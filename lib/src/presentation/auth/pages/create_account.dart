import 'package:banknote/src/app/data/dio/exception/dio_error_extention.dart';
import 'package:banknote/src/app/data/models/user_model.dart';
import 'package:banknote/src/app/providers/auth_provider.dart';
import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/app/utils/utils.dart';
import 'package:banknote/src/app/widgets/custom_snackbar.dart';
import 'package:banknote/src/app/widgets/input_form_field.dart';
import 'package:banknote/src/app/widgets/loading.dart';
import 'package:banknote/src/presentation/auth/pages/signin_page.dart';
import 'package:banknote/src/presentation/auth/widget/face&google_cont.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:quiver/strings.dart';
import '../../../app/widgets/button.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

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
  String? _phone;
  bool _obscure = true;
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
          email: _email, fName: _firstname, lName: _lastname, phone: _phone);
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
      body: Form(
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
                padding:
                    const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 20),
                child: Column(
                  children: [
                    const Text(
                      "Create Account ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    InputFormField(
                      hintText: tr('firstname'),
                      onSaved: (firstname) => _firstname = firstname,
                      prefixIcon: Image.asset('assets/icon/Profile.png'),
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
                      prefixIcon: Image.asset('assets/icon/Profile.png'),
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
                      prefixIcon: Image.asset('assets/icon/Message.png'),
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
                      hintText: tr('phone'),
                      prefixIcon: Image.asset('assets/icon/Calling.png'),
                      onSaved: (phone) => _phone = phone,
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
                      height: MediaQuery.of(context).size.height / 45,
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            _keep = !_keep;
                            setState(() {});
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _keep
                                  ? Image.asset(
                                      'assets/icon/Check List Icon.png')
                                  : Container(
                                      height: 22,
                                      width: 22,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                              4.pw,
                              Text(
                                tr('I accept all the Terms & Conditions'),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Button(
                        onpress: _submit,
                        buttonText: "Sign up",
                        textColor: Colors.white,
                        buttonColor: p1,
                        buttonRadius: 20,
                        buttonHight: 60,
                        buttonWidth: 320,
                        textSize: 14),
                     SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "______________     ",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        Text(
                          "OR",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        Text(
                          "   ______________",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                     SizedBox(
                     height: MediaQuery.of(context).size.height / 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SinInMethod(
                          methodImage: "assets/icon/google.png",
                          methodText: "google",
                          onpress: () {},
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        SinInMethod(
                          methodImage: 'assets/icon/facebook.png',
                          methodText: 'Facebook',
                          onpress: () {},
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const SignInPage());
                      },
                      child: const Center(
                          child: Text(
                        " have an account ?",
                        style: TextStyle(color: Colors.blue),
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
