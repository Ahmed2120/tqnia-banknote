import 'dart:convert';
import 'dart:io';

import 'package:banknote/src/app/data/models/gift.dart';
import 'package:banknote/src/app/data/models/news.dart';
import 'package:banknote/src/app/utils/global_methods.dart';
import 'package:banknote/src/presentation/home/Chat/chatPage.dart';
import 'package:banknote/src/presentation/home/Notification/Notification_page.dart';
import 'package:banknote/src/presentation/home/gifts/gifts_page.dart';
import 'package:banknote/src/presentation/home/news/news.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart' as g;
import 'package:path_provider/path_provider.dart';

import '../main.dart';
import '../src/app/Controller/home_view_controller.dart';
import '../src/presentation/home/Home/bottomNavigationbar.dart';

class MyNotification {

  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    await FirebaseMessaging.instance.requestPermission();

    print('-----------FirebaseMessaging.instance.getToken()------------');
    print(await FirebaseMessaging.instance.getToken());

    var androidInitialize = const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const IOSInitializationSettings();
    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(
        initializationsSettings, onSelectNotification: (String? payload) async {

      try{
        if(payload != null && payload.isNotEmpty) {
              Map data = jsonDecode(payload);

              if (data['type'] == "news") {
                GlobalMethods.navigate(
                    NavigationService.navigatorKey.currentState!.context,
                    NewsPage(newsModel: NewsModel(newsTxt: data['body']),));
              }
              else if (data['type'] == "gifts") {
                GlobalMethods.navigate(
                    NavigationService.navigatorKey.currentState!.context,
                    GiftsPage(giftModel: GiftModel(giftTxt: data['body']),));
              }
              else if (data['type'] == "message") {
                g.Get.find<ControlViewModel>().changeSelectedValue(1);
              }

        }
      }catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('--------------------000000000000----------------------');
      if (kDebugMode) {
        print("onMessage: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
        print("----------------------------------------------");
        print("bode: ${message.notification!.body}");
      }
      showNotification(message, flutterLocalNotificationsPlugin, false);
    });
    // FirebaseMessaging.instance.getInitialMessage().then(handleNavigate);
    FirebaseMessaging.onMessageOpenedApp.listen(handleNavigate);
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  }

  static Future<void> showNotification(RemoteMessage message, FlutterLocalNotificationsPlugin fln, bool data) async {
    String? title;
    String? body;
    String? type;
    String? image;
    Map? bodyData;
    if(data) {
      title = message.data['title'];
      body = message.data['body'];
      type = message.data['type'];
      // image = (message.data['image'] != null && message.data['image'].isNotEmpty)
      //     ? message.data['image'].startsWith('http') ? message.data['image']
      //     : '${AppConstants.baseUrl}/storage/app/public/notification/${message.data['image']}' : null;
    }else {
      title = message.notification!.title;
      body = message.notification!.body;
      type = message.data['type'];
      bodyData = {'body': body, 'type': type};
      if(Platform.isAndroid) {
        // image = (message.notification!.android!.imageUrl != null && message.notification!.android!.imageUrl!.isNotEmpty)
        //     ? message.notification!.android!.imageUrl!.startsWith('http') ? message.notification!.android!.imageUrl
        //     : '${AppConstants.baseUrl}/storage/app/public/notification/${message.notification!.android!.imageUrl}' : null;
      }else if(Platform.isIOS) {
        // image = (message.notification!.apple!.imageUrl != null && message.notification!.apple!.imageUrl!.isNotEmpty)
        //     ? message.notification!.apple!.imageUrl!.startsWith('http') ? message.notification!.apple!.imageUrl
        //     : '${AppConstants.baseUrl}/storage/app/public/notification/${message.notification!.apple!.imageUrl}' : null;
      }
    }

    if(image != null && image.isNotEmpty) {
      try{
        await showBigPictureNotificationHiddenLargeIcon(title, body, type, image, fln);
      }catch(e) {
        await showBigTextNotification(title, body!, type, fln);
      }
    }else {
      await showBigTextNotification(title, body!, jsonEncode(bodyData), fln);
    }
  }

  static Future<void> showTextNotification(String title, String body, String type, FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', playSound: true,
      importance: Importance.max, priority: Priority.max, sound: RawResourceAndroidNotificationSound('notification'),
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: type);
  }

  static Future<void> showBigTextNotification(String? title, String body, String? payload, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body, htmlFormatBigText: true,
      contentTitle: title, htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', importance: Importance.max,
      styleInformation: bigTextStyleInformation, priority: Priority.max, playSound: true,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: payload);
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(String? title, String? body, String? orderID, String image, FlutterLocalNotificationsPlugin fln) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath), hideExpandedLargeIcon: true,
      contentTitle: title, htmlFormatContentTitle: true,
      summaryText: body, htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name',
      largeIcon: FilePathAndroidBitmap(largeIconPath), priority: Priority.max, playSound: true,
      styleInformation: bigPictureStyleInformation, importance: Importance.max,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final Response response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));
    final File file = File(filePath);
    await file.writeAsBytes(response.data);
    return filePath;
  }

}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('==================================');
    print("onBackground: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
  }
}

Future<dynamic> handleNavigate(RemoteMessage? message) async {
  if(message == null) return;

  if(message.data != {}) {
    if (message.data['type'] == "news") {
      GlobalMethods.navigate(
          NavigationService.navigatorKey.currentState!.context,
          NewsPage());
    }
    else if (message.data['type'] == "gifts") {
      GlobalMethods.navigate(
          NavigationService.navigatorKey.currentState!.context,
          GiftsPage());
    }
    else if (message.data['type'] == "message") {
      g.Get.find<ControlViewModel>().changeSelectedValue(1);
    }
  }
}