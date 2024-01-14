import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../../main.dart';
import '../../../app/widgets/pages_background.dart';
import '../../auth/widget/arrow_back_cont.dart';

class PolicyPage extends StatelessWidget {
  Future<String> _loadJsonData() async {
    return NavigationService.currentContext.locale.languageCode == "en" ? await rootBundle.loadString('assets/JSON/policy.json') : await rootBundle.loadString('assets/JSON/policyAr.json');
  }

  Future<List<dynamic>> _loadData() async {
    String jsonString = await _loadJsonData();

    final jsonResponse = await json.decode(jsonString);

    return jsonResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  PagesBackground(
          child: Stack(children: [
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
              Align(alignment: Alignment.center,child: Image.asset('assets/images/logo.png'),),
              const SizedBox(height: 20,),
              Row(
                children: [
                  ArrowBackContainer(
                    onpress: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.8,
                  ),
                  Text(
                    tr("privacy_policy"),
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),

              Expanded(
                child: FutureBuilder(
                  future: _loadData(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.hasData) {
                      List<dynamic> data = snapshot.data!;
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(
                              data[index]['title'],
                              style: const TextStyle(
                                fontSize: 19,
                                color: Colors.white
                              ),
                            ),
                            subtitle: Text(
                              data[index]['description'],
                              style: const TextStyle(
                                fontSize: 17,
                                  color: Color(0xffA29EB6)
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 30,),
            ]))
    ]),
        ));
  }
}
