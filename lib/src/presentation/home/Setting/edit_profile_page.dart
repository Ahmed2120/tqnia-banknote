import 'dart:io';

import 'package:banknote/src/app/data/dio/exception/dio_error_extention.dart';
import 'package:banknote/src/app/providers/app_provider.dart';
import 'package:banknote/src/app/utils/data_status.dart';
import 'package:banknote/src/app/widgets/input_form_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:banknote/src/app/providers/auth_provider.dart';
import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/app/utils/utils.dart';
import 'package:banknote/src/app/widgets/button.dart';
import 'package:banknote/src/app/widgets/custom_snackbar.dart';
import 'package:banknote/src/presentation/home/Setting/widget/icon_container.dart';
import 'package:banknote/src/presentation/auth/widget/arrow_back_cont.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiver/strings.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String? _firstname;
  String? _lastname;
  String? _email;
  String? _password;
  bool _obscure = true;
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  _submit() async {
    final auth = context.read<AuthProvider>();
    if (!_formKey.currentState!.validate()) {
    
      if (!_autoValidate) setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState!.save();
    try {
      await auth.updateProfile(
        _firstname!,
        _lastname!,
        _email!,
        password: _password,
        image: _imageFile,
      );
    } catch (e) {
      Navigator.pop(context);
      showCustomSnackBar(readableError(e), context, isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = context.watch<AuthProvider>().currentUser;
    return Scaffold(
      body: Form(
         key: _formKey,
        autovalidateMode:
            _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Stack(children: [
          Image.asset(
            "assets/images/Screen.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Row(
                  children: [
                    ArrowBackContainer(
                      onpress: () {
                        Get.back();
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3.8,
                    ),
                    Image.asset("assets/images/logodark.png")
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 33,
                ),
                const Text("Edit Profile"),
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: (_imageFile != null)
                            ? Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(_imageFile!),
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10000.0),
                                child: CachedNetworkImage(
                                  imageUrl: "https://banknote.dev.tqnia.me/admin/images/${user?.photo}" ,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                      ),
                      IconContainer(
                        isGradient: true,
                        hasShadow: true,
                        height: 37,
                        width: 37,
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return bottomSheet();
                              });
                        },
                        iconColor: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 33,
                ),
                const Text("First Name"),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                InputFormField(
                  hintText: tr('username'),
                  onSaved: (firstname) => _firstname = firstname,
                  initialValue: user?.fName ?? '',
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
                const Text("Last Name"),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                InputFormField(
                  hintText: tr('username'),
                  onSaved: (lastname) => _lastname = lastname,
                  initialValue: user?.lName ?? '',
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
                const Text("Email"),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                InputFormField(
                  hintText: tr('email'),
                  onSaved: (email) => _email = email,
                  prefixIcon: Image.asset('assets/icon/Message.png'),
                  initialValue: user?.email ?? '',
                  keyboardType: TextInputType.emailAddress,
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
                  height: MediaQuery.of(context).size.height / 50,
                ),
                const Text("Password"),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
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
                      Icons.remove_red_eye,
                      color:
                          _obscure ? null : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 33,
                ),  auth.updateProfileStatus == DataStatus.loading
                          ? const Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2.5),
                              ),
                            )
                          :
                Center(
                  child: Button(
                      onpress: _submit,
                      buttonText: "Save",
                      textColor: Colors.white,
                      buttonColor: p1,
                      buttonRadius: 20,
                      buttonHight: 60,
                      buttonWidth: 350,
                      textSize: 18),
                )
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Choose Profile Photo",
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              TextButton.icon(
                icon: const Icon(
                  Icons.camera,
                ),
                onPressed: () {
                  _getImage(ImageSource.camera);
                },
                label: const Text("camera"),
              ),
              TextButton.icon(
                icon: const Icon(
                  Icons.image,
                ),
                onPressed: () {
                  _getImage(ImageSource.gallery);
                },
                label: const Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }
}
