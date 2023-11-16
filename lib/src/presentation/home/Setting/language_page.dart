import 'package:banknote/src/app/providers/lang_provider.dart';
import 'package:banknote/src/app/utils/color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/widgets/pages_background.dart';

class LanguagePage extends StatefulWidget {
  LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    getLang();
  }
  bool _keep1 = false;
 bool _keep2 = false;


  getLang() async{
    if(context.locale.languageCode == 'en'){
      print('11111111111');
      _keep1 = true;
    }else{
      _keep2 = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  PagesBackground(
        child: Stack(
          children: [
            // Image.asset("assets/images/Screen.jpg"),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 15,
                      ),
                      Center(child: Image.asset("assets/images/logodark.png")),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      Text(
                        tr("language"),
                        style: const TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      TextButton(
                        onPressed: () {
                          _keep1 = true;
                          _keep2 = false;

                          context.setLocale(const Locale('en'));
                          Provider.of<LangProvider>(context, listen: false).toggleLang(0);
                          setState(() {});
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(tr('en'),style: const TextStyle(color: Colors.black),),
                            _keep1
                                ? Image.asset('assets/icon/Check List Icon.png')
                                : Container(
                                    height: 22,
                                    width: 22,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                     color: p7,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _keep2 = true;
                          _keep1 = false;
                          context.setLocale(const Locale('ar'));
                          Provider.of<LangProvider>(context, listen: false).toggleLang(1);
                          setState(() {});
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(tr('ar'),style: const TextStyle(color: Colors.black),),
                            _keep2
                                ? Image.asset('assets/icon/Check List Icon.png')
                                : Container(
                                    height: 22,
                                    width: 22,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: p7,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ])),
          ],
        ),
      ),
    );
  }
}
