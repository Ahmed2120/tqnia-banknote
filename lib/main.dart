import 'package:banknote/src/app/providers/app_provider.dart';
import 'package:banknote/src/app/providers/auth_provider.dart';
import 'package:banknote/src/app/providers/categories_provider.dart';
import 'package:banknote/src/app/providers/form_provider.dart';
import 'package:banknote/src/presentation/welcome_page/splash_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/app/providers/category_provider.dart';
import 'src/app/providers/lang_provider.dart';

void main() async{
  print('---------- main ------------');
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

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

        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              fontFamily: 'Poppins'
            ),
            home: const SplashPage());
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