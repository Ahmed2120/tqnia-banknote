import 'dart:io';

import 'package:banknote/src/app/data/dio/exception/dio_error_extention.dart';
import 'package:banknote/src/app/providers/form_provider.dart';
import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/app/utils/global_methods.dart';
import 'package:banknote/src/app/widgets/button.dart';
import 'package:banknote/src/app/widgets/custom_snackbar.dart';
import 'package:banknote/src/app/widgets/input_form_field.dart';
import 'package:banknote/src/presentation/auth/widget/arrow_back_cont.dart';
import 'package:banknote/src/presentation/home/SubmitForm/widget/add_attachment_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import 'widget/custom_dropdown.dart';

class SubmitFormPage extends StatefulWidget {
  const SubmitFormPage({super.key});

  @override
  State<SubmitFormPage> createState() => _SubmitFormPageState();
}

class _SubmitFormPageState extends State<SubmitFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String? _firstname;
  String? _date = 'Choose date';
  String? _phone;
  String? _city;
  String? _detailLocation;
  bool _obscure = true;
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  _submit() async {
    // final form = Provider.of<CreateFormProvider>(context,listen: false);
    // if (!_formKey.currentState!.validate()) {
    //   if (!_autoValidate) setState(() => _autoValidate = true);
    //   return;
    // }
    // _formKey.currentState!.save();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height:
          MediaQuery.of(context).size.height / 2,
          child: Column(
            children: [
              SizedBox(
                height:
                MediaQuery.of(context).size.height /
                    60,
              ),

              SizedBox(
                height:
                MediaQuery.of(context).size.height /
                    3,
                child: Lottie.asset('assets/JSON/done.json'),
              ),
              SizedBox(
                height:
                MediaQuery.of(context).size.height /
                    60,
              ),
              const Text("Congratulation !!"),
            ],
          ),
        );
      },
    );
    try {
      // await form.createForm(
      //   _firstname!,
      //   _phone!,
      //   _city!,
      //   _detailLocation!,
      //   image: _imageFile,
      // );
    } catch (e) {
      Navigator.pop(context);
      showCustomSnackBar(readableError(e), context, isError: true);
    }
  }

  _cancel() async {
    // final form = Provider.of<CreateFormProvider>(context,listen: false);
    // if (!_formKey.currentState!.validate()) {
    //   if (!_autoValidate) setState(() => _autoValidate = true);
    //   return;
    // }
    // _formKey.currentState!.save();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height:
          MediaQuery.of(context).size.height / 2,
          child: Column(
            children: [
              SizedBox(
                height:
                MediaQuery.of(context).size.height /
                    60,
              ),

              SizedBox(
                height:
                MediaQuery.of(context).size.height /
                    3,
                child: Lottie.asset('assets/JSON/warning.json', width: 50, height: 50),
              ),
              SizedBox(
                height:
                MediaQuery.of(context).size.height /
                    80,
              ),
              const Text("Wait, you are already registered on this service"),
            ],
          ),
        );
      },
    );
    try {
      // await form.createForm(
      //   _firstname!,
      //   _phone!,
      //   _city!,
      //   _detailLocation!,
      //   image: _imageFile,
      // );
    } catch (e) {
      Navigator.pop(context);
      showCustomSnackBar(readableError(e), context, isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        autovalidateMode:
            _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: SingleChildScrollView(
          child: Stack(children: [
            Image.asset(
              "assets/images/Screen.jpg",
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ArrowBackContainer(
                          onpress: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3.5,
                        ),
                        Image.asset("assets/images/logodark.png"),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Collection 1"),
                        Text(
                          "50.20 SAR",
                          style: TextStyle(color: p1),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 70,
                    ),
                    const Text(
                      "Please fill in the following information",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                    ),
                    const Text("Full Name"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    InputFormField(
                      hintText: tr('Enter your Name'),
                      onSaved: (firstname) => _firstname = firstname,
                      prefixIcon: Image.asset('assets/icon/Profile.png'),
                      validator: Validator(
                        rules: [
                          RequiredRule(
                            validationMessage: tr('username_validation'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    const Text("Phone Number"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    InputFormField(
                      hintText: tr('Phone Number'),
                      onSaved: (phone) => _phone = phone,
                      prefixIcon: Image.asset('assets/icon/Calling.png'),
                      validator: Validator(
                        rules: [
                          RequiredRule(
                            validationMessage: tr('phone_validation'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    const Text("Date"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext builder) {
                            return SizedBox(
                              height:
                              MediaQuery.of(context).size.height / 2,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height /
                                        60,
                                  ),
                                  const Text("Choose date"),
                                  SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height /
                                        3,
                                    child: CupertinoDatePicker(
                                      initialDateTime: DateTime.now(),
                                      onDateTimeChanged:
                                          (DateTime newdate) {
                                        // Do something with the new date
                                      },
                                      use24hFormat: true,
                                      maximumDate: DateTime.now()
                                          .add(const Duration(days: 365)),
                                      minimumYear: DateTime.now().year - 4,
                                      maximumYear: DateTime.now().year + 2,
                                      minuteInterval: 1,
                                      mode: CupertinoDatePickerMode.date,
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height /
                                        60,
                                  ),
                                  Button(
                                      onpress: () {},
                                      buttonText: "Confirm Date",
                                      textColor: Colors.white,
                                      buttonColor: p1,
                                      buttonRadius: 18,
                                      buttonHight: 80,
                                      buttonWidth: 300,
                                      textSize: 18)
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFF3F3F3)),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.date_range, color: p7,),
                          trailing: Icon(Icons.arrow_drop_down),
                          title: Text(_date!),
                          horizontalTitleGap: 0,
                          onTap: (){
                            String? date;
                            showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext builder) {
                                            return SizedBox(
                                              height:
                                                  MediaQuery.of(context).size.height / 2,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context).size.height /
                                                            60,
                                                  ),
                                                  const Text("Choose date"),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context).size.height /
                                                            3,
                                                    child: CupertinoDatePicker(
                                                      initialDateTime: DateTime.now(),
                                                      onDateTimeChanged:
                                                          (DateTime newdate) {
                                                            date = GlobalMethods().scheduleDateFormat(newdate);
                                                      },
                                                      use24hFormat: true,
                                                      maximumDate: DateTime.now()
                                                          .add(Duration(days: 365)),
                                                      minimumYear: DateTime.now().year - 4,
                                                      maximumYear: DateTime.now().year + 2,
                                                      minuteInterval: 1,
                                                      mode: CupertinoDatePickerMode.date,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context).size.height /
                                                            60,
                                                  ),
                                                  Button(
                                                      onpress: () {
                                                        _date = date ?? _date;
                                                        setState(() {});
                                                      Navigator.pop(context);
                                                        },
                                                      buttonText: "Confirm Date",
                                                      textColor: Colors.white,
                                                      buttonColor: p1,
                                                      buttonRadius: 18,
                                                      buttonHight: 50,
                                                      buttonWidth: 300,
                                                      textSize: 18)
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },

                        ),
                      ),

                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 70,
                    ),
                    const Text("City / Province"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    InputFormField(
                      hintText: tr('Enter your City'),
                      onSaved: (city) => _city = city,
                      prefixIcon: Icon(Icons.location_on_outlined,color: p7,size: 35,),
                      validator: Validator(
                        rules: [
                          RequiredRule(
                            validationMessage: tr('city_validation'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 70,
                    ),
                    const Text("Detail Location"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 70,
                    ),
                    TextFormField(
                      onSaved:(detailLocation) => _detailLocation = detailLocation,
                      validator: Validator(
                        rules: [
                          RequiredRule(
                            validationMessage: tr('detailLocation_validation'),
                          ),
                        ],
                      ),
                      decoration: InputDecoration(
                        hintText:
                            "Type detailed location to make it easier for us to pick up the package",
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                      maxLength: 250,
                      maxLines: 10,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    const Text("number of members"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 70,
                    ),
                    CustomDropDown(list: [1, 2, 3, 4], onChange: (val){
                      print(val);
                    }, hintText: 'chose number',),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    const AddAttachmentWidget(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: _cancel,
                          child: Container(
                            height: 50,
                            width: 160,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.red)
                            ),
                            child: const Center(
                                child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                              ),
                            )),
                          ),
                        ),
                        Button(
                            onpress: _submit,
                            buttonText: "Done",
                            textColor: Colors.white,
                            buttonColor: p1,
                            buttonRadius: 18,
                            buttonHight: 50,
                            buttonWidth: 160,
                            textSize: 18)
                      ],
                    )
                  ],
                ),
              ),
            ])
          ]),
        ),
      ),
    );
  }
}
