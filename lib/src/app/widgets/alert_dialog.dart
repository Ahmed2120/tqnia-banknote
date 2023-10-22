import 'package:flutter/material.dart';

import '../../../main.dart';

class ShowMyDialog  {

  static  void showMsg(msg, {bool isError = false}){
    showDialog<void>(
        context: NavigationService.navigatorKey.currentContext!,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
// title: const Text('يوجد خطأ ما'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if(isError) Image.asset('assets/icon/warning.png', width: 50,),
                const SizedBox(height: 15,),
                Text(
                  '${msg}',
                  style: const TextStyle
                    (
                      fontWeight: FontWeight.w900,
                      fontSize: 18
                  ),

                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('ok'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        } );
  }

  static  void showMore(String? msg,){
    showDialog<void>(
        context: NavigationService.navigatorKey.currentContext!,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
// title: const Text('يوجد خطأ ما'),
            content: Container(
              height: 200,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      msg??'',
                      style: const TextStyle
                        (
                          fontWeight: FontWeight.w900,
                          fontSize: 18
                      ),

                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('ok'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        } );
  }
  static void showSnack(context , String msg){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            dismissDirection:DismissDirection.up,
            backgroundColor: Colors.deepPurple,
            elevation: 10,
            content: Text(
              msg ,
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900
              ),
              textAlign: TextAlign.center,
            )

        ) );
  }
}