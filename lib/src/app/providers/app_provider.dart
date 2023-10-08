import 'package:banknote/src/app/data/dio/dio_client.dart';
import 'package:banknote/src/app/utils/app_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
export 'package:provider/provider.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() {
    _loadCurrentTheme();
  }

  final _api = DioClient.instance;


  Future<String?> getFCMToken() async {
    String? fcmToken;
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    await firebaseMessaging.getToken().then((token) {
      fcmToken = token;
    });
    return fcmToken;
  }

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  void toggleTheme() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    _darkTheme = !_darkTheme;
    sharedPreferences.setBool(AppConstants.THEME, _darkTheme);
    notifyListeners();
  }

  void _loadCurrentTheme() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    _darkTheme = sharedPreferences.getBool(AppConstants.THEME) ?? true;
    notifyListeners();
  }
}
