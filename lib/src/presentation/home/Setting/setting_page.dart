import 'package:banknote/src/app/providers/auth_provider.dart';
import 'package:banknote/src/app/utils/global_methods.dart';
import 'package:banknote/src/presentation/home/Setting/edit_profile_page.dart';
import 'package:banknote/src/presentation/home/Category/our_category.dart';
import 'package:banknote/src/presentation/home/Policy/policy_page.dart';
import 'package:banknote/src/presentation/home/Setting/language_page.dart';
import 'package:banknote/src/presentation/home/Setting/widget/setting_widget.dart';
import 'package:banknote/src/presentation/welcome_page/start_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/widgets/pages_background.dart';
import '../../auth/pages/signin_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    return Scaffold(
      body:  PagesBackground(
        child: SingleChildScrollView(
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height / 30,
                    // ),
                    // Center(child: CircleAvatar(
                    //     backgroundColor: Colors.black38,
                    //     radius: 50,
                    //     child: Image.asset("assets/images/logodark.png"))),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height / 60,
                    // ),
                    // Text(
                    //   tr('settings'),
                    //   style: TextStyle(fontSize: 22, color: Colors.white),
                    // ),
                    // const SizedBox(
                    //   height: 25,
                    // ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10000.0),
                          child: CachedNetworkImage(
                            imageUrl: user?.photo ?? '',
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${user!.fName} ${user.lName}",
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
const SizedBox(height: 10,),
                            Text(
                              tr('joined ${user!.createdAt != null ?GlobalMethods().dateFormat(user!.createdAt!) : ''}'),
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                            )
                          ],
                        ),

                      ],
                    ),
                    const SizedBox(height: 20,),
                    InformationWidget(
                      infoText: tr('edit_profile'),
                      onpress: () {
                        GlobalMethods.navigate(context, const EditProfilePage());
                      },
                    ),
                    const SizedBox(height: 10,),
                    InformationWidget(
                      infoText: tr('my_service'),
                      onpress: () {
                        GlobalMethods.navigate(context, const OurCategory());
                      },
                    ),

                    const SizedBox(height: 10,),
                    InformationWidget(
                      infoText: tr('privacy_policy'),
                      onpress: () {
                        GlobalMethods.navigate(context, PolicyPage());
                      },
                    ),

                    const SizedBox(height: 10,),
                    InformationWidget(
                      infoText: tr('language'),
                      onpress: () {
                        GlobalMethods.navigate(context, LanguagePage(), then: (){setState(() {print(',,,,,,,sett........');});});
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await context
                            .read<AuthProvider>()
                            .logout()
                            .then((value) => Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) => const SignInPage(),
                                ),
                                (route) => false));
                      },
                      child: Text(
                        tr('sign_out'),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
