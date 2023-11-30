import 'dart:async';

import 'package:banknote/src/app/data/dio/exception/dio_error_extention.dart';
import 'package:banknote/src/app/providers/reset_password_provider.dart';
import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/app/widgets/button.dart';
import 'package:banknote/src/app/widgets/input_form_field.dart';
import 'package:banknote/src/presentation/auth/pages/new_password.dart';
import 'package:banknote/src/presentation/auth/pages/signup_page.dart';
import 'package:banknote/src/presentation/auth/widget/arrow_back_cont.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../app/utils/global_methods.dart';
import '../../../app/widgets/custom_snackbar.dart';
import '../../../app/widgets/pages_background.dart';
import 'create_account.dart';

class OtpPage extends StatefulWidget {
  OtpPage({super.key, required this.phoneNum, this.flag});

  final String phoneNum;
  final int? flag;   // if ( 1 ) navigate to signup else navigate to new password

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  Timer? timer;
  Duration remainTimer = const Duration(minutes: 1);

  @override
  void initState() {
    super.initState();

startTimer();
  }

  @override
  void dispose() {
    super.dispose();

    stopTimer();
  }

  final _formKey = GlobalKey<FormState>();

  final _1Controller = TextEditingController();

  final _2Controller = TextEditingController();

  final _3Controller = TextEditingController();

  final _4Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String timerText =
        '${remainTimer.inMinutes.remainder(60).toString()}:${remainTimer
        .inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body:  PagesBackground(
        child:  Stack(children: [
          // Image.asset(
          //   "assets/images/Screen.jpg",
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   fit: BoxFit.cover,
          // ),
          Padding(
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
                          Image.asset("assets/images/logo.png"),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 22,
                      ),
                      const Text(
                        "OTP Code",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Enter OTP code that sent \n to +20 ${widget.phoneNum}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildSizedBox(context, first: true, last: false, controller: _1Controller),
                            const SizedBox(width: 25,),
                            buildSizedBox(context, first: false, last: false, controller: _2Controller),
                            const SizedBox(width: 25,),
                            buildSizedBox(context, first: false, last: false, controller: _3Controller),
                            const SizedBox(width: 25,),
                            buildSizedBox(context, first: false, last: true, controller: _4Controller),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text('$timerText Sec', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Consumer<ResetPasswordProvider>(
                          builder: (context, resetPasswordProvider, _) {
                            return RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: 'Don’t receive code ? ',
                                    style:
                                    TextStyle(color: Colors.white, fontSize: 19),
                                    children: [
                                      TextSpan(
                                          text: resetPasswordProvider.storeOtpLoading
                                              ? '...' : 'Re-send',
                                          style: TextStyle(
                                              color: p1,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w600),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = remainTimer.inSeconds > 0 ? null : () async{
                                              try{
                                              final isSuccess = await resetPasswordProvider
                                                  .storeOtp(widget.phoneNum);
                                              if(isSuccess){
                                                remainTimer = const Duration(minutes: 1);

                                                setState(() {});
                                                if(!mounted) return;
                                                showCustomSnackBar('otp resent successfully', context, isError: false);
                                              }
                                            }catch(e){
                                                showCustomSnackBar(readableError(e), context);
                                              }
                                            // GlobalMethods.navigate(context, const RolePage());
                                            }),
                                    ]));
                          }
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Consumer<ResetPasswordProvider>(
                        builder: (context, resetPasswordProvider, _) {
                          return resetPasswordProvider.checkCodeLoading ? const CircularProgressIndicator() : Button(
                              onpress: () async{
                                try{
                                  if(!_formKey.currentState!.validate()) return;
                                  int code = int.parse(_1Controller.text + _2Controller.text + _3Controller.text +_4Controller.text);
                                  final isSuccess = await resetPasswordProvider.checkCode(widget.phoneNum, code);
                                  if(isSuccess){
                                    if(!mounted) return;
                                    GlobalMethods.navigate(
                                        context,
                                        widget.flag == 1 ? CreateAccountPage(phoneNum: widget.phoneNum,) :
                                        NewPassword(phoneNum: widget.phoneNum,));
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
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget buildSizedBox(BuildContext context, {controller, bool first = false, bool last = false}) {
    return SizedBox(
      // color: Colors.red,
      height: 60,
      width: 60,
      child: TextFormField(
        controller: controller,
        onChanged: (val){
          if(val.length == 1) FocusScope.of(context).nextFocus();

          if(val.isEmpty && !first) FocusScope.of(context).previousFocus();
        },
        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            errorStyle: const TextStyle(
              fontSize: 0, // change the font size of the error message
            ),
            filled: true,
            fillColor: Colors.white30,
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(10)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(10)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(10))
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        validator: (val) {
          if (val!.isEmpty) {
            return '';
          }
        },
      ),
    );
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if(remainTimer.inSeconds > 0) {
        remainTimer = remainTimer - const Duration(seconds: 1);
        setState(() {});
      }else{
        stopTimer();
      }

    });
  }

  void stopTimer() {
    timer?.cancel();
  }
}
