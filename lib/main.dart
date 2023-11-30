import 'package:banknote/src/app/providers/app_provider.dart';
import 'package:banknote/src/app/providers/auth_provider.dart';
import 'package:banknote/src/app/providers/categories_provider.dart';
import 'package:banknote/src/app/providers/form_provider.dart';
import 'package:banknote/src/app/providers/gift_provider.dart';
import 'package:banknote/src/app/providers/news_provider.dart';
import 'package:banknote/src/presentation/auth/pages/otp_page.dart';
import 'package:banknote/src/presentation/welcome_page/splash_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'notification/my_notification.dart';
import 'pusher/pusher_config.dart';
import 'src/app/providers/category_provider.dart';
import 'src/app/providers/chat_provider.dart';
import 'src/app/providers/lang_provider.dart';
import 'firebase_options.dart';
import 'src/app/providers/notification_provider.dart';
import 'src/app/providers/reset_password_provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async{
  print('---------- main ------------');
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  // print('=====================================');
  // await PusherConfig().initialize();
  // print('=====================================');

  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();


  await MyNotification.initialize(flutterLocalNotificationsPlugin);
  final RemoteMessage? remoteMessage =
  await FirebaseMessaging.instance.getInitialMessage();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/languages',
      assetLoader: RootBundleAssetLoader(),
      useOnlyLangCode: true,
      saveLocale: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => LangProvider(),
          ),
          ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(),
          ),
          ChangeNotifierProvider<CategoriesProvider>(
            create: (_) => CategoriesProvider(),
          ),
          ChangeNotifierProvider<CategoryProvider>(
            create: (_) => CategoryProvider(),
          ),
           ChangeNotifierProvider<CreateFormProvider>(
            create: (_) => CreateFormProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => NewsProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => GiftProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => NotificationProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ChatProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ResetPasswordProvider(),
          ),

        ],
        child: MyApp(remoteMessage: remoteMessage,),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.remoteMessage});

  final RemoteMessage? remoteMessage;

  @override
  Widget build(BuildContext context) {
    return Consumer<LangProvider>(
      builder: (context, langProvider, _) {
        print(context.locale.languageCode);
        context.setLocale(langProvider.local);

        return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: langProvider.local,
               navigatorKey: NavigationService.navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: context.locale.languageCode == 'en' ? 'Tajawal' : 'Bahij'
            ),

            home: SplashPage(remoteMessage: remoteMessage,));
      }
    );
  }
}
class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext get currentContext =>
      NavigationService.navigatorKey.currentContext!;
}
//  DevicePreview(
//       enabled: true,
//       isToolbarVisible: true,
//       defaultDevice: DevicePreview.defaultDevices.firstWhere(
//         (device) => device.name == "Small",
//       ),
//       
//       tools: const [
//         ...DevicePreview.defaultTools,
//       ],
//       builder: (_) => const