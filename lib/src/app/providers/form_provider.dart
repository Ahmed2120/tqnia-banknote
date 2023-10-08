import 'dart:io';
export 'package:provider/provider.dart';
import 'package:banknote/src/app/data/dio/dio_client.dart';
import 'package:banknote/src/app/data/models/form_model.dart';

import 'package:flutter/material.dart';

FormModel? form;
final _api = DioClient.instance;

class CreateFormProvider extends ChangeNotifier {
  Future<void> createForm(
      String firstName, String phone, String city, String detailLocation,
      {File? image}) async {
    form = await _api.createForm(
      firstName: firstName,
      phone: phone,
      image: image,
      city: city,
      detailLocation: detailLocation,
    );

    notifyListeners();
  }
}
