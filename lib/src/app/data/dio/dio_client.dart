import 'dart:io';
import 'package:banknote/main.dart';
import 'package:banknote/src/app/data/models/category_model.dart';
import 'package:banknote/src/app/data/models/form_model.dart';
import 'package:banknote/src/app/data/models/user_model.dart';
import 'package:banknote/src/app/utils/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

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
  static const String _registerEndPoint = "auth/register";
  static const String _loginEndPoint = "auth/login";
  static const String _logoutEndPoint = "logout";
  static const String _updateProfileEndPoint = "editProfile";
  static const String _createFormEndPoint = "forms/user-form";
  static final String _categoriesPoint =
      "categories/allCategories_${NavigationService.currentContext.locale.languageCode}";
  static final String _categoryDetailsPoint =
      "categories/allSubSubCategories_${NavigationService.currentContext.locale.languageCode}";
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
    if (response.data['status'] == true) {
      return UserModel.fromJson(response.data["data"]);
    } else {
      throw response.data;
    }
  }

  Future<CategoryModel> getCategories() async {
    final token = await _getUserToken();
    final response = await _dio.get(
      '${Connection.baseURL}$_categoriesPoint',
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
      '${Connection.baseURL}$_categoryDetailsPoint',
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
Future<FormModel> createForm({
    required String firstName,
    required String phone,
    required String city,
    required String detailLocation,
    File? image,
  }) async {
    final token = await _getUserToken();
    FormData data = FormData.fromMap({
      'first_name': firstName,
      'phone': phone,
      'city': city,
      'Detail_Location': detailLocation,
      'id': 3,
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
}
