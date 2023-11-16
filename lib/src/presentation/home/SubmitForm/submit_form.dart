import 'dart:io';

import 'package:banknote/src/app/data/dio/exception/dio_error_extention.dart';
import 'package:banknote/src/app/data/models/category_form_model.dart';
import 'package:banknote/src/app/data/models/category_model.dart';
import 'package:banknote/src/app/providers/form_provider.dart';
import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/app/utils/global_methods.dart';
import 'package:banknote/src/app/widgets/alert_dialog.dart';
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

import '../../../app/widgets/pages_background.dart';
import '../Home/bottomNavigationbar.dart';
import 'widget/custom_dropdown.dart';

class SubmitFormPage extends StatefulWidget {
  const SubmitFormPage({super.key, required this.categoryForm, required this.formUsers});

  final CategoryFormModel categoryForm;
  final List<FormUsers>? formUsers;

  @override
  State<SubmitFormPage> createState() => _SubmitFormPageState();
}

class _SubmitFormPageState extends State<SubmitFormPage> {

  @override
  void initState() {
    super.initState();

    print('widget.categoryForm.formData........');
    print(widget.categoryForm.formData![0].inputName);
    print(widget.categoryForm.price);
      _titleController.text = widget.categoryForm.title ?? '';
      _priceController.text = widget.categoryForm.price.toString() ?? '';
      _descController.text = widget.categoryForm.description ?? '';
      _date = widget.categoryForm.date ?? 'Choose date';
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  String? _firstname;
  String? _lastname;
  String? _date = 'Choose date';
  String? _email;
  String? _phone;
  String? _city;
  String? _detailLocation;
  int? numberOfMember;
  bool _obscure = true;
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  _submit() async {
    final form = Provider.of<CreateFormProvider>(context,listen: false);
    if (!_formKey.currentState!.validate()) {
      if (!_autoValidate) setState(() => _autoValidate = true);
      return;
    }
    if(widget.categoryForm.formData != null
        && form.containsInputType(widget.categoryForm.formData!, 'photo') && _imageFile == null){
      ShowMyDialog.showMsg('Please select an image');
      return;
    }
    _formKey.currentState!.save();

    try {
      await form.createForm(
        id: widget.categoryForm.id!,
        title: widget.categoryForm.title,
        desc: widget.categoryForm.description,
        date: widget.categoryForm.date,
        price: widget.categoryForm.price,
        firstName: _firstname,
        lastName: _lastname,
        phone: _phone,
        city: _city,
        number: numberOfMember!,
        email: _email,
        detailLocation: _detailLocation,
        image: _imageFile,
      );
      showBottomSheetResponse('assets/JSON/done.json', "Congratulation !!",
        then:()=> GlobalMethods.navigateReplaceALL(context, const ControlView())
      );
    } catch (e) {
      Navigator.pop(context);
      showBottomSheetResponse('assets/JSON/warning.json', readableError(e));
      showCustomSnackBar(readableError(e), context, isError: true);
    }
  }

  _cancel() async {
    showBottomSheetResponse('assets/JSON/warning.json', 'readableError(e)', then: ()=> GlobalMethods.navigateReplaceALL(context, const ControlView()));
    // final form = Provider.of<CreateFormProvider>(context,listen: false);
    // if (!_formKey.currentState!.validate()) {
    //   if (!_autoValidate) setState(() => _autoValidate = true);
    //   return;
    // }
    // _formKey.currentState!.save();

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
      body:  PagesBackground(
        child: Stack(children: [
          // Image.asset(
          //   "assets/images/Screen.jpg",
          //   fit: BoxFit.cover,
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          // ),
          Consumer<CreateFormProvider>(
            builder: (context, formProvider, _) {
              return Form(
                key: _formKey,
                autovalidateMode:
                _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,

                child: ListView( children: [
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
                        Text(
                          tr('fill_information'),
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 50,
                        ),
                        Text(tr('title')),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 60,
                        ),
                        InputFormField(
                          hintText: tr('Enter title'),
                          enabled: false,
                          controller: _titleController,
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
                          height: MediaQuery.of(context).size.height / 50,
                        ),

                        Text(tr("price")),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 60,
                        ),
                        InputFormField(
                          hintText: tr('Enter price'),
                          enabled: false,
                          controller: _priceController,
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
                          height: MediaQuery.of(context).size.height / 50,
                        ),

                        Text(tr("description")),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 60,
                        ),
                        InputFormField(
                          hintText: tr('Enter Description'),
                          enabled: false,
                          controller: _descController,
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
                          height: MediaQuery.of(context).size.height / 50,
                        ),

                        if(widget.categoryForm.formData != null
                        && formProvider.containsInputType(widget.categoryForm.formData!, 'first_name'))
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tr('first_name')),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 60,
                            ),
                            InputFormField(
                              hintText: tr('enter_first_name'),
                              onSaved: (firstname) => _firstname = firstname,
                              prefixIcon: Image.asset('assets/icon/Profile.png'),
                              validator: Validator(
                                rules: [
                                  RequiredRule(
                                    validationMessage: tr('firstname_validation'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 60,
                            ),
                          ],
                        ),


                        if(widget.categoryForm.formData != null
                            && formProvider.containsInputType(widget.categoryForm.formData!, 'last_name'))
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tr('last_name')),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 60,
                              ),
                              InputFormField(
                                hintText: tr('enter_last_name'),
                                onSaved: (lastname) => _lastname = lastname,
                                prefixIcon: Image.asset('assets/icon/Profile.png'),
                                validator: Validator(
                                  rules: [
                                    RequiredRule(
                                      validationMessage: tr('lastname_validation'),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 60,
                              ),
                            ],
                          ),


                        if(widget.categoryForm.formData != null
                            && formProvider.containsInputType(widget.categoryForm.formData!, 'email'))
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tr("email")),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 60,
                              ),
                              InputFormField(
                                hintText: tr('Enter your email'),
                                onSaved: (lastname) => _lastname = lastname,
                                prefixIcon: Image.asset('assets/icon/Profile.png'),
                                validator: Validator(
                                  rules: [
                                    RequiredRule(
                                      validationMessage: tr('email_validation'),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 60,
                              ),
                            ],
                          ),


                        if(widget.categoryForm.formData != null
                            && formProvider.containsInputType(widget.categoryForm.formData!, 'phone'))
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tr('Phone Number')),
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
                            ],
                          ),


                        Text(tr('date')),
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
                              trailing: const Icon(Icons.arrow_drop_down),
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

                        if(widget.categoryForm.formData != null
                            && formProvider.containsInputType(widget.categoryForm.formData!, 'city'))
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tr('city')),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 60,
                            ),
                            InputFormField(
                              hintText: tr('enter_city'),
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
                          ],
                        ),


                        if(widget.categoryForm.formData != null
                            && formProvider.containsInputType(widget.categoryForm.formData!, 'Detail_Location'))
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tr('detail_location')),
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
                                tr('detail_location_desc'),
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
                          ],
                        ),


                        Text(tr("number_members")),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 70,
                        ),
                        CustomDropDown(list: formProvider.getNumberOfMembersList(widget.formUsers??[], widget.categoryForm.members!), onChange: (val){
                          print(val);
                          numberOfMember = val;
                        }, hintText: tr('choose_number'), validator: Validator(
                          rules: [
                            RequiredRule(
                              validationMessage: tr('number_validation'),
                            ),
                          ],
                        ),),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 60,
                        ),

                        if(widget.categoryForm.formData != null
                            && formProvider.containsInputType(widget.categoryForm.formData!, 'photo'))
                        AddAttachmentWidget(onFetchImage: (val){
_imageFile = val;
                        },),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: ()=> Navigator.pop(context),
                              child: Container(
                                height: 50,
                                width: 160,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.red)
                                ),
                                child: Center(
                                    child: Text(
                                  tr("cancel"),
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                  ),
                                )),
                              ),
                            ),
                            formProvider.formLoad ? const Center(child: CircularProgressIndicator()) : Button(
                                onpress: _submit,
                                buttonText: tr("done"),
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
                ]),
              );
            }
          )
        ]),
      ),
    );
  }

  void showBottomSheetResponse(String img, String msg, {Function? then}){
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
                child: Lottie.asset(img),
              ),
              SizedBox(
                height:
                MediaQuery.of(context).size.height /
                    60,
              ),
              Text(msg),
            ],
          ),
        );
      },
    ).then((value) => then != null ? then() : null);
  }
}
