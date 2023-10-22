import 'package:banknote/src/app/data/models/notification_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../data/dio/dio_client.dart';

class NotificationProvider with ChangeNotifier{

  final _api = DioClient.instance;

  List<NotificationModel> _notificationList = [];
  List<NotificationModel> get notificationList => _notificationList;

  bool _unReadNoti = false;
  bool get unReadNoti => _unReadNoti;

  bool _notification_load = false;
  bool get notificationLoad => _notification_load;

  bool _delete_notification_load = false;
  bool get deleteNotificationLoad => _delete_notification_load;




  Future<void> getNotification(int userId) async {
    _notification_load=true;
    notifyListeners();

    try{
      _notificationList = await _api.getNotifications(userId);

      _notification_load=false;
      notifyListeners();
    }on DioException catch(e){
      print(',,,,,,,,,,,,,,,,,,,,,,,');
      print(e.response?.data);
      _notification_load=false;
      notifyListeners();

      throw e.response!.data;
    }
    catch(e){
      _notification_load=false;
      notifyListeners();

      rethrow;
    }
  }

  Future<String> deleteNotification(int userId) async {
    _delete_notification_load=true;
    notifyListeners();

    try{
      final deleteMsg = await _api.deleteNotification(userId);

      _notificationList.clear();

      _delete_notification_load=false;
      notifyListeners();
      return deleteMsg;
    }on DioException catch(e){
      _delete_notification_load=false;

      notifyListeners();
      print(e.response!.data);
      throw e.response!.data;
    }
    catch(e){
      _delete_notification_load=false;
      notifyListeners();

      rethrow;
    }


  }

  void changeUnreadNoti(bool value){
    _unReadNoti = value;
    notifyListeners();
  }
}