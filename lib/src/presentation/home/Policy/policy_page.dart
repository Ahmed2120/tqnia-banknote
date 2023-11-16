import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../app/widgets/pages_background.dart';

class PolicyPage extends StatelessWidget {
  Future<String> _loadJsonData() async {
    return await rootBundle.loadString('assets/JSON/policy.json');
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
              Center(child: Image.asset("assets/images/logodark.png")),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              const Text(
                "Privacy Policy",
                style: TextStyle(fontSize: 20),
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
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              data[index]['description'],
                              style: const TextStyle(
                                fontSize: 12,
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
