import 'dart:io';
import 'package:banknote/main.dart';
import 'package:banknote/src/app/data/models/category_model.dart';
import 'package:banknote/src/app/data/models/form_model.dart';
import 'package:banknote/src/app/data/models/message.dart';
import 'package:banknote/src/app/data/models/user_model.dart';
import 'package:banknote/src/app/providers/auth_provider.dart';
import 'package:banknote/src/app/utils/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../models/gift.dart';
import '../models/news.dart';
import '../models/notification_model.dart';

class DioClient {
  //Singleton
  DioClient._() {
    // Attach Logger
    if (kDebugMode) _dio.interceptors.add(_logger);
  }

  static final DioClient instance = DioClient._();

  // Http Client
  final Dio _dio = Dio();

  // Logger
  final PrettyDioLogger _logger = PrettyDioLogger(
    requestBody: true,
    responseBody: true,
    requestHeader: true,
    error: true,
  );

  // Headers
  final Map<String, dynamic> _apiHeaders = <String, dynamic>{
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  ////////////////////////////// END POINTS ///////////////////////////////////
  static const String _createPhone = "auth/createPhone";
  static const String _registerEndPoint = "auth/register";
  static const String _loginEndPoint = "auth/login";
  static const String _device_token = "auth/device_token";
  static const String _store_otp = "auth/storeOtpCode";
  static const String _checkotp = "auth/checkCode";
  static const String _resetPassword = "auth/resetPassword";
  static const String _logoutEndPoint = "logout";
  static const String _updateProfileEndPoint = "editProfile";
  static const String _createFormEndPoint = "forms/user-form";
  static const String _news = "sitting/news_for_you";
  static const String _gift = "sitting/gifts";
  static const String _getNotification = "notifications/show";
  static const String _deleteNotification = "notifications/deleteAll";
  static const String _getOrSendMessages = "chat"; // if get => get all msgs else if post => send msg
  static final String _categoriesPoint =
      "categories/allCategories_";
  static final String _subCategoriesPoint =
      "categories/allSubCategories_";
  static final String _categoryDetailsPoint =
      "categories/allSubSubCategories_";
  ////////////////////////////// METHODS //////////////////////////////////////

  Future<UserModel> register(UserModel user, String password) async {
    final response = await _dio.post(
      '${Connection.baseURL}$_registerEndPoint',
      data: {
        ...user.toJson(),
        'password': password,
        'password_confirmation': password,
      },
      options: Options(
        headers: _apiHeaders,
      ),
    );
    if (response.data['status'] == true && response.data['data'].isNotEmpty) {
      return UserModel.fromJson(response.data['data'],
          token: response.data['token']);
    } else {
      throw response.data;
    }
  }

  Future<UserModel> login(
    String email,
    String password,
  ) async {
    final response = await _dio.post(
      '${Connection.baseURL}$_loginEndPoint',
      data: {
        'email': email,
        'password': password,
      },
      options: Options(
        headers: _apiHeaders,
      ),
    );
    if (response.data['status'] == true && response.data['data'].isNotEmpty) {
      return UserModel.fromJson(response.data['data'],
          token: response.data['token']);
    } else {
      throw response.data;
    }
  }

  Future<bool> logout() async {
    final token = await _getUserToken();

    final response = await _dio.post(
      '${Connection.baseURL}$_logoutEndPoint',
      options: Options(
        headers: {
          ..._apiHeaders,
          'Authorization': token,
        },
      ),
    );
    if (response.data['error'] == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<UserModel> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    String? password,
    File? image,
  }) async {
    final token = await _getUserToken();
    FormData data = FormData.fromMap({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      if (password != null && password.length >= 8) ...{
        'password': password,
      },
      if (image != null) 'photo': await MultipartFile.fromFile(image.path),
    }, ListFormat.multiCompatible);

    final response = await _dio.post(
      '${Connection.baseURL}$_updateProfileEndPoint',
      data: data,
      queryParameters: {
        '_method': "PUT",
      },
      options: Options(
        headers: {
          ..._apiHeaders,
          'Authorization': token,
        },
      ),
    );
    print('=====================');
    print(response);
    if (response.data['status'] == true) {
      return UserModel.fromJson(response.data["data"]);
    } else {
      throw response.data;
    }
  }

  Future updateDeviceToken(
      String userId,
      ) async {
    final deviceToken = await _getDeviceToken();

    final response = await _dio.post(
      '${Connection.baseURL}$_device_token',
      data: {
        'device_token': deviceToken,
        'user_id': userId,
      },
      options: Options(
        headers: _apiHeaders,
      ),
    );
    if (response.data['status'] == true && response.data['data'].isNotEmpty) {
      print(response.data);
    } else {
      throw response.data;
    }
  }

  Future deleteNotification(
      int userId,
      ) async {

    final token = await _getUserToken();


      final response = await _dio.get(
        '${Connection.baseURL}$_deleteNotification',
        queryParameters: {
          'user_id': userId,
        },
        options: Options(
          headers: {
            ..._apiHeaders,
            'Authorization': token,
          },
        ),
      );
      if (response.data['status'] == true && response.data['data'].isNotEmpty) {
        return response.data['message'];
      } else {
        throw response.data;
      }

  }

  Future createPhone(
      String phone,
      ) async {


      final response = await _dio.post(
        '${Connection.baseURL}$_createPhone',
        data: {
          'phone': phone,
        },
        options: Options(
          headers: {
            ..._apiHeaders,
          },
        ),
      );
      if (response.data['status'] == true) {
        return true;
      } else {
        throw response.data;
      }

  }

  Future storeOtp(
      String phone,
      ) async {


      final response = await _dio.get(
        '${Connection.baseURL}$_store_otp',
        queryParameters: {
          'phone': phone,
        },
        options: Options(
          headers: {
            ..._apiHeaders,
          },
        ),
      );
      if (response.data['status'] == true) {
        return true;
      } else {
        throw response.data;
      }

  }

  Future checkOtp(
      String phone,
      int code,
      ) async {


      final response = await _dio.get(
        '${Connection.baseURL}$_checkotp',
        queryParameters: {
          'phone': phone,
          'code': code,
        },
        options: Options(
          headers: {
            ..._apiHeaders,
          },
        ),
      );
      if (response.data['status'] == true) {
        return true;
      } else {
        throw response.data;
      }

  }

  Future resetPassword(
      String phone,
      String password,
      ) async {


      final response = await _dio.get(
        '${Connection.baseURL}$_resetPassword',
        queryParameters: {
          'phone': phone,
          'password': password,
        },
        options: Options(
          headers: {
            ..._apiHeaders,
          },
        ),
      );
      if (response.data['status'] == true) {
        return true;
      } else {
        throw response.data;
      }

  }


  Future<CategoryModel> getCategories() async {
    final token = await _getUserToken();
    try{
      final response = await _dio.get(
        '${Connection.baseURL}$_categoriesPoint${NavigationService.currentContext.locale.languageCode}',
        options: Options(
          headers: {
            ..._apiHeaders,
            'Authorization': token,
          },
        ),
      );
      if (response.data['status'] == true) {
        return CategoryModel.fromJson(response.data);
      } else {
        throw response.data;
      }
    } on DioException catch(e){
      print('llllllllllllllll');
      print(e);
      rethrow;
    }
    catch(e){
      rethrow;
    }
  }

  Future<List<NotificationModel>> getNotifications(int userId) async {
    final token = await _getUserToken();

      final response = await _dio.get(
        '${Connection.baseURL}$_getNotification',
        queryParameters: {
          'user_id': userId,
        },
        options: Options(
          headers: {
            ..._apiHeaders,
            'Authorization': token,
          },
        ),
      );
      if (response.data['status'] == true) {
        final notificationList = response.data['data'].map<NotificationModel>((e)=> NotificationModel.fromJson(e)).toList();
        return notificationList;
      } else {
        throw response.data;
      }
  }

  Future<List<MessageModel>> getMessages() async {
    final token = await _getUserToken();

      final response = await _dio.get(
        '${Connection.baseURL}$_getOrSendMessages',
        options: Options(
          headers: {
            ..._apiHeaders,
            'Authorization': token,
          },
        ),
      );
      if (response.data['status'] == true) {
        final notificationList = response.data['data'].map<MessageModel>((e)=> MessageModel.fromJson(e)).toList();
        return notificationList;
      } else {
        throw response.data;
      }
  }

  Future sendMessage(
      String message,
      ) async {

    final token = await _getUserToken();


    final response = await _dio.post(
      '${Connection.baseURL}$_getOrSendMessages',
      data: {
        'message': message,
      },
      options: Options(
        headers: {
          ..._apiHeaders,
          'Authorization': token,
        },
      ),
    );
    if (response.data['status'] == true && response.data['data'].isNotEmpty) {
      return response.data['status'];
    } else {
      throw response.data;
    }

  }

  Future<CategoryModel> getSubCategories(int id) async {
    final token = await _getUserToken();
    final response = await _dio.get(
      '${Connection.baseURL}$_subCategoriesPoint${NavigationService.currentContext.locale.languageCode}',
      queryParameters: {"id": id},
      options: Options(
        headers: {
          ..._apiHeaders,
          'Authorization': token,
        },
      ),
    );
    if (response.data['status'] == true) {
      return CategoryModel.fromJson(response.data);
    } else {
      throw response.data;
    }
  }

  Future<CategoryModel> getCategoryDetails(int id) async {
    final token = await _getUserToken();
    final response = await _dio.get(
      '${Connection.baseURL}$_categoryDetailsPoint${NavigationService.currentContext.locale.languageCode}',
      queryParameters: {"id": id},
      options: Options(
        headers: {
          ..._apiHeaders,
          'Authorization': token,
        },
      ),
    );
    if (response.data['status'] == true) {
      return CategoryModel.fromJson(response.data);
    } else {
      throw response.data;
    }
  }

  Future<NewsModel> getNews() async {
    final token = await _getUserToken();
    final response = await _dio.get(
      '${Connection.baseURL}$_news',
      options: Options(
        headers: {
          ..._apiHeaders,
          'Authorization': token,
        },
      ),
    );
    print(response.data);
    if (response.data['status'] == true) {
      return NewsModel.fromJson(response.data);
    } else {
      throw response.data;
    }
  }

  Future<GiftModel> getGift() async {
    final token = await _getUserToken();
    final response = await _dio.get(
      '${Connection.baseURL}$_gift',
      options: Options(
        headers: {
          ..._apiHeaders,
          'Authorization': token,
        },
      ),
    );
    if (response.data['status'] == true) {
      return GiftModel.fromJson(response.data);
    } else {
      throw response.data;
    }
  }

Future<FormModel> createForm({
    required int? id,
    required String? firstName,
    required String? lastName,
    required String? title,
    required String? email,
    required String? desc,
    required String? date,
    required String? phone,
    required String? city,
    required String? detailLocation,
    required int? price,
    required int? number,
    File? image,
  }) async {
    final token = await _getUserToken();
    FormData data = FormData.fromMap({
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'title': title,
      'email': email,
      'description': desc,
      'date': date,
      'phone': phone,
      'city': city,
      'Detail_Location': detailLocation,
      'number': number,
      if (image != null) 'photo': await MultipartFile.fromFile(image.path),
    }, ListFormat.multiCompatible);

    final response = await _dio.post(
      '${Connection.baseURL}$_createFormEndPoint',
      data: data,
   
      options: Options(
        headers: {
          ..._apiHeaders,
          'Authorization': token,
        },
      ),
    );
    if (response.data['status'] == true) {
      return FormModel.fromJson(response.data["data"]);
    } else {
      throw response.data;
    }
  }
  ///////////////////////////////// UTILS /////////////////////////////////////
  // Getting User Token.
  Future<String?> _getUserToken() async => await UserModel.getToken;

  Future<String?> _getDeviceToken() async {
    String? deviceToken;
    if(Platform.isIOS) {
      deviceToken = await FirebaseMessaging.instance.getAPNSToken();
    }else {
      deviceToken = await FirebaseMessaging.instance.getToken();
    }

    if (deviceToken != null) {
      if (kDebugMode) {
        print('--------Device Token---------- $deviceToken');
      }
    }
    return deviceToken;
  }
}
