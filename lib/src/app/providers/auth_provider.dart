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
  bool _remember = false;

  bool get remember => _remember;

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
          storeUserData();
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
    }on DioException catch (e){
      final error = e.response == null ? e.message : e.response!.data;
      updateProfileStatus = DataStatus.error;
      notifyListeners();
      throw error;
    } catch (e) {
      log(e.toString());
      updateProfileStatus = DataStatus.error;
      notifyListeners();
      rethrow;
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

    if(_remember) {
      storeUserData();
    }
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
      // currentUser = null;
      clearUserData();
    });
    notifyListeners();
  }

  changeRemember(bool? val){
    _remember = !_remember;

    notifyListeners();
  }

  storeUserData() async{
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool('remember', _remember);

    prefs.setInt('id', currentUser!.id!);
    prefs.setString('fname', currentUser!.fName!);
    prefs.setString('lname', currentUser!.lName!);
    prefs.setString('email', currentUser!.email!);
    prefs.setString('phone', currentUser!.phone!);
    prefs.setString('photo', currentUser!.photo!);
  }

  getUserData() async{
    final prefs = await SharedPreferences.getInstance();

    currentUser = UserModel(
      id: prefs.getInt('id'),
      fName: prefs.getString('fname'),
      lName: prefs.getString('lname'),
      email: prefs.getString('email'),
      phone: prefs.getString('phone'),
      photo: prefs.getString('photo'),
    );
  }

  clearUserData() async{
    final prefs = await SharedPreferences.getInstance();

    prefs.remove('remember');

    prefs.remove('id');
    prefs.remove('fname');
    prefs.remove('lname');
    prefs.remove('email');
    prefs.remove('phone');
    prefs.remove('photo');

    _remember = false;
  }



}
