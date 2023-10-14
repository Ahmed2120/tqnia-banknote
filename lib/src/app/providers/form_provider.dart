import 'dart:io';
export 'package:provider/provider.dart';
import 'package:banknote/src/app/data/dio/dio_client.dart';
import 'package:banknote/src/app/data/models/category_form_model.dart';
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

  bool containsInputType(List<FormData> formData, String type){
    for(var i in formData){
      if(i.inputName == type){
        return true;
      }
    }
    return false;
  }

  List<int> getNumberOfMembersList(List<FormUsers> formUsers, int members){
    final List<int> NumMembers = [];
    for(int i = 1; i <= members; i++){
      NumMembers.add(i);
    }

    for(var i in formUsers){
      NumMembers.remove(i.number);
    }

    return NumMembers;
  }
}
