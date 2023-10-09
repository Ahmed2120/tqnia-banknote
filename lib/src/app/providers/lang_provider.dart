import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangProvider with ChangeNotifier{
  LangProvider() {
    loadFromPrefs();
  }
  Locale _locale = Locale('en');
  String? _languageCode;
  Locale get local => _locale;


  final String key = "local";
  SharedPreferences? prefs;

  bool _darkTheme = true;

  bool get darkTheme { return _darkTheme;}


  loadFromPrefs() async {
    await _initPrefs();
    // _languageCode = prefs!.getString(key) ?? 'en';
    _locale = Locale(prefs!.getString(key) ?? 'en');
    print('after ${_locale!.languageCode}');
    notifyListeners();
  }
  _initPrefs() async {
    prefs ??= await SharedPreferences.getInstance(); // if prefs = null it take a value
  }

  toggleLang(int lang) {
    if(lang == 0){
      _locale = Locale('en');
    }
    else{
      _locale = Locale('ar');
    }
    saveToPrefs();
    notifyListeners();
  }

  saveToPrefs() async {
    await _initPrefs();
    prefs!.setString(key, _locale!.languageCode);
    print('----------------');
    print(prefs!.get(key));
  }
}