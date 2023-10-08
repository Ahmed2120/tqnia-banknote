import 'dart:developer';
import 'dart:io';

import 'package:banknote/src/app/data/dio/dio_client.dart';
import 'package:banknote/src/app/data/models/user_model.dart';
import 'package:banknote/src/app/utils/data_status.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
export 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  final _api = DioClient.instance;

  UserModel? currentUser;

  bool get authLogged => currentUser != null;

  DataStatus? updateProfileStatus;

  Future<void> updateProfile(String firstName, String lastName, String email,
      {String? password, File? image}) async {
    try {
      updateProfileStatus = DataStatus.loading;
      notifyListeners();
      print(currentUser?.toJson());
      currentUser  = await _api.updateProfile(
        firstName: firstName ,
        lastName: lastName ,
        email: email,
        password: password,
        image: image,
      );
      print(currentUser?.toJson());
      if (currentUser!=null) {
        try {
          updateProfileStatus = DataStatus.success;
          notifyListeners();
        } catch (e) {
          log(e.toString());
          updateProfileStatus = DataStatus.error;
          notifyListeners();
        }
      } else {
        updateProfileStatus = DataStatus.error;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      updateProfileStatus = DataStatus.error;
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> register(UserModel user, String password) async {
    currentUser = await _api.register(user, password);
    notifyListeners();
  }

  Future<void> login(
    String email,
    String password,
  ) async {
    currentUser = await _api.login(
      email,
      password,
    );
    notifyListeners();
  }

  Future<UserModel?> autoLogin() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    //
    final isLoggedIn = await UserModel.isLoggedIn;
    //
    if (!isLoggedIn) return null;
    //
    try {} on DioError catch (e) {
      if (e.response?.statusCode == 401) await logout();
      return null;
    } catch (e) {
      return null;
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _api.logout().then((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      currentUser = null;
      await prefs.clear();
    });
    notifyListeners();
  }
}
