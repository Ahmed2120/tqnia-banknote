import 'package:banknote/src/app/data/models/notification_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../data/dio/dio_client.dart';

class ResetPasswordProvider with ChangeNotifier{

  final _api = DioClient.instance;

  List<NotificationModel> _notificationList = [];
  List<NotificationModel> get notificationList => _notificationList;


  bool _storeOtp_load = false;
  bool get storeOtpLoading => _storeOtp_load;

  bool _checkCode_load = false;
  bool get checkCodeLoading => _checkCode_load;

  bool _resetPassword_load = false;
  bool get resetPasswordLoading => _resetPassword_load;




  Future<bool> storeOtp(String phone) async {
    _storeOtp_load=true;
    notifyListeners();

    try{
     final isSuccess = await _api.storeOtp(phone);

      _storeOtp_load=false;
      notifyListeners();
      return isSuccess;
    }on DioException catch(e){
      print(',,,,,,,,,,,,,,,,,,,,,,,');
      print(e.response?.data);
      _storeOtp_load=false;
      notifyListeners();

      throw e.response!.data;
    }
    catch(e){
      _storeOtp_load=false;
      notifyListeners();

      rethrow;
    }
  }

  Future<bool> checkCode(String phone, int code) async {
    _checkCode_load=true;
    notifyListeners();

    try{
     final isSuccess = await _api.checkOtp(phone, code);

     _checkCode_load=false;
      notifyListeners();
      return isSuccess;
    }on DioException catch(e){
      print(',,,,,,,,,,,,,,,,,,,,,,,');
      print(e.response?.data);
      _checkCode_load=false;
      notifyListeners();

      throw e.response!.data;
    }
    catch(e){
      _checkCode_load=false;
      notifyListeners();

      rethrow;
    }
  }

  Future<bool> resetPassword(String phone, String password) async {
    _resetPassword_load=true;
    notifyListeners();

    try{
     final isSuccess = await _api.resetPassword(phone, password);

     _resetPassword_load=false;
      notifyListeners();
      return isSuccess;
    }on DioException catch(e){
      _resetPassword_load=false;
      notifyListeners();

      throw e.response!.data;
    }
    catch(e){
      _resetPassword_load=false;
      notifyListeners();

      rethrow;
    }
  }
}